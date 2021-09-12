//
//  MockAPIService.swift
//  NasaProjectTests
//
//  Created by Simge Çakır on 11.09.2021.
//

import Foundation
@testable import NasaProject
@testable import NetworkAPI

final class MockPhotoService: BasePhotoServiceProtocol{
        
    func fetchPhotos(page: Int, completion: @escaping (Result<[Photo], PhotoError>) -> Void) {
        
        let bundle = Bundle(for: NasaProjectTests.self)
        let path = bundle.path(forResource: "Photos", ofType: "json")!
        let file = try! String(contentsOfFile: path)
        let data = file.data(using: .utf8)!
        let photoResponse = try! JSONDecoder().decode(PhotosResponse.self, from: data)
        completion(.success(photoResponse.photos))
    }
    
    func fetchFilteredPhotos(camera: String, completion: @escaping (Result<[Photo], PhotoError>) -> Void) {
    }
    
}

