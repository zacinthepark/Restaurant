//
//  MenuController.swift
//  Restaurant
//
//  Created by zac on 2021/11/24.
//

import Foundation
import UIKit

class MenuController {
    static let shared = MenuController()
    //Name the notification for order updates
    static let orderUpdateNotification = Notification.Name("MenuController.orderUpdated")
    //Order 항목이 바뀔 때마다 orderUpdateNotification이라는 Notification을 NotificationCenter에 post
    var order = Order() {
        didSet {
            NotificationCenter.default.post(name: MenuController.orderUpdateNotification, object: nil)
        }
    }
    
    let baseURL = URL(string: "http://localhost:8090/")!
    
    //path에 해당하는 부분은 appendingPathComponent로 구현
    func fetchCategories(completion: @escaping ([String]?) -> Void) {
        let categoryURL = baseURL.appendingPathComponent("categories")
        let task = URLSession.shared.dataTask(with: categoryURL) { (data, response, error) in
            if let data = data,
               let jsonDictionary = try? JSONSerialization.jsonObject(with: data, options: []) as? [String:Any],
               let categories = jsonDictionary["categories"] as? [String] {
                completion(categories)
            } else {
                completion(nil)
            }
        }
        task.resume()
    }
    
    //받아야되는 menuitem이 특정 category셀을 누른 다음 나타나는 것들이므로 category를 따로 엄선한 menuitem이어야함. 그러므로 query parameter에 category도 추가
    func fetchMenuItems(forCategory categoryName: String, completion: @escaping ([MenuItem]?) -> Void) {
        let initialMenuURL = baseURL.appendingPathComponent("menu")
        var components = URLComponents(url: initialMenuURL, resolvingAgainstBaseURL: true)!
        components.queryItems = [URLQueryItem(name: "category", value: categoryName)]
        let menuURL = components.url!
        let task = URLSession.shared.dataTask(with: menuURL) { (data, response, error) in
            let jsonDecoder = JSONDecoder()
            if let data = data,
               let menuItems = try? jsonDecoder.decode(MenuItems.self, from: data) {
                completion(menuItems.items)
            } else {
                completion(nil)
            }
        }
        task.resume()
    }
    
    //menuIDs를 주면 해당 order의 시간을 돌려줌
    func submitOrder(forMenuIDs menuIds: [Int], completion: @escaping (Int?) -> Void) {
        let orderURL = baseURL.appendingPathComponent("order")
        var request = URLRequest(url: orderURL)
        request.httpMethod = "POST"
        //해당 request에서 "내가 보낼 데이터의 타입은 JSON이야"라고 알려주는 것, HTTP요청의 헤더 중 Content-Type의 value를 application/json으로 설정
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let data: [String: [Int]] = ["menuIds": menuIds]
        let jsonEncoder = JSONEncoder()
        let jsonData = try? jsonEncoder.encode(data)
        request.httpBody = jsonData
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            let jsonDecoder = JSONDecoder()
            if let data = data,
               let preparationTime = try? jsonDecoder.decode(PreparationTime.self, from: data) {
                completion(preparationTime.prepTime)
            } else {
                completion(nil)
            }
        }
        task.resume()
    }
    
    func fetchImage(url: URL, completion: @escaping (UIImage?) -> Void) {
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let data = data, let image = UIImage(data: data) {
                completion(image)
            } else {
                completion(nil)
            }
        }
        task.resume()
    }
}
