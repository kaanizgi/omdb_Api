//
//  DetailViewModel.swift
//  omdb_api
//
//  Created by Kaan İzgi on 16.08.2022.
//

import Foundation

class DetailViewModel:ObservableObject {
    
    
    @Published var filmDetails:MovieViewModel?
    
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

