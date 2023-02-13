//
//  DetailViewController.swift
//  FloodAreas
//
//  Created by KaiNgo on 13/02/2023.
//

import UIKit
import RxSwift
import RxCocoa
import MapKit

class DetailViewController: BaseViewController {
    // map view
    lazy var mapContainterView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var floodMapView: MKMapView = {
        let mapView = MKMapView()
        mapView.translatesAutoresizingMaskIntoConstraints = false
        mapView.mapType = .standard
        return mapView
    }()
    
    // content view
    lazy var contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var subStrubLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "Suburd: "
        lbl.numberOfLines = 3
        return lbl
    }()
    
    lazy var mainStresstLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "Main Stresst: "
        lbl.numberOfLines = 3
        return lbl
    }()
    
    lazy var adviceLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "Advice: "
        lbl.numberOfLines = 3
        return lbl
    }()
    
    lazy var otherAdviceLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "Other Advice: "
        lbl.numberOfLines = 3
        return lbl
    }()
    
    var viewModel: DetailViewModel?
    
    fileprivate var annotation: MKAnnotation!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupView()
        setupViewModel()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.title = "Detail"
    }
    
    /// Set current coordinate.
    /// - Parameters:
    ///   - lat: lat. Float value.
    ///   - lon: lon. Float value.
    func showCoordinateAt(lat: Float, lon: Float) {
        let center = CLLocationCoordinate2D(latitude: CLLocationDegrees(lat), longitude: CLLocationDegrees(lon))
        
        let currentRegion = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
        self.floodMapView.setRegion(currentRegion, animated: true)

        if !self.floodMapView.annotations.isEmpty {
            annotation = self.floodMapView.annotations[0]
            self.floodMapView.removeAnnotation(annotation)
        }
        let pointAnnotation = MKPointAnnotation()
        pointAnnotation.coordinate = CLLocationCoordinate2D(latitude: CLLocationDegrees(lat), longitude: CLLocationDegrees(lon))
        floodMapView.addAnnotation(pointAnnotation)
    }
}

// MARK: Setup view controller with view model.
extension DetailViewController: ViewControllerViewModelProtocol {
    func setupViewModel() {
        guard let vm = self.viewModel else { return }
        if let input = vm.input {
            bindingInput(input: input)
        }
        if let output = vm.output {
            bindingOutput(output: output)
        }
    }
    
    private func bindingInput(input: DetailViewModel.Input) {
        input.floodAreaDetail.asDriver()
            .drive(onNext: { [weak self] data in
                guard let self = self else { return }
                self.subStrubLabel.text! += data.properties?.roads?.first?.suburb ?? ""
                self.mainStresstLabel.text! += data.properties?.roads?.first?.mainStreet ?? ""
                self.adviceLabel.text! += data.properties?.adviceA ?? ""
                self.otherAdviceLabel.text! += data.properties?.otherAdvice ?? ""
                
                AppLog.d("Current cor: \(data.geometry?.coordinates)")
                // show on map.
                if let coordinates = data.geometry?.coordinates{
                    if coordinates.count < 2 {
                        return
                    }
                    let long = coordinates[0]
                    let lat = coordinates[1]
                    self.showCoordinateAt(lat: lat, lon: long)
                }
            }).disposed(by: disposeBag)
    }
    
    private func bindingOutput(output: DetailViewModel.Output) {
    }
}

extension DetailViewController: MKMapViewDelegate {
    // MARK: - change default icon
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "annotation")
        let icon = UIImage(named: "ic_placemark")
        annotationView.image = icon?.scaleImage(toSize: CGSize(width: 15, height: 15))
        annotationView.canShowCallout = true
        return annotationView
    }
}

