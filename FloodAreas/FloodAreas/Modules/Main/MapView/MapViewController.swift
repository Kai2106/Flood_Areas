//
//  MapViewController.swift
//  FloodAreas
//
//  Created by KaiNgo on 12/02/2023.
//

import UIKit
import RxSwift

class MapViewController: UIViewController, RxViewController {
    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .yellow
    }
}
