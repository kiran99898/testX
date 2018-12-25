//
//  ModalX.swift
//  testX
//
//  Created by kiran on 12/24/18.
//  Copyright © 2018 kiran. All rights reserved.
//

import Foundation

class ModalX {
    
    let id: String?
    let name: String?
    let slug: String?
    let parent: Int?
    let description: String?
    // let imageUrl: String?
    
    init(productJson: NSDictionary) {
        self.id = productJson["id"] as?  String
        self.name = productJson["name"] as? String
        self.slug = productJson["slug"] as? String
        self.parent = productJson["parent"] as? Int
        self.description = productJson["description"] as? String
        
    }

    
}
