//
//  File.swift
//  
//
//  Created by Simge Çakır on 7.09.2021.
//

import Foundation

public struct PhotosResponse: Decodable {
   
    public let photos: [Photo]
    
    private enum RootCodingKeys: String, CodingKey {
        case photos
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: RootCodingKeys.self)
        self.photos = try container.decode([Photo].self, forKey: .photos)
    }
}
