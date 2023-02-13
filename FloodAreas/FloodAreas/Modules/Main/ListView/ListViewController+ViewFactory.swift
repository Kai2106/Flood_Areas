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
extension ListViewController: ViewFactoryProtocol {
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
