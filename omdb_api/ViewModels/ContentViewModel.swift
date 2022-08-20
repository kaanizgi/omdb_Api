//
//  ContentViewModel.swift
//  omdb_api
//
//  Created by Kaan İzgi on 15.08.2022.
//

import Foundation
import Combine


class ContentViewModel:ObservableObject {
    
    
    @Published var movies = [Search]()
    @Published var searchString = ""
    @Published var errorMessage = ""
    private var cancellable:AnyCancellable?
    var cancellables = Set<AnyCancellable>()
    
    
    init() {
        getMoviesCombine()
        
        $searchString
            .removeDuplicates()
            .debounce(for: 0.7, scheduler: RunLoop.main)
            .receive(on: DispatchQueue.main)
            .sink { searched in
                if searched == ""  {
                    self.movies = []
                }else {
                    self.searchString = searched
                    self.getMoviesCombine()
                }
            }
            .store(in: &cancellables)
    }
    
    
    /* OLD
    func getMovies() {
        //self.errorMessage = "Searching"
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
     */
    
    //With Combine
    func getMoviesCombine() {
        let url = URL(string: "\(APIConstants.baseUrl)?s=\(searchString.trimmed().query())&apikey=\(APIConstants.apiKey)")!
        cancellable =  APIService.shared.fetch(url: url, expecting: Movie.self)
            .receive(on: DispatchQueue.main)
            .sink { (completion) in
                switch completion {
                case.failure(_):
                    if self.searchString.count > 3 {
                        self.movies = []
                        self.errorMessage = "Movie not found"
                    }
                case .finished:
                    print("Succes")
                }
            } receiveValue: { data in
                self.errorMessage = ""
                self.movies = data.search
            }
    }
    
    
    
}
    




    

