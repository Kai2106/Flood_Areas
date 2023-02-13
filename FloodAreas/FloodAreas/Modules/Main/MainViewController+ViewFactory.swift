//
//  MainViewController+ViewFactory.swift
//  FloodAreas
//
//  Created by KaiNgo on 12/02/2023.
//

import SnapKit
import RxSwift
import RxCocoa

// MARK: Setup custom view.
extension MainViewController: ViewFactoryProtocol {
    func setupView() {
        self.view.backgroundColor = .white
        // setup custom view
        setupSegment()
        setupPageView()
    }
    
    private func setupSegment() {
        //
        segment.selectedSegmentIndex = 0
        segment.addTarget(self, action: #selector(changeSegmentValue), for: .valueChanged)
        // add segment view
        self.view.addSubview(segment)
        self.segment.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(Constants.MARGIN_ZERO)
            make.height.equalTo(50)
            make.centerX.equalToSuperview()
        }
        
    }
    
    private func setupPageView() {
        views.removeAll()
        views.append(mapVC)
        views.append(listVC)
        
        // setup page view controler.
        pageVC.dataSource = self
        pageVC.delegate = self
        //
        addChild(pageVC)
        view.addSubview(pageVC.view)
        pageVC.didMove(toParent: self)
        
        pageVC.view.snp.makeConstraints { make in
            make.top.equalTo(self.segment.snp.bottom).offset(Constants.MARGIN_TOP)
            make.left.equalToSuperview().offset(Constants.MARGIN_LEFT)
            make.right.equalToSuperview().offset(Constants.MARGIN_RIGHT)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom).offset(Constants.MARGIN_BOTTOM)
        }
        
        self.pageVC.setViewControllers([self.views[0]], direction: .forward, animated: true, completion: nil)
    }
    
}
