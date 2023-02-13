//
//  ListViewViewController.swift
//  FloodAreas
//
//  Created by KaiNgo on 12/02/2023.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

typealias FloodAreaDatasource = RxTableViewSectionedReloadDataSource<FloodAreaSection>

class ListViewController: UIViewController, RxViewController {
    var disposeBag = DisposeBag()
    
    lazy var tableView: UITableView = {
        let table =  UITableView()
        table.register(ListTableViewCell.self, forCellReuseIdentifier: ListTableViewCell.cellIdent)
        table.rowHeight = 80
        table.tableFooterView = nil
        table.translatesAutoresizingMaskIntoConstraints = false
        table.separatorStyle = .none
        return table
    }()
    
    var viewModel: ListViewModel?
    
    var dataSource: FloodAreaDatasource!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerCell()
        configDataSource()
        setupView()
        setupViewModel()
    }
}
