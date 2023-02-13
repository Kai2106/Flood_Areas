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

class MainViewController: UIViewController, RxViewController {
    var disposeBag: DisposeBag = DisposeBag()
    
    lazy var segment: UISegmentedControl = {
        let seg = UISegmentedControl(items: ["Map View", "List View"])
        seg.translatesAutoresizingMaskIntoConstraints = false
        return seg
    }()
    
    lazy var pageVC: UIPageViewController = {
        let page = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        page.view.translatesAutoresizingMaskIntoConstraints = false
        return page
    }()
    
    lazy var listVC: ListViewController = {
        let vc = ListViewController()
        return vc
    }()
    
    lazy var mapVC: MapViewController = {
        let vc = MapViewController()
        return vc
    }()
    
    private var pendingPageIndex: Int = 0
    var currentPageIndex: Int = 0
    var views = [UIViewController]()
    
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
    
    @objc func changeSegmentValue(sender: UISegmentedControl) {
        if views.isEmpty { return }
        
        let index = sender.selectedSegmentIndex
        self.view.endEditing(true)
        if sender.selectedSegmentIndex > currentPageIndex {
            pageVC.setViewControllers([views[index]], direction: .forward, animated: true, completion: nil)
        } else {
            pageVC.setViewControllers([views[index]], direction: .reverse, animated: true, completion: nil)
        }
        currentPageIndex = index
    }
}

// MARK: UI Page View Controller DataSource + Delegate
extension MainViewController: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        guard let viewControllerIndex = views.firstIndex(of: viewController) else { return nil }
        
        let previousIndex = viewControllerIndex - 1
        guard views.count > previousIndex && previousIndex >= 0 else { return nil}
        return views[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = views.firstIndex(of: viewController) else { return nil }
        
        let nextIndex = viewControllerIndex + 1
        guard views.count > nextIndex else { return nil }
        return views[nextIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, willTransitionTo pendingViewControllers: [UIViewController]) {
        pendingPageIndex = views.firstIndex(of: pendingViewControllers.first!)!
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if completed {
            currentPageIndex = pendingPageIndex
            segment.selectedSegmentIndex = currentPageIndex
        }
    }
}
