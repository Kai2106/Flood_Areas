//
//  ListViewModel.swift
//  FloodAreas
//
//  Created by KaiNgo on 12/02/2023.
//

import RxCocoa
import RxSwift
import RxDataSources

typealias FloodAreaSection = SectionModel<String, Feature>
class ListViewModel: ViewModelProtocol {
    typealias Dependency = AppAPIService
    
    struct Input {
        // Data
        let floodAreaData               : BehaviorRelay<[Feature]>
    }
    
    struct Output {
        
        // Sections
        let sections                    : Driver<[FloodAreaSection]>
    }
    
    var input: Input?
    
    var output: Output?
    
    var dependency: Dependency?
    
    init(input: Input, dependency: Dependency) {
        self.input = input
        self.dependency = dependency
        self.output = self.transform(input: self.input, dependency: self.dependency)
    }
    
    func transform(input: ListViewModel.Input?, dependency: AppAPIService?) -> ListViewModel.Output? {
        self.input = input
        
        self.dependency = dependency
        
        guard let ip = input, let dp = dependency else {
            return nil
        }
        
        let sections = ip.floodAreaData.asDriver().map { datas -> [FloodAreaSection] in
            return [FloodAreaSection(model: "Flood Area Section", items: datas)]
        }
        
        return ListViewModel.Output(sections: sections)
    }
}
