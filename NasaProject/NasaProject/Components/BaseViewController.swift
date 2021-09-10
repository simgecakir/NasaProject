//
//  BaseViewController.swift
//  NasaProject
//
//  Created by Simge Çakır on 9.09.2021.
//

import UIKit
import SnapKit
import NetworkAPI

class BaseViewController: UIViewController {

    private var collectionView: UICollectionView!
    
    var viewModel: BaseViewModelProtocol! {
        didSet {
            viewModel.delegate = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        configureNavigationBar()
        viewModel.load()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        collectionView.reloadData()
    }
    
    fileprivate func configureNavigationBar(){
        
//        let bounds = navigationController!.navigationBar.bounds
//        self.navigationController?.navigationBar.frame = CGRect(x: 0, y: 0, width: bounds.width, height: bounds.height - 20)
        navigationController?.navigationBar.barTintColor = .lightGray
    }
    
    fileprivate func configureCollectionView() {
        
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 20, right: 10)
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.backgroundColor = .black
        
        collectionView.register(cellType: PhotoCell.self)
        
        collectionView.delegate = self
        collectionView.dataSource = self

        view.addSubview(collectionView)
        collectionView.snp.makeConstraints{ (make) in
            make.top.bottom.leading.trailing.equalToSuperview()
        }
    }
}

extension BaseViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.numberOfItems
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeCell(cellType: PhotoCell.self, indexPath: indexPath)
        guard let photo = viewModel.photo(indexPath: indexPath.row) else { fatalError() }
        cell.configure(photo: photo.imagePath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        viewModel.loadMorePhoto(indexPath: indexPath.row)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let photo = viewModel.photo(indexPath: indexPath.row)
        viewModel.selectedPhoto(photo: photo!)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = view.frame.width * 0.3
        return CGSize(width: size, height: size)
    }
    
}

extension BaseViewController: BaseViewModelDelegate{
    
    func reloadData() {
        collectionView.reloadData()
    }
    
    func showPhotoDetail(photo: Photo){
        let popupVC = PhotoDetailViewController()
        popupVC.photo = photo
        popupVC.modalTransitionStyle = .crossDissolve
        popupVC.modalPresentationStyle = .overCurrentContext
        present(popupVC, animated: true, completion: nil)
    }
}
