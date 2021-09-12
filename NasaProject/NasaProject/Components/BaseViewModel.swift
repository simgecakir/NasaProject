//
//  CuriosityViewModel.swift
//  NasaProject
//
//  Created by Simge Çakır on 8.09.2021.
//

import Foundation
import NetworkAPI

protocol BaseViewModelProtocol {
    var delegate: BaseViewModelDelegate? { get set }
    var numberOfItems: Int { get }
    var photos: [Photo] { get }
    
    func load()
    func loadMorePhoto()
    func photo(indexPath: Int) -> Photo?
    func selectedPhoto(photo: Photo)
    func filterPhotosByCamera(camera: String)
}

protocol BaseViewModelDelegate: AnyObject {
    func reloadData()
    func loadingView(isShown: Bool)
    func showPhotoDetail(photo: Photo)
}

class BaseViewModel{
    
    weak var delegate: BaseViewModelDelegate?
    private let service: BasePhotoServiceProtocol
    private var filteredPhotos = [Photo]()
    private var isFiltering: Bool = false
    private var page = 1
    var photos = [Photo]()

    init(service:BasePhotoServiceProtocol) {
        self.service = service
    }

    private func loadPhotos(page: Int){
        delegate?.loadingView(isShown: true)
        service.fetchPhotos(page: page) { [weak self] result in
            self?.delegate?.loadingView(isShown: false)
            guard let self = self else { return }
            switch result{
            case .success(let data):
                self.photos = data
                self.delegate?.reloadData()
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func filteredCameraPhotos(camera: String) {
        service.fetchFilteredPhotos(camera: camera) { [weak self] result in
            self?.delegate?.loadingView(isShown: false)
            guard let self = self else { return }
            switch result{
            case .success(let data):
                self.filteredPhotos = data
                self.delegate?.reloadData()
    
            case .failure(let error):
                print(error)
            }
        }
    }
    
}

extension BaseViewModel: BaseViewModelProtocol{
    
    func load() {
        delegate?.loadingView(isShown: true)
        loadPhotos(page: page)
        self.delegate?.reloadData()
    }
    
    func photo(indexPath: Int) -> Photo? {
        if isFiltering {
            return self.filteredPhotos[indexPath]
        }
        return self.photos[indexPath]
    }
    
    var numberOfItems: Int {
        if isFiltering {
            return filteredPhotos.count
        }
        return self.photos.count
    }
    
    func loadMorePhoto() {
        page += 1
        delegate?.loadingView(isShown: true)
        service.fetchPhotos(page: page) { [weak self] result in
            guard let self = self else { return }
            switch result{
            case .success(let data):
                self.photos.append(contentsOf: data)
                DispatchQueue.main.asyncAfter(deadline: .now() + 2){
                    self.delegate?.reloadData()
                    self.delegate?.loadingView(isShown: false)
                }
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func selectedPhoto(photo: Photo){
        delegate?.showPhotoDetail(photo: photo)
    }
    
    func filterPhotosByCamera(camera: String) {
        if camera == "ALL"{
            isFiltering = false
            self.delegate?.reloadData()
        }else{
            isFiltering = true
            filteredCameraPhotos(camera: camera)
        }
    }

}
