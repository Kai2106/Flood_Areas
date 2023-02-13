//
//  BaseViewController.swift
//  FloodAreas
//
//  Created by KaiNgo on 13/02/2023.
//

import UIKit
import RxSwift

class BaseViewController: UIViewController, RxViewController {
    var disposeBag: DisposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
    }
}
