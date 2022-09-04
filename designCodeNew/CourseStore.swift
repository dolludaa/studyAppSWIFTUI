//
//  CourseStore.swift
//  designCodeNew
//
//  Created by Людмила Долонтаева on 25.08.2022.
//

import SwiftUI
import Contentful
import Combine

let client = Client(spaceId: "upm64ss5bl9l", accessToken: "8MuJqEuomc7T_o6YeSxfW0e3Zr2Ti2-H63FJCB6nr94")


func getArray(id: String, completion: @escaping ([Entry]) -> Void ) {
    let query = Query.where(contentTypeId: id)
    
    client.fetchArray(of: Entry.self, matching: query) {result in
        switch result {
        case .success(let array):
            DispatchQueue.main.async {
                completion(array.items)
            }
        case .failure(let erorr):
            print(erorr)
        }
        
    }
}

final class CourseStore: ObservableObject {
    @Published var courses: [Course] = []
     
    init () {
        let colors = [
            Color.blue,
            .pink,
            .green,
            .brown,
            .cyan,
            .red
        ]
            .map { $0.opacity(0.5) }
        
        getArray(id: "course") { [weak self] items in
            self?.courses = items.enumerated().map { i, item in
                Course(
                    title: item.fields["title"] as! String,
                    subtitle: item.fields["subtitle"] as! String,
                    image: item.fields.linkedAsset(at: "image")?.url ?? URL(string: "")!,
                    logo: Image("Logo1"),
                    color: colors[i % colors.count],
                    show: false
                )
            }
        }
    }
}
