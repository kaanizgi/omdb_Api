//
//  DetailView.swift
//  omdb_api
//
//  Created by Kaan İzgi on 16.08.2022.
//

import SwiftUI
import SDWebImageSwiftUI

struct DetailView: View {
    var imdbID:String
    @ObservedObject private var vm = DetailViewModel()
    
    var body: some View {
        VStack(alignment: .center) {
            ScrollView(.vertical,showsIndicators: false) {
                VStack(alignment: .center,spacing: 20) {
                    WebImage(url: vm.filmDetails?.poster).resizable().frame(width:200,height: 350)
                    Text(vm.filmDetails?.title ?? "?????").font(.title3).bold().multilineTextAlignment(.leading)
                    Text(vm.filmDetails?.plot ?? "").font(.body)
                    Text(vm.filmDetails?.director ?? "").font(.caption)
                    Text(vm.filmDetails?.released ?? "").font(.caption)
                }.padding()
            }
            Spacer()
        }
        .onAppear {
            vm.getMovieDetail(imdbID: imdbID)
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(imdbID: "tt0120338")
    }
}
