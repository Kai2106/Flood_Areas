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

class ListViewController: BaseViewController {
    
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

// MARK: Setup view controller with view model.
extension ListViewController: ViewControllerViewModelProtocol {
    func setupViewModel() {
        guard let vm = self.viewModel else { return }
        if let input = vm.input {
            bindingInput(input: input)
        }
        if let output = vm.output {
            bindingOutput(output: output)
        }
    }
    
    private func bindingInput(input: ListViewModel.Input) {
        
    }
    
    private func bindingOutput(output: ListViewModel.Output) {
        // update tableview data source
        output.sections
            .drive(self.tableView.rx.items(dataSource: self.dataSource))
            .disposed(by: disposeBag)
    }
}

// MARK: Setup view controller with list view controller.
extension ListViewController: ListViewControllerProtocol {
    func registerCell() {
        tableView.register(ListTableViewCell.self, forCellReuseIdentifier: ListTableViewCell.cellIdent)
    }
    
    func configDataSource() {
        // add data source
        self.dataSource = FloodAreaDatasource(configureCell: { (dataSource, tv, indexPath, data) in
            let cell: ListTableViewCell = tv.dequeueReusableCell(withIdentifier: ListTableViewCell.cellIdent, for: indexPath) as! ListTableViewCell
            //cell.delegate = self
            cell.indexPath = indexPath
            cell.feature = data
            
            return cell
        }, titleForHeaderInSection: { _,_  -> String? in
            return ""
        }, titleForFooterInSection: { _,_  -> String? in
            return ""
        }, canEditRowAtIndexPath: { ds,indexPath  -> Bool in
            return false
        }, canMoveRowAtIndexPath: {ds,indexPath  -> Bool in
            return false
        })
        // tableview action.
        self.tableView.rx.itemSelected
            .asDriver()
            .drive { [weak self] indexPath in
                guard let self = self else { return }
                //
                if let data = self.viewModel?.input?.floodAreaData.value[indexPath.row] {
                    let detailVC = DetailViewController()
                    detailVC.viewModel = DetailViewModel(input: DetailViewModel.Input(floodAreaDetail: BehaviorRelay<Feature>(value: data)),
                                                         dependency: AppAPIService())
                    self.navigationController?.pushViewController(detailVC, animated: true)
                }
            }.disposed(by: disposeBag)
    }
}



