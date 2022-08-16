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
                
                if vm.searchString.isEmpty && vm.searchString.count <= 3  {
                    EmptyView(error: "Please Search a Movie") }
                else{
                    Text(vm.errorMessage) }
            }
            .navigationTitle("Movies")
            .navigationBarTitleDisplayMode(.inline)
        }//.alert(vm.errorMessage, isPresented: $vm.isError, actions: {})
        .searchable(text: $vm.searchString,placement: .navigationBarDrawer(displayMode:.always)).disableAutocorrection(true)
        .onChange(of: vm.searchString) { search in
            withAnimation(.easeInOut) {
                if search.isEmpty { vm.movies.removeAll() } else {
                    vm.getMovies()
                }
            }
        }
        //.onSubmit(of: .search) { vm.getMovies() }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
