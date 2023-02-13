//
//  MainViewController+ViewFactory.swift
//  FloodAreas
//
//  Created by KaiNgo on 12/02/2023.
//

import SVProgressHUD
import SnapKit
import RxSwift
import RxCocoa

// MARK: Setup custom view.
extension MainViewController: ViewControllerCustomViewProtocol {
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

// MARK: Setup view controller with view model.
extension MainViewController: ViewControllerViewModelProtocol {
    func setupViewModel() {
        if let input = self.viewModel.input {
            bindingInput(input: input)
        }
        if let output = self.viewModel.output {
            bindingOutput(output: output)
        }
    }
    
    private func bindingInput(input: MainViewModel.Input) {
        // show loading.
        input.isLoading.asDriver()
            .drive { loadingData in
                if loadingData.0 {
                    SVProgressHUD.show()
                } else {
                    SVProgressHUD.dismiss()
                }
            }
            .disposed(by: disposeBag)
    }
    
    private func bindingOutput(output: MainViewModel.Output) {
        // handle data output.
        output.floodAreaDataResult
            .bind { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .ok(data: let data):
                    AppLog.v("final data: \(data)")
                    self.listVC.viewModel = ListViewModel(input: ListViewModel.Input(floodAreaData: BehaviorRelay<[Feature]>(value: data.features ?? [])),
                                                          dependency: AppAPIService())
                    break
                case .error(error: let error):
                    AppLog.v("error: \(error.localizedDescription)")
                    MessageManager.shared.showMessage(messageType: .error, message: error.localizedDescription)
                    break
                }
            }
            .disposed(by: disposeBag)
    }
}


