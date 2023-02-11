//
//  ViewController.swift
//  FloodAreas
//
//  Created by KaiNgo on 06/02/2023.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa
import SVProgressHUD

class MainViewController: UIViewController, RxViewController {
    var disposeBag: DisposeBag = DisposeBag()
    
    var viewModel = MainViewModel(input: MainViewModel.Input(floodAreaData: BehaviorRelay<[BehaviorRelay<FloodArea>]>(value: []),
                                                             loadFloodAreaDataTrigger:
                                                                PublishRelay<()>(),
                                                             isLoading: BehaviorRelay<(Bool, String)>(value: (false, ""))),
                                   dependency: AppAPIService())
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupView()
        setupViewModel()
        
        // Load data from sever.
        self.viewModel.input?.loadFloodAreaDataTrigger.accept(())
    }

}

// MARK: View Controller Protocol.
extension MainViewController: ViewControllerProtocol {
    func setupView() {
        // setup custom view
    }
    
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

