//
//  RoverPhotosService.swift
//  
//
//  Created by Simge Çakır on 7.09.2021.
//

import Foundation
import Alamofire

public class RoverPhotosService: BasePhotoServiceProtocol {
    
    let apiKey = "DEMO_KEY"
    let sol = "100"
    let roverType: String?
    
    public init(roverType: RoverName) {
        self.roverType = roverType.rawValue
    }
    
    public func fetchPhotos(page: Int, completion: @escaping (Result<[Photo], PhotoError>) -> Void){
        
        let baseURL = "https://api.nasa.gov/mars-photos/api/v1/rovers/\(roverType!)/photos?sol=\(sol)&api_key=\(apiKey)&page=\(page)"
        
        guard let url = URL(string: baseURL) else {
            completion(.failure(.invalidURL))
            return
        }
        
        AF.request(url).responseData{ response in
            switch response.result{
            case .success(let data):
                do {
                    let decoder = JSONDecoder()
                    let result = try decoder.decode(PhotosResponse.self, from: data)
                    completion(.success(result.photos))
                } catch {
                    completion(.failure(.invalidData))
                }

            case .failure(let error):
                completion(.failure(.invalidResponse))
            }
        }

    }
    
    public func fetchFilteredPhotos(camera: String, completion: @escaping (Result<[Photo], PhotoError>) -> Void){
        
        let baseURL = "https://api.nasa.gov/mars-photos/api/v1/rovers/\(roverType!)/photos?sol=\(sol)&camera=\(camera)&api_key=\(apiKey)"
        
        guard let url = URL(string: baseURL) else {
            completion(.failure(.invalidURL))
            return
        }
        
        AF.request(url).responseData{ response in
            switch response.result{
            case .success(let data):
                do {
                    let decoder = JSONDecoder()
                    let result = try decoder.decode(PhotosResponse.self, from: data)
                    completion(.success(result.photos))
                } catch {
                    completion(.failure(.invalidData))
                }

            case .failure(let error):
                completion(.failure(.invalidResponse))
            }
        }
    }
    
}
