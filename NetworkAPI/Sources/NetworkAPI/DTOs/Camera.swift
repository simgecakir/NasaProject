//
//  Camera.swift
//  
//
//  Created by Simge Çakır on 7.09.2021.
//

import Foundation

//        "camera": {
//            "id": 20,
//            "name": "FHAZ",
//            "rover_id": 5,
//            "full_name": "Front Hazard Avoidance Camera"
//        }

public struct Camera: Decodable{
    
    public let id: Int
    public let name: String
    public let fullname: String
    
    enum CodingKeys: String, CodingKey{
        case id
        case name
        case fullname = "full_name"
    }
    
}
