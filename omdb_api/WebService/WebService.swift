//
//  WebService.swift
//  omdb_api
//
//  Created by Kaan İzgi on 15.08.2022.
//


import Foundation

enum CustomError:Error {
    case invalidUrl
    case invalidData
}

class WebServer {
   
    func requestUrl<T: Codable>(
    url:URL?,
    expecting:T.Type,
    completion: @escaping(Result<T,Error>) -> Void)    {
     
        guard let url = url else{
            completion(.failure(CustomError.invalidUrl))
            return
        }
        let task = URLSession.shared.dataTask(with: url) { Data, _, Error in
            guard let data = Data else{
                if let Error = Error {
                    completion(.failure(Error))
                } else{
                    completion(.failure(CustomError.invalidUrl))
                }
                return
            }
            do{
                let results = try JSONDecoder().decode(expecting, from: data)
                completion(.success(results))
            }
            catch{
                completion(.failure(CustomError.invalidData))
            }
        }
        task.resume()
    }
}
