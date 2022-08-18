//
//  DetailViewModel.swift
//  omdb_api
//
//  Created by Kaan İzgi on 16.08.2022.
//

import Foundation
import Combine

class DetailViewModel:ObservableObject {
    
    
    @Published var filmDetails:MovieViewModel?
    private var cancellable:AnyCancellable?
    
    /* OLD
    func getMovieDetail(imdbID:String) {
        let url = URL(string: "\(APIConstants.baseUrl)?i=\(imdbID)&apikey=\(APIConstants.apiKey)")
        WebServer().requestUrl(url: url,expecting: MovieDetail.self)
        { Result in
            switch Result {
            case.success(let data):
                DispatchQueue.main.async{
                    self.filmDetails = MovieViewModel(movie: data)
                }
            case.failure(let error):
                print("error \(error)")
            }
        }
    }
     */
    
    func getMovieDetailCombine(imdbID:String) {
        let url = URL(string: "\(APIConstants.baseUrl)?i=\(imdbID)&apikey=\(APIConstants.apiKey)")!
        cancellable = APIService.shared.fetch(url: url, expecting: MovieDetail.self)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                print(completion)
            } receiveValue: { MovieDetail in
                self.filmDetails = MovieViewModel(movie: MovieDetail)
            }
    }
    
}




struct MovieViewModel {
    
    let movie: MovieDetail
    
    var imdbId: String {
        movie.imdbID
    }
    
    var title: String {
        movie.title
    }
    
    var poster: URL? {
        URL(string: movie.poster)
    }
    
    var released:String {
        movie.released
    }
    
    var director:String {
        movie.director
    }
    
    var plot:String {
        movie.plot
    }
    
}

