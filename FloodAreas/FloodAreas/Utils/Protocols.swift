//
//  Protocols.swift
//  FloodAreas
//
//  Created by KaiNgo on 11/02/2023.
//

import Foundation
import RxSwift

protocol ViewControllerCustomViewProtocol {
    func setupView()
}

protocol ViewControllerViewModelProtocol {
    func setupViewModel()
}

protocol ListViewControllerProtocol {
    func registerCell()

    func configDataSource()
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
