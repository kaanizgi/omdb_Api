//
//  ListView.swift
//  omdb_api
//
//  Created by Kaan İzgi on 16.08.2022.
//

import SwiftUI
import SDWebImageSwiftUI

struct ListView: View {
    var data:Search
    var body: some View {
        HStack() {
            WebImage(url: URL(string: data.poster))
                .resizable()
                .cornerRadius(8)
                .frame(height: 150)
                .frame(maxWidth:150)
            VStack(alignment: .leading){
                Text(data.title)
                    .font(.body)
                    .bold()
                    .multilineTextAlignment(.leading)
                    .lineLimit(2)
                    .padding(.horizontal)
                
                
                Text(data.year)
                    .font(.callout)
                    .multilineTextAlignment(.leading)
                    .padding(.horizontal)
                    .lineLimit(2)
                    .padding(.vertical,1)
                
                Text(data.type.rawValue)
                    .font(.callout)
                    .padding()
                
            }
            
            Spacer()
            
        }.padding()
        
    }
}


