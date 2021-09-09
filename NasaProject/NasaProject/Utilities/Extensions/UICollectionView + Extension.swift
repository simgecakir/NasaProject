//
//  UICollectionView + Extension.swift
//  NasaProject
//
//  Created by Simge Çakır on 8.09.2021.
//

import UIKit

extension UICollectionView {
    
    func register<T: UICollectionViewCell>(cellType: T.Type) {
        register(cellType, forCellWithReuseIdentifier: cellType.identifier)
    }
    
    func dequeCell<T: UICollectionViewCell>(cellType: T.Type, indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withReuseIdentifier: cellType.identifier, for: indexPath) as? T else { fatalError() }
        return cell
    }
    
}
