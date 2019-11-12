//
//  HttpManager.swift
//  TCTestProject
//
//  Created by HERIVONJY Aina on 10/11/2019.
//  Copyright © 2019 Aina Herivonjy. All rights reserved.
//

import Foundation


class HttpManager {
    static func fetchCars(completion: @escaping ([Car]?, Error?) -> ())
    {
        guard let carURL = URLFactory.carURL else { return }
        URLSession.shared.dataTask(with: carURL) { (data, response
            , error) in
            if (error != nil) {
                completion(nil,error)
                return
            }
            
            guard let data = data else {
                completion(nil,nil)
                return
            }
            do {
                let decoder = JSONDecoder()
                let books = try decoder.decode([Car].self, from: data)
                completion(books,nil)
            } catch let err {
                print("Err", err)
                completion(nil,err)
            }
        }.resume()
    }
}
