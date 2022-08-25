//
//  Buttons.swift
//  designCodeNew
//
//  Created by Людмила Долонтаева on 25.08.2022.
//

import SwiftUI

struct Buttons: View {
    var body: some View {
        VStack {
            Text("Button")
                .font(.system(size: 20, weight: .semibold, design: .rounded))
                .frame(width: 200, height: 60 )
                .background(
                    ZStack {
                        Color("colo").opacity(0.2  )
                            
                        RoundedRectangle(cornerRadius: 16, style: .continuous)
                            .foregroundColor(.white)
                            .blur(radius: 5)
                            .offset(x: -8, y: -8)
                        
                        RoundedRectangle(cornerRadius: 16, style: .continuous)
                            .fill(
                                LinearGradient(gradient: Gradient(colors: [Color("back").opacity(0.3), Color.white]), startPoint: .topLeading, endPoint: .bottomTrailing)
                            )
                            .padding(2)
                            .blur(radius: 2)
                    }
                )
                .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                .shadow(color: Color("back").opacity(0.7), radius: 20, x: 20, y: 20)
                .shadow(color: Color.white , radius: 20, x: -30, y: -20)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color("back").opacity(0.3))
    }
}

struct Buttons_Previews: PreviewProvider {
    static var previews: some View {
        Buttons()
    }
}
