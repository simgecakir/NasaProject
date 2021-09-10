//
//  TitleLabel.swift
//  NasaProject
//
//  Created by Simge Çakır on 9.09.2021.
//

import UIKit
import SnapKit

struct InfoViewModel{
    let title: String
    let detail: String
}

final class InfoView: UIView{
    
    private let titleLabel: UILabel = {
       let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 17)
        return label
    }()
    
    private let detailLabel: UILabel = {
       let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        bindViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with model: InfoViewModel){
        titleLabel.text = model.title
        detailLabel.text = ":  \(model.detail)"
    }
    
    private func bindViews(){
        
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints{ (make) in
            make.top.bottom.leading.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.4)
        }
        
        addSubview(detailLabel)
        detailLabel.snp.makeConstraints{ (make) in
            make.top.bottom.trailing.equalToSuperview()
            make.leading.equalTo(titleLabel.snp.trailing).offset(10)
        }
    }
    
}
