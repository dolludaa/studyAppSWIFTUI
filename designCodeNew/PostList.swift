//
//  PostList.swift
//  designCodeNew
//
//  Created by Людмила Долонтаева on 24.08.2022.
//

import SwiftUI

struct PostList: View {
    @State var posts: [Post] = []
    
    var body: some View {
        List(posts) { post in
            Text(post.title)
            
        }.onAppear{
            API().getPost { posts in
                self.posts = posts
            }
        }
    }
}

struct PostList_Previews: PreviewProvider {
    static var previews: some View {
        PostList()
    }
}
