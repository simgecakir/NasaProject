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
    private var cameraPicker = UIPickerView()
    private var cameraFilterField = FilterCategoryView()
    var cameraTitles = [String]()
    
    private var stackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.distribution = .fill
        view.alignment = .center
        view.spacing = 15.0
        return view
    }()
    
    var viewModel: BaseViewModelProtocol! {
        didSet {
            viewModel.delegate = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        configureNavigationBar()
        configureComponents()
        configureCameraPicker()
        bindViews()
        viewModel.load()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        collectionView.reloadData()
    }
    
    fileprivate func configureNavigationBar(){
        
        let filterButton = UIBarButtonItem(image: UIImage(named: "filter"), style: .plain, target: self, action: #selector(filterButtonPressed(sender:)))
        filterButton.accessibilityIdentifier = "filterButton"
        navigationItem.rightBarButtonItem = filterButton
        navigationController?.navigationBar.barTintColor = .lightGray
        navigationController?.navigationBar.tintColor = .black
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
    }
    
    private func configureCameraPicker(){
        
        cameraPicker.dataSource = self
        cameraPicker.delegate = self
        
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(cameraPickerSelected))
        toolbar.setItems([doneButton], animated: true)
        cameraFilterField.choiceTextField.inputAccessoryView = toolbar
        cameraFilterField.choiceTextField.inputView = cameraPicker
    }
    
    private func configureComponents(){
        cameraFilterField.configure(with: FilterCategoryModel(categoryName: "Camera", categoryChoice: "ALL"))
        cameraFilterField.accessibilityIdentifier = "cameraFilterField"
        self.cameraFilterField.isHidden = true
        self.cameraFilterField.alpha = 0.0
    }
    
    @objc func filterButtonPressed(sender: UIBarButtonItem){
        UIView.animate(withDuration: 0.5, delay: 0.0, options: [.curveEaseOut],
            animations: {
                if self.cameraFilterField.isHidden == true {
                    self.cameraFilterField.isHidden = false
                    self.cameraFilterField.alpha = 1.0
                }else{
                    self.cameraFilterField.isHidden = true
                    self.cameraFilterField.alpha = 0.0
                }
        })
        stackView.layoutIfNeeded()
    }
    
    @objc func cameraPickerSelected(){
        let cameraName =  cameraTitles[cameraPicker.selectedRow(inComponent: 0)]
        cameraFilterField.choiceTextField.text = cameraName
        self.view.endEditing(true)
        viewModel.filterPhotosByCamera(camera: cameraName)
    }
    
    private func bindViews(){
        
        view.addSubview(stackView)
        stackView.snp.makeConstraints{ (make) in
            make.top.equalToSuperview().offset(110)
            make.bottom.leading.trailing.equalToSuperview()
        }
        
        stackView.addArrangedSubview(cameraFilterField)
        cameraFilterField.snp.makeConstraints{ (make) in
            make.width.equalToSuperview().offset(-50)
            make.height.equalTo(40)
        }
        
        stackView.addArrangedSubview(collectionView)
        collectionView.snp.makeConstraints{ (make) in
            make.width.equalToSuperview()
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
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.height

        if offsetY > contentHeight - height {
            viewModel.loadMorePhoto()
        }
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

extension BaseViewController: UIPickerViewDelegate, UIPickerViewDataSource{
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        cameraTitles.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return cameraTitles[row]
    }
    
}

extension BaseViewController: BaseViewModelDelegate{
    
    func reloadData() {
        collectionView.reloadData()
    }
    
    func loadingView(isShown: Bool) {
        isShown ? showLoading() : hideLoading()
    }
    
    func showPhotoDetail(photo: Photo){
        let popupVC = PhotoDetailViewController()
        popupVC.photo = photo
        popupVC.modalTransitionStyle = .crossDissolve
        popupVC.modalPresentationStyle = .overCurrentContext
        present(popupVC, animated: true, completion: nil)
    }
}
