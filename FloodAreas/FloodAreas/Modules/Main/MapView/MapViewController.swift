//
//  MapViewController.swift
//  FloodAreas
//
//  Created by KaiNgo on 12/02/2023.
//

import UIKit
import MapKit
import RxSwift
import RxCocoa
import SwiftMessages

class MapViewController: BaseViewController {
    
    // map view
    lazy var mapView: MKMapView = {
        let mapView = MKMapView()
        mapView.translatesAutoresizingMaskIntoConstraints = false
        mapView.mapType = .standard
        return mapView
    }()
    
    var viewModel: MapViewModel = MapViewModel(input: MapViewModel.Input(floodAreaDetail: BehaviorRelay<[Feature]>(value: [])),
                                               dependency: AppAPIService())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupViewModel()
    }
}

// MARK: Setup view controller with view model.
extension MapViewController: ViewControllerViewModelProtocol {
    func setupViewModel() {
        if let input = viewModel.input {
            bindingInput(input: input)
        }
        if let output = viewModel.output {
            bindingOutput(output: output)
        }
    }
    
    private func bindingInput(input: MapViewModel.Input) {
        input.floodAreaDetail.asDriver()
            .drive(onNext: { [weak self] data in
                guard let self = self else { return }
                data.forEach { feature in
                    // show on map.
                    if let coordinates = feature.geometry?.coordinates {
                        if coordinates.count < 2 {
                            return
                        }
                        let long = coordinates[0]
                        let lat = coordinates[1]
                        self.mapView.showCoordinateAt(lat: lat, lon: long, mainFeature: feature)
                    }
                }
            }).disposed(by: disposeBag)
    }
    
    private func bindingOutput(output: MapViewModel.Output) {
    }
}


// MARK: MKMapView Delegate.
extension MapViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if let item = annotation as? FloodAnnotation {
            let annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "mapItem")
            ?? MKAnnotationView(annotation: annotation, reuseIdentifier: "mapItem")
            
            annotationView.annotation = item
            let icon = UIImage(named: "ic_placemark")
            annotationView.image = icon?.scaleImage(toSize: CGSize(width: 15, height: 15))
            annotationView.clusteringIdentifier = "mapItemClustered"
            
            return annotationView
        } else if let cluster = annotation as? MKClusterAnnotation {
            let clusterView = mapView.dequeueReusableAnnotationView(withIdentifier: "clusterView")
            ?? MKAnnotationView(annotation: annotation, reuseIdentifier: "clusterView")
            
            clusterView.annotation = cluster
            let icon = UIImage(named: "ic_app")
            clusterView.image = icon?.scaleImage(toSize: CGSize(width: 15, height: 15))
            
            return clusterView
        } else {
            return nil
        }
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        if let currentAnnotation = view.annotation as? FloodAnnotation, let  myFeature = currentAnnotation.myFeature {
            let detailVC = DetailViewController()
            detailVC.viewModel = DetailViewModel(input: DetailViewModel.Input(floodAreaDetail: BehaviorRelay<Feature>(value: myFeature)),
                                                 dependency: AppAPIService())
            self.navigationController?.pushViewController(detailVC, animated: true)
        }
        // de-selected annotation on the mapview.
        mapView.deselectAnnotation(view.annotation, animated: true)
    }
}




