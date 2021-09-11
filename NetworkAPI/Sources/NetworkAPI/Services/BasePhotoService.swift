//
//  BasePhotoService.swift
//
//
//  Created by Simge Çakır on 7.09.2021.
//

import Foundation

public protocol BasePhotoServiceProtocol{
    func fetchPhotos(page: Int, completion: @escaping (Result<[Photo], PhotoError>) -> Void)
    func fetchFilteredPhotos(camera: String, completion: @escaping (Result<[Photo], PhotoError>) -> Void)
}
