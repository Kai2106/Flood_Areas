//
//  ListViewController+ViewFactory.swift
//  FloodAreas
//
//  Created by KaiNgo on 12/02/2023.
//

import SnapKit
import RxSwift
import RxCocoa
import RxDataSources

// MARK: Setup custom view.
extension ListViewController: ViewControllerCustomViewProtocol {
    func setupView() {
        setupTableView()
    }
    
    private func setupTableView() {
        self.view.addSubview(self.tableView)
        
        self.tableView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(0)
            make.bottom.equalToSuperview().offset(0)
            make.left.equalToSuperview().offset(0)
            make.right.equalToSuperview().offset(0)
        }
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
        output.sections.drive(self.tableView.rx.items(dataSource: self.dataSource))
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
        
        //
    }
}

