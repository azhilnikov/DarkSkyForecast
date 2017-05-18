//
//  DarkSkyService.swift
//  DarkSkyForecast
//
//  Created by Alexey on 17/5/17.
//  Copyright © 2017 Alexey Zhilnikov. All rights reserved.
//

import Foundation
import Gloss

fileprivate struct DarkSkyAPIData {
    static let url = "https://api.darksky.net/forecast/"
    static let apiKey = "e3cadd3ccd83cfebfb3e78fd5041888b"
    static let latitude = "33.8650"
    static let longitude = "151.2094"
}

class DarkSkyService {
    
    private(set) var forecast: Forecast?
    
    private var url: URL? {
        let fullURLString = DarkSkyAPIData.url + DarkSkyAPIData.apiKey + "/" +
            DarkSkyAPIData.latitude + "," + DarkSkyAPIData.longitude
        
        guard var components = URLComponents(string: fullURLString) else {
            return nil
        }
        
        // List of query items
        let parameters = ["units": "si"]
        var queryItems = [URLQueryItem]()
        
        for (key, value) in parameters {
            let item = URLQueryItem(name: key, value: value)
            queryItems.append(item)
        }
        
        // Return full url
        components.queryItems = queryItems
        return components.url
    }
    
    func fetch(completion: @escaping (DarkSkyAPIResult) -> Void) {
        
        guard let fullURL = url else {
            return completion(.failure(DarkSkyAPIError.invalidURL))
        }
        
        let request = URLRequest(url: fullURL,
                                 cachePolicy: .reloadIgnoringLocalAndRemoteCacheData,
                                 timeoutInterval: 30)
        
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: request, completionHandler: { (data, response, error) -> Void in
            
            if let taskError = error {
                completion(.failure(taskError))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(DarkSkyAPIError.invalidResponse))
                return
            }
            
            if 200 != httpResponse.statusCode {
                completion(.failure(DarkSkyAPIError.invalidStatusCode))
                return
            }
            
            guard let forecastData = data else {
                completion(.failure(DarkSkyAPIError.invalidData))
                return
            }
            
            do {
                let json = try JSONSerialization.jsonObject(with: forecastData,
                                                            options: .allowFragments) as AnyObject
                if let jsonData = json as? JSON, let forecast = Forecast(json: jsonData) {
                    self.forecast = forecast
                    completion(.success)
                    return
                }
                completion(.failure(DarkSkyAPIError.invalidJSONFormat))
            } catch let error {
                completion(.failure(error))
            }
        })
        task.resume()
    }
}
