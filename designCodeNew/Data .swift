//
//  Data .swift
//  designCodeNew
//
//  Created by Людмила Долонтаева on 24.08.2022.
//

import SwiftUI

struct Post : Codable, Identifiable {
    let id = UUID()
    var title: String
    var body: String
}

class API {
    func getPosts(completion: @escaping ([Post]) -> () ) {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else {return}
        
        URLSession.shared.dataTask(with: url) { data, _, _ in
            
            guard let data = data else {return}
            let posts = try! JSONDecoder().decode([Post].self, from: data)
            DispatchQueue.main.async {
                completion(posts)

            }
            
        }
        .resume()
    }
}
