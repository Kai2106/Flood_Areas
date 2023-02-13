//
//  MapViewController+ViewFactory.swift
//  FloodAreas
//
//  Created by KaiNgo on 13/02/2023.
//

import UIKit
import SnapKit

extension MapViewController: ViewFactoryProtocol {
    func setupView() {
        setupMapView()
    }
    
    private func setupMapView() {
        self.view.addSubview(mapView)
        mapView.delegate = self
        mapView.setDefaultRegion()
        self.mapView.snp.makeConstraints { make in
            make.top.left.right.bottom.equalToSuperview().offset(Constants.MARGIN_ZERO)
        }
    }
}
