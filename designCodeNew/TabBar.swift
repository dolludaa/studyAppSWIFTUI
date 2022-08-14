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
            Home_().tabItem{
                Image(systemName: "play.circle.fill")
                Text ("Home")
            }
            ContentView().tabItem{
                Image (systemName: "rectangle.stack.fill")
                Text("Certifiactes")
                
            }
        }
    }
}

struct TabBar_Previews: PreviewProvider {
    static var previews: some View {
        TabBar()
    }
}
