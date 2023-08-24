//
//  SharedDataModel.swift
//  Dota 2 Patch Notes
//
//  Created by Tony Alhwayek on 8/23/23.
//

import Foundation

class SharedDataModel {
    static let shared = SharedDataModel()
    
    var filteredNewsItems: [NewsItem] = []
    
    private init() { }
}
