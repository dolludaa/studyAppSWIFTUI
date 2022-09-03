//
//  tabBar.swift
//  designcode
//
//  Created by Людмила Долонтаева on 13.08.2022.
//

import SwiftUI

struct TabBar: View {
    var body: some View {
        TabView {
            Home().tabItem{
                Image(systemName: "play.circle.fill")
                Text ("Home")
            }
            
            CourseList().tabItem {
                Image (systemName: "rectangle.stack.fill")
                Text("Courses")
            }
        }
    }
}

struct TabBar_Previews: PreviewProvider {
    static var previews: some View {
        TabBar()
    }
}
