//
//  PhotoDetailViewController.swift
//  NasaProject
//
//  Created by Simge Çakır on 9.09.2021.
//

import UIKit
import NetworkAPI

class PhotoDetailViewController: UIViewController {
    
    private let scrollView = UIScrollView()
    private let dateLabel = InfoView()
    private let roverNameLabel = InfoView()
    private let statusLabel = InfoView()
    private let landingDateLabel = InfoView()
    private let launchDateLabel = InfoView()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let popupView: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        view.layer.cornerRadius = 25
        view.backgroundColor = .white
        return view
    }()
    
    let stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fill
        stack.alignment = .center
        stack.spacing = 12.0
        return stack
    }()

    var photo: Photo!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightGray.withAlphaComponent(0.3)
        configComponents()
        bindViews()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissPopUp))
        view.addGestureRecognizer(tapGesture)
       }

       @objc func dismissPopUp(){
           self.dismiss(animated: true, completion: nil)
       }
    
    private func configComponents(){
        
        scrollView.alwaysBounceVertical = true
        scrollView.bounces = true
        
        dateLabel.configure(with: InfoViewModel(title: "Date", detail: photo.earthDate))
        roverNameLabel.configure(with: InfoViewModel(title: "Rover Name", detail: photo.rover.name))
        statusLabel.configure(with: InfoViewModel(title: "Rover Status", detail: photo.rover.status))
        landingDateLabel.configure(with: InfoViewModel(title: "Landing Date", detail: photo.rover.landingDate))
        launchDateLabel.configure(with: InfoViewModel(title: "Launch Date", detail: photo.rover.launchDate))
        
        imageView.loadImage(from: photo.imagePath, placeHolder: nil)
    }
    
    private func bindViews(){
        
        view.addSubview(popupView)
        popupView.snp.makeConstraints{ (make) in
            make.center.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.75)
            make.height.equalTo(view.snp.width)
        }
        
        popupView.addSubview(scrollView)
        scrollView.snp.makeConstraints{ (make) in
            make.top.bottom.leading.trailing.equalToSuperview()
        }
        
        scrollView.addSubview(imageView)
        imageView.snp.makeConstraints{ (make) in
            make.top.width.equalToSuperview()
            make.height.equalTo(popupView.snp.height).multipliedBy(0.8)
        }
        
        scrollView.addSubview(stackView)
        stackView.snp.makeConstraints{ (make) in
            make.top.equalTo(imageView.snp.bottom).offset(20)
            make.bottom.equalToSuperview().offset(-15)
            make.leading.equalTo(popupView.snp.leading).offset(10)
            make.trailing.equalTo(popupView.snp.trailing).offset(-10)
        }
        
        stackView.addArrangedSubview(dateLabel)
        dateLabel.snp.makeConstraints{ (make) in
            make.width.equalToSuperview()
            make.height.equalTo(20)
        }
        
        stackView.addArrangedSubview(roverNameLabel)
        roverNameLabel.snp.makeConstraints{ (make) in
            make.width.equalToSuperview()
            make.height.equalTo(20)
        }
        
        stackView.addArrangedSubview(statusLabel)
        statusLabel.snp.makeConstraints{ (make) in
            make.width.equalToSuperview()
            make.height.equalTo(20)
        }
        
        stackView.addArrangedSubview(landingDateLabel)
        landingDateLabel.snp.makeConstraints{ (make) in
            make.width.equalToSuperview()
            make.height.equalTo(20)
        }
        
        stackView.addArrangedSubview(launchDateLabel)
        launchDateLabel.snp.makeConstraints{ (make) in
            make.width.equalToSuperview()
            make.height.equalTo(20)
        }
    }

}
