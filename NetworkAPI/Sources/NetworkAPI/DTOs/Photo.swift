//
//  Photo.swift
//  
//
//  Created by Simge Çakır on 7.09.2021.
//

import Foundation

//        "id": 102693,
//        "sol": 1000,
//        "camera": {
//            "id": 20,
//            "name": "FHAZ",
//            "rover_id": 5,
//            "full_name": "Front Hazard Avoidance Camera"
//        },
//        "img_src": "http://mars.jpl.nasa.gov/msl-raw-images/proj/msl/redops/ods/surface/sol/01000/opgs/edr/fcam/FLB_486265257EDR_F0481570FHAZ00323M_.JPG",
//        "earth_date": "2015-05-30",
//        "rover": {
//            "id": 5,
//            "name": "Curiosity",
//            "landing_date": "2012-08-06",
//            "launch_date": "2011-11-26",
//            "status": "active"
//        }
//        },

public struct Photo: Decodable{
    
    public let id: Int
    public let camera : Camera
    public let imagePath: String
    public let rover: Rover
    public let earthDate: String
    
    enum CodingKeys: String, CodingKey{
        case id
        case camera
        case rover
        case imagePath = "img_src"
        case earthDate = "earth_date"
    }
    
}
