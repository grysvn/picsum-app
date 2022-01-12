//
//  PicsumInteractor.swift
//  Picsum App
//
//  Created by Matthew Gray on 1/12/22.
//

import Foundation

typealias PicsumModelResponse = (Result<[PicsumModel], Error>) -> Void

class PicsumInteractor {
    
    struct PicsumError: Error {
        let message: String
    }
    
    let baseUrl = "https://picsum.photos/v2/"
    
    let shared = PicsumInteractor()
    
    func retrieveImages(callback: @escaping PicsumModelResponse) {
        guard let url = URL(string: baseUrl + "list") else {
            callback(Result.failure(PicsumError(message: "Bad url")))
            return
        }
        
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let error = error {
                callback(Result.failure(PicsumError(message: error.localizedDescription)))
                return
            }
            
            guard let data = data else {
                callback(Result.failure(PicsumError(message: "Data is nowhere to be found 😱")))
                return
            }
            
            let decoder = JSONDecoder()
            guard let response = try? decoder.decode([PicsumModel].self, from: data) else {
                callback(Result.failure(PicsumError(message: "Data is kind of messed up :/")))
                return
            }
            
            print(response)
            DispatchQueue.main.async { callback(Result.success(response)) }
        }
        
        task.resume()
    }
}

//let url = URL(string: "https://bit.ly/2LMtByx")!
//
//let task = URLSession.shared.dataTask(with: url) { data, response, error in
//    if let data = data {
//        let image = UIImage(data: data)
//    } else if let error = error {
//        print("HTTP Request Failed \(error)")
//    }
//}
//
//task.resume()
