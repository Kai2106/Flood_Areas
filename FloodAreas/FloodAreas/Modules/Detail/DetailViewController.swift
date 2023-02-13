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
    
    lazy var diversionsLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "Diversions: "
        lbl.numberOfLines = 3
        return lbl
    }()
    
    var viewModel: DetailViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupView()
        setupViewModel()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.title = "Detail"
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
                self.diversionsLabel.text! += data.properties?.diversions ?? ""
                
                // show on map.
                if let coordinates = data.geometry?.coordinates{
                    if coordinates.count < 2 {
                        return
                    }
                    let long = coordinates[0]
                    let lat = coordinates[1]
                    self.floodMapView.showCoordinateAt(lat: lat, lon: long)
                }
            }).disposed(by: disposeBag)
    }
    
    private func bindingOutput(output: DetailViewModel.Output) {
    }
}

extension DetailViewController: MKMapViewDelegate {
    // MARK: - change default icon
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let identifier = "detailview_annotation"
        var view: MKPinAnnotationView
        if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKPinAnnotationView {
            dequeuedView.annotation = annotation
            view = dequeuedView
        } else {
            view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            let icon = UIImage(named: "ic_placemark")
            view.image = icon?.scaleImage(toSize: CGSize(width: 15, height: 15))
        }
        return view
    }
}

