//
//  DetailViewController+ViewFactory.swift
//  FloodAreas
//
//  Created by KaiNgo on 13/02/2023.
//

import Foundation
import SnapKit

extension DetailViewController: ViewFactoryProtocol {
    func setupView() {
        setupMapView()
        setupContentView()
    }
    
    private func setupMapView() {
        self.view.addSubview(mapContainterView)
        mapContainterView.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(Constants.MARGIN_TOP)
            make.right.equalToSuperview().offset(Constants.MARGIN_RIGHT)
            make.left.equalToSuperview().offset(Constants.MARGIN_LEFT)
            make.height.equalTo(200)
        }
        
        //
        self.mapContainterView.addSubview(floodMapView)
        floodMapView.delegate = self
        floodMapView.setDefaultRegion()
        self.floodMapView.snp.makeConstraints { make in
            make.top.left.right.bottom.equalToSuperview().offset(Constants.MARGIN_ZERO)
        }
    }
    
    private func setupContentView() {
        self.view.addSubview(contentView)
        
        contentView.snp.makeConstraints { make in
            make.top.equalTo(mapContainterView.snp.bottom).offset(Constants.MARGIN_TOP)
            make.right.equalToSuperview().offset(Constants.MARGIN_RIGHT)
            make.left.equalToSuperview().offset(Constants.MARGIN_LEFT)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom).offset(Constants.MARGIN_BOTTOM)
        }
        
        //
        self.contentView.addSubview(self.subStrubLabel)
        self.contentView.addSubview(self.mainStresstLabel)
        self.contentView.addSubview(self.adviceLabel)
        self.contentView.addSubview(self.otherAdviceLabel)
        
        self.subStrubLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(Constants.MARGIN_TOP)
            make.right.equalToSuperview().offset(Constants.MARGIN_RIGHT)
            make.left.equalToSuperview().offset(Constants.MARGIN_LEFT)
            make.bottom.equalTo(self.mainStresstLabel.snp.top).offset(Constants.MARGIN_BOTTOM)
        }
        
        self.mainStresstLabel.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(Constants.MARGIN_RIGHT)
            make.left.equalToSuperview().offset(Constants.MARGIN_LEFT)
            make.bottom.equalTo(self.adviceLabel.snp.top).offset(Constants.MARGIN_BOTTOM)
        }
        
        self.adviceLabel.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(Constants.MARGIN_RIGHT)
            make.left.equalToSuperview().offset(Constants.MARGIN_LEFT)
            make.bottom.equalTo(self.otherAdviceLabel.snp.top).offset(Constants.MARGIN_BOTTOM)
        }
        
        self.otherAdviceLabel.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(Constants.MARGIN_RIGHT)
            make.left.equalToSuperview().offset(Constants.MARGIN_LEFT)
            make.bottom.lessThanOrEqualTo(self.contentView.snp.bottom).offset(Constants.MARGIN_BOTTOM)
        }
    }
    
}
