//
//  IntermediaryModels.swift
//  Restaurant
//
//  Created by zac on 2021/11/24.
//

import Foundation

struct Categories: Codable {
    
    let categories: [String]
    
}

struct PreparationTime: Codable {
    
    let prepTime: Int
    
    enum CodingKeys: String, CodingKey {
        case prepTime = "preparation_time"
    }
    
}
