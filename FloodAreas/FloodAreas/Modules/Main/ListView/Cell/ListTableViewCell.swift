//
//  ListTableViewCell.swift
//  FloodAreas
//
//  Created by KaiNgo on 12/02/2023.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa
import SDWebImage

protocol ListTableViewCellDelegate: AnyObject {
    func ituneCellTapFavorite(withData data: Feature, atIndexPath indexPath: IndexPath)
}

class ListTableViewCell: UITableViewCell {
    
    static var cellIdent: String = "ListTableViewCell"
    
    lazy var backGroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "ic_flood")
        return imageView
    }()
    
    lazy var suburbLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = UIFont.systemFont(ofSize: 15)
        lbl.textColor = .darkGray
        lbl.numberOfLines = 2
        return lbl
    }()
    
    lazy var mainStreetLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = UIFont.systemFont(ofSize: 13)
        lbl.textColor = .lightGray
        lbl.numberOfLines = 1
        return lbl
    }()
    
    lazy var moveNextImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "arrow.right")
        return imageView
    }()
    
    var indexPath: IndexPath!
    
    var feature: Feature? {
        didSet {
            guard let feature = feature else {
                return
            }
            self.suburbLabel.text = feature.properties?.adviceA
            self.mainStreetLabel.text = feature.properties?.roads?[0].mainStreet
        }
    }
    
    // Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.suburbLabel.text = ""
        self.mainStreetLabel.text = ""
    }
}

extension ListTableViewCell {
    func setupView(){
        setupBackGroupView()
        setupDataView()
    }
    
    private func setupBackGroupView() {
        contentView.addSubview(backGroundView)
        //
        backGroundView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(5)
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-10)
            make.bottom.equalToSuperview().offset(-5)
        }
        //
        backGroundView.layer.cornerRadius = 5
        backGroundView.layer.borderWidth = 0.3
        backGroundView.layer.borderColor = UIColor.systemGray.withAlphaComponent(0.5).cgColor
        backGroundView.clipsToBounds = true
        layoutIfNeeded()
    }
    
    private func setupDataView() {
        backGroundView.addSubview(iconImageView)
        backGroundView.addSubview(suburbLabel)
        backGroundView.addSubview(mainStreetLabel)
        backGroundView.addSubview(moveNextImageView)
        
        // icon image
        iconImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(10)
            make.width.height.equalTo(40)
        }
        
        // sender label.
        suburbLabel.snp.makeConstraints { make in
            make.top.equalTo(self.backGroundView.snp.top).offset(Constants.MARGIN_TOP)
            make.left.equalTo(self.iconImageView.snp.right).offset(Constants.MARGIN_LEFT)
            make.right.equalTo(self.moveNextImageView.snp.left).offset(Constants.MARGIN_RIGHT)
        }
        
        // time label.
        mainStreetLabel.snp.makeConstraints { make in
            make.top.equalTo(self.suburbLabel.snp.bottom).offset(Constants.MARGIN_ZERO)
            make.left.equalTo(self.iconImageView.snp.right).offset(Constants.MARGIN_LEFT)
            make.right.equalTo(self.moveNextImageView.snp.left).offset(Constants.MARGIN_RIGHT)
            make.bottom.greaterThanOrEqualTo(self.backGroundView.snp.bottom).offset(Constants.MARGIN_BOTTOM)
        }
        
        // next image.
        moveNextImageView.snp.makeConstraints { make in
            make.width.height.equalTo(20)
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(Constants.MARGIN_RIGHT)
        }

    }
    
}
