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


func getArray(id:String, completion: @escaping([Entry]) -> () ) {
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

class CourseStore: ObservableObject {
    @Published var courses: [Course] = courseData
     
    init () {
        let colors = [Color("asset"), Color("mycol2"),Color("mycol3")]
        getArray(id: "course") { items in
            items.forEach {item in
                self.courses.append(Course(
                    title: item.fields["title"] as! String,
                    subtitle: item.fields["subtitle"] as! String,
                    image: item.fields.linkedAsset(at: "image")?.url ?? URL(string: "")!,
                    logo: Image("Logo1"),
                    color: colors.randomElement()!,
                    show: false))
            }
        }
    }
}
