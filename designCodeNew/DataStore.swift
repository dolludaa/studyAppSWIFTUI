//
//  DataStore.swift
//  designCodeNew
//
//  Created by Людмила Долонтаева on 24.08.2022.
//

import SwiftUI
import Combine

class DataStore: ObservableObject {
    @Published var posts: [Post] = []
    
    init() {
        getPosts()
    }
    
    func getPosts() {
        API().getPosts { (posts) in
            self.posts = posts
        }
    }
}


