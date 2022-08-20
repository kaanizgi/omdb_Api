//
//  ContentView.swift
//  omdb_api
//
//  Created by Kaan İzgi on 15.08.2022.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject private var vm = ContentViewModel()
    var body: some View {
        NavigationView {
            ScrollView(.vertical,showsIndicators: false) {
                ForEach(vm.movies) { item in
                    NavigationLink(destination: DetailView(imdbID: item.imdbID)) {
                        ListView(data: item)
                    }.buttonStyle(PlainButtonStyle())
                }
                
                if vm.searchString.isEmpty   {
                    EmptyView(error: "Please Search a Movie") }
                else if vm.errorMessage != "" {
                    Text(vm.errorMessage) }
            }
            
            .navigationTitle("Movies")
            .navigationBarTitleDisplayMode(.inline)
        }.searchable(text: $vm.searchString,placement:.navigationBarDrawer(displayMode:.always)).disableAutocorrection(true)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
