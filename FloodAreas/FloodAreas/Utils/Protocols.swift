//
//  Protocols.swift
//  FloodAreas
//
//  Created by KaiNgo on 11/02/2023.
//

import Foundation
import RxSwift

protocol ViewControllerProtocol {
    func setupView()

    func setupViewModel()
}

protocol ViewModelProtocol {
    associatedtype Dependency
    associatedtype Input
    associatedtype Output

    var input: Input? { get set }
    var output: Output? { get set }
    var dependency: Dependency? { get set }

    @discardableResult
    func transform(input: Input?, dependency: Dependency?) -> Output?
}

protocol RxViewController where Self: UIViewController {
    var disposeBag: DisposeBag {get set}
}
