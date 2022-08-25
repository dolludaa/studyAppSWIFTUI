//
//  CourseStore.swift
//  designCodeNew
//
//  Created by Людмила Долонтаева on 25.08.2022.
//

import SwiftUI
import Contentful

let client = Client(spaceId: "upm64ss5bl9l", accessToken: "8MuJqEuomc7T_o6YeSxfW0e3Zr2Ti2-H63FJCB6nr94")


func getArray() {
    let query = Query.where(contentTypeId: "course")
    
    client.fetchArray(of: Entry.self, matching: query) {result in
        
    }
}

