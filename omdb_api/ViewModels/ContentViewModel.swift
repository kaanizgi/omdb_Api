//
//  ContentViewModel.swift
//  omdb_api
//
//  Created by Kaan İzgi on 15.08.2022.
//

import Foundation


class ContentViewModel:ObservableObject {
    
    
    @Published var movies = [Search]()
    @Published var searchString = ""
    @Published var errorMessage = ""
    //@Published var isError = false
    
    let webService = WebServer()
    
    func getMovies() {
        
        let url = URL(string: "\(APIConstants.baseUrl)?s=\(searchString.trimmed().query())&apikey=\(APIConstants.apiKey)")
        WebServer().requestUrl(url: url,expecting: Movie.self) { Result in
            switch Result {
            case.success(let data):
                DispatchQueue.main.async{ self.movies = data.search }
            case.failure(CustomError.invalidData):
                DispatchQueue.main.async {
                    if self.searchString.count > 3 {
                        self.movies = []
                        //self.isError = true
                        self.errorMessage = "Movie not found" }
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}
    



    


    

