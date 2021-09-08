//
//  Rover.swift
//  
//
//  Created by Simge Çakır on 7.09.2021.
//

import Foundation

//        "rover": {
//            "id": 5,
//            "name": "Curiosity",
//            "landing_date": "2012-08-06",
//            "launch_date": "2011-11-26",
//            "status": "active"
//        }

public struct Rover: Decodable{
    
    public let id: Int
    public let name: String
    public let status: String
    public let landingDate: String
    public let launchDate: String
    
    enum CodingKeys: String, CodingKey{
        case id
        case name
        case status
        case landingDate = "landing_date"
        case launchDate = "launch_date"
    }
    
}
