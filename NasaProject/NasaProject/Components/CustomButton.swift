//
//  CustomButton.swift
//  NasaProject
//
//  Created by Simge Çakır on 10.09.2021.
//

import UIKit

struct CustomButtonModel{
    let title: String
    let backgroundColor: UIColor
}

final class CustomButton: UIButton{
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.clipsToBounds = true
        self.layer.cornerRadius = 10
        self.titleLabel?.font = .boldSystemFont(ofSize: 10)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with model: CustomButtonModel){
        self.backgroundColor = model.backgroundColor
        self.setTitleColor(backgroundColor == .black ? .white:.black, for: .normal)
        self.setTitle(model.title, for: .normal)
    }
}
