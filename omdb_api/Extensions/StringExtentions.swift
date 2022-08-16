//
//  StringExtentions.swift
//  omdb_api
//
//  Created by Kaan İzgi on 16.08.2022.
//

import Foundation


extension String {
    
    func trimmed() -> String {
        self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    func query() -> String {
        self.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
    }
}
