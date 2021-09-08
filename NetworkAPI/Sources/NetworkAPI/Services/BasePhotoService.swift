//
//  BasePhotoService.swift
//
//
//  Created by Simge Çakır on 7.09.2021.
//

import Foundation

public protocol BasePhotoServiceProtocol{
    func fetchPhotos(completion: @escaping (Result<[Photo], PhotoError>) -> Void)
}
