//
//  MainViewModel.swift
//  FloodAreas
//
//  Created by KaiNgo on 11/02/2023.
//

import RxCocoa
import RxSwift

class MainViewModel: ViewModelProtocol {
    
    typealias Dependency = AppAPIService
    
    struct Input {
        
        // Data
        let floodAreaData               : BehaviorRelay<[BehaviorRelay<FloodArea>]>
        
        // Trigger
        let loadFloodAreaDataTrigger    : PublishRelay<()>
        
        let isLoading                   : BehaviorRelay<(Bool,String)>
        
    }
    
    struct Output  {
        let floodAreaDataResult         : Observable<APIResult<FloodArea>>
    }
    
    var input      : Input?
    
    var output     : Output?
    
    var dependency : Dependency?
    
    init(input: Input, dependency: Dependency) {
        self.input = input
        self.dependency = dependency
        self.output = self.transform(input: self.input, dependency: self.dependency)
    }
    
    func transform(input: MainViewModel.Input?, dependency: AppAPIService?) -> MainViewModel.Output? {
        self.input = input
        
        self.dependency = dependency
        
        guard let ip = input, let dp = dependency else {
            return nil
        }
        
        let dataResult = ip.loadFloodAreaDataTrigger.asObservable()
            .do(onNext: { _ in
                ip.isLoading.accept((true, "Loading"))
            })
            .flatMap { _ -> Observable<APIResult<FloodArea>> in
                return dp.getFloodAreaData()
            }
            .do(onNext: { _ in
                ip.isLoading.accept((false, "Stop loading"))
            })
                
        return MainViewModel.Output(floodAreaDataResult: dataResult)
    }
    
}
