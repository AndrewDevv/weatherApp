//
//  NetwotkManeger.swift
//  weatherApp
//
//  Created by Андрей Антонов on 11.11.2022.
//  Copyright © 2022 Андрей Антонов. All rights reserved.
//

import Foundation

protocol NetworkProtocol {
    func reqeastData(url: NSURL, complition: @escaping (Data) -> Void)
}

final class NetworkManeger: NetworkProtocol {
        
    func reqeastData(url: NSURL, complition: @escaping (Data) -> Void) {
        
        let headers = [
            "X-RapidAPI-Key": "a6ccd91810msh3a3b88877153955p119c2fjsn4e7e76f61ed3",
            "X-RapidAPI-Host": "weatherbit-v1-mashape.p.rapidapi.com"
        ]
        
        var request = URLRequest(
            url: url as URL,
            cachePolicy: .useProtocolCachePolicy,
            timeoutInterval: 10.0
        )
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        let session = URLSession.shared
        DispatchQueue.global().async {
            let dataTask = session.dataTask(with: request, completionHandler: { (data, response, error) -> Void in
                guard let data = data, error == nil else { return }
                
                complition(data)
            })
            dataTask.resume()
        }
        
    }
}
