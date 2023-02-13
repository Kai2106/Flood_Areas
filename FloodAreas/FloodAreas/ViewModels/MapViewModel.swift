//
//  MapViewModel.swift
//  FloodAreas
//
//  Created by KaiNgo on 13/02/2023.
//

import RxCocoa
import RxSwift

class MapViewModel: ViewModelProtocol {
    
    typealias Dependency = AppAPIService
    
    struct Input {
        // Data
        let floodAreaDetail               : BehaviorRelay<[Feature]>
    }
    
    struct Output {
    }
    
    var input: Input?
    
    var output: Output?
    
    var dependency: Dependency?
    
    init(input: Input, dependency: Dependency) {
        self.input = input
        self.dependency = dependency
        self.output = self.transform(input: self.input, dependency: self.dependency)
    }
    
    func transform(input: MapViewModel.Input?, dependency: AppAPIService?) -> MapViewModel.Output? {
        self.input = input
        
        self.dependency = dependency
        
        guard let ip = input else {
            return nil
        }
        
        return MapViewModel.Output()
    }
    
}
