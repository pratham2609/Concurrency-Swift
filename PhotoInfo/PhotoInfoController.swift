//
//  PhotoInfoController.swift
//  PhotoInfo
//
//  Created by Pratham on 18/04/24.
//

import UIKit

class PhotoInfoController {
    
    enum PhotoInfoError: Error, LocalizedError {
        case itemNotFound
        case imageNotFound
    }
    
    func fetchData() async throws -> PhotoInfo {
        var urlComponents = URLComponents(string: "https://api.nasa.gov/planetary/apod")!
        let queryItems = ["api_key": "h1wVWaoefhZa2IrUFJOOjHTlJ9ROfrQrkn9fqbk0", "date": "2024-03-14"]
        urlComponents.queryItems = queryItems.map{ URLQueryItem(name: $0.key, value: $0.value) }
        
        let (data, response) = try await URLSession.shared.data(from: urlComponents.url!)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw PhotoInfoError.itemNotFound
        }
        
        let jsonDecoder = JSONDecoder()
        let photoInfoJSON = try? jsonDecoder.decode(PhotoInfo.self, from: data)
        return photoInfoJSON!
    }
    
    func fetchImage(from url: URL) async throws -> UIImage {
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw PhotoInfoError.itemNotFound
        }
        
        guard let image: UIImage = UIImage(data: data) else {
            throw PhotoInfoError.imageNotFound
        }
        
        return image
    }
}
