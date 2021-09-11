//
//  UIViewController + Extension.swift
//  NasaProject
//
//  Created by Simge Çakır on 11.09.2021.
//

import UIKit

extension UIViewController{
    
    static let activityIndicator = UIActivityIndicatorView()

    func showLoading() {
        let activityIndicator = UIViewController.activityIndicator
        activityIndicator.center = self.view.center
        activityIndicator.style = .large
        activityIndicator.color = .white
        activityIndicator.hidesWhenStopped = true
        DispatchQueue.main.async {
            self.view.addSubview(activityIndicator)
        }
        activityIndicator.startAnimating()
    }

    func hideLoading() {
        let activityIndicator = UIViewController.activityIndicator
        DispatchQueue.main.async {
            activityIndicator.removeFromSuperview()
            activityIndicator.stopAnimating()
        }
    }
}
