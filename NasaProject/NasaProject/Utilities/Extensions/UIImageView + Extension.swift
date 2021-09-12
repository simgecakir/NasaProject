//
//  UIImageView + Extension.swift
//  NasaProject
//
//  Created by Simge Çakır on 8.09.2021.
//

import UIKit
import Kingfisher

extension UIImageView {
    
    func loadImage(from url: String, placeHolder: UIImage?){
        guard let url = URL(string: url) else { print("Invalid Image"); return }
        self.kf.indicatorType = .activity
        self.kf.setImage(with: url, placeholder: placeHolder, options: [.fromMemoryCacheOrRefresh])
    }
    
}
