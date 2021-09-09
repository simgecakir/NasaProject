//
//  CuriosityViewModel.swift
//  NasaProject
//
//  Created by Simge Çakır on 8.09.2021.
//

import Foundation
import NetworkAPI

protocol CuriosityViewModelProtocol {
    var delegate: CuriosityViewModelDelegate? { get set }
    var numberOfItems: Int { get }
    var photos: [Photo] { get }
    
    func load()
    func loadMorePhoto(indexPath: Int)
    func photo(indexPath: Int) -> Photo?

}

protocol CuriosityViewModelDelegate: AnyObject {
    func reloadData()
}

final class CuriosityViewModel{
    
    weak var delegate: CuriosityViewModelDelegate?
    private let service: BasePhotoServiceProtocol
    
    private var limit = 9
    private var total: Int?
    var photos = [Photo]()
    var showingPhotos = [Photo]()

    init(service:BasePhotoServiceProtocol) {
        self.service = service
    }

    func loadPhotos(){
        service.fetchPhotos { [weak self] result in
            guard let self = self else { return }
            switch result{
            case .success(let data):
                self.photos = data
                if self.photos.count != 0{
                    for photo in self.photos[0 ... 8]{
                        self.showingPhotos.append(photo)
                    }
                }
                self.delegate?.reloadData()
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
}

extension CuriosityViewModel: CuriosityViewModelProtocol{
    
    func load() {
        loadPhotos()
        self.delegate?.reloadData()
    }
    
    func photo(indexPath: Int) -> Photo? {
        self.showingPhotos[indexPath]
    }
    
    var numberOfItems: Int {
        self.showingPhotos.count
    }
    
    func loadMorePhoto(indexPath: Int) {
        
        if indexPath == showingPhotos.count - 1 {
            var counter = 1
            while counter <= limit {
                if showingPhotos.count < photos.count {
                    showingPhotos.append(photos[indexPath + counter])
                }
                counter += 1
            }
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 3){
            self.delegate?.reloadData()
        }
    }
    
}
