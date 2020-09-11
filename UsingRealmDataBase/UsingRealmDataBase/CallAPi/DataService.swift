//
//  DataService.swift
//  UsingRealmDataBase
//
//  Created by Boss on 9/12/20.
//  Copyright © 2020 LuyệnĐào. All rights reserved.
//

import UIKit

class DataService {
    static let sharing: DataService = DataService()
    func callAPI(completion: @escaping((BaseDataModel)) -> Void){
        let url = "https://itunes.apple.com/search"
        let queryItems = [URLQueryItem(name: "media", value: "music"),
                          URLQueryItem(name: "entity", value: "song"),
                          URLQueryItem(name: "term", value: "A")
        ]
        guard var urlComps = URLComponents(string: url) else {return}
        urlComps.queryItems = queryItems
        guard let convertURL = urlComps.url else {return}
        let dataTask = URLSession.shared.dataTask(with: convertURL) {(data, response, error) in
            if let data = data, let dataString = String(data: data, encoding: .utf8) {
                print("fullURLRequest: ", convertURL)
                print("params: ", convertURL.query as Any)
                print("header: ", convertURL.relativeString)
                print("Response json:\n", dataString)
            }
            if let data = data {
                let json = try? JSONDecoder().decode(BaseDataModel.self, from: data)
                DispatchQueue.main.async {
                    completion(json!)
                }
            }
        }
        dataTask.resume()
    }
}
