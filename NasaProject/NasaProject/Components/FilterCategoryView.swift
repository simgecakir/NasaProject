//
//  FilterCategoryView.swift
//  NasaProject
//
//  Created by Simge Çakır on 11.09.2021.
//

import UIKit

struct FilterCategoryModel {
    let categoryName: String
    let categoryChoice: String?
}

final class FilterCategoryView: UIView{
    
    fileprivate let categoryLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 17)
        label.textColor = .black
        return label
    }()
    
    let choiceTextField: UITextField = {
        let textField = UITextField()
        textField.font = .systemFont(ofSize: 15)
        textField.textColor = .black
        textField.textAlignment = .center
        return textField
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        bindViews()
        self.clipsToBounds = true
        self.layer.cornerRadius = 15
        self.backgroundColor = .lightGray
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with model: FilterCategoryModel){
        categoryLabel.text = model.categoryName
        if let choice = model.categoryChoice{
            choiceTextField.text = choice
        }
    }
    
    private func bindViews(){
        
        addSubview(categoryLabel)
        categoryLabel.snp.makeConstraints{ (make) in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(15)
            make.width.equalTo(100)
            make.height.equalTo(20)
        }
        
        addSubview(choiceTextField)
        choiceTextField.snp.makeConstraints{ (make) in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().offset(-15)
            make.width.equalTo(100)
            make.height.equalTo(20)
        }
    }
    
}
