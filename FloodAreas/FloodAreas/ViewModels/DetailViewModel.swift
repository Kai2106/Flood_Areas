//
//  DetailViewModel.swift
//  FloodAreas
//
//  Created by KaiNgo on 13/02/2023.
//

import RxCocoa
import RxSwift

class DetailViewModel: ViewModelProtocol  {
    typealias Dependency = AppAPIService
    
    struct Input {
        // Data
        let floodAreaDetail               : BehaviorRelay<Feature>
    }
    
    struct Output {
        
    }
    
    var input: Input?
    
    var output: Output?
    
    var dependency: Dependency?
    
    init(input: Input, dependency: Dependency) {
        self.input = input
        self.dependency = dependency
    }
    
    func transform(input: DetailViewModel.Input?, dependency: AppAPIService?) -> DetailViewModel.Output? {
        return DetailViewModel.Output()
    }
    
}
