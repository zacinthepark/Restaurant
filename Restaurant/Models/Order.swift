//
//  Order.swift
//  Restaurant
//
//  Created by zac on 2021/11/24.
//

import Foundation

struct Order: Codable {
    
    var menuItems: [MenuItem]
    
    init(menuItems: [MenuItem] = []) {
        self.menuItems = menuItems
    }
    
}
