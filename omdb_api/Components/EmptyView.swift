//
//  EmptyView.swift
//  omdb_api
//
//  Created by Kaan İzgi on 16.08.2022.
//

import SwiftUI

struct EmptyView: View {
    var error:String
    var body: some View {
        ProgressView(error).padding(.top)
    }
}

struct EmptyView_Previews: PreviewProvider {
    static var previews: some View {
        EmptyView(error: "errorr")
    }
}
