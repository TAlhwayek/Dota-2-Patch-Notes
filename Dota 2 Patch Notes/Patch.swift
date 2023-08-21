//
//  Patch.swift
//  Dota 2 Patch Notes
//
//  Created by Tony Alhwayek on 8/20/23.
//

import UIKit

class Patch: NSObject, Codable {
    var title: String
    var body: String
    
    init(title: String, body: String) {
        self.title = title
        self.body = body
    }
}
