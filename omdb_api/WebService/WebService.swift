//
//  WebService.swift
//  omdb_api
//
//  Created by Kaan İzgi on 15.08.2022.
//


import Foundation
import Combine

/* OLD
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
 */




class APIService {
    
    static let shared = APIService()
    
    func fetch<T: Decodable>(url: URL,expecting:T.Type) -> AnyPublisher<T, Error> {
        return URLSession.shared.dataTaskPublisher(for: url)
            
            .tryMap{(data,response) -> Data in
                guard let response = response as? HTTPURLResponse,
                      response.statusCode >= 200 && response.statusCode < 300 else {
                    throw URLError(.cannotDecodeRawData)
                }
                return data
            }
            .decode(type: expecting, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
    
    
}
