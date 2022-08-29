//
//  LoginView.swift
//  designCodeNew
//
//  Created by Людмила Долонтаева on 29.08.2022.
//

import SwiftUI

struct LoginView: View {
    var body: some View {
        ZStack(alignment: .top ) {
            Color.black
                .ignoresSafeArea()
            Color("background2")
                .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
                .edgesIgnoringSafeArea(.bottom)
            
            VStack {
                GeometryReader { geometry in
                    Text("Learn design & code.\nFrom scratch.")
                        .font(.system(size: geometry.size.width/10, weight: .bold))
                        .foregroundColor(.white)
                }
                .frame(maxWidth: 375, maxHeight: 100)
                .padding(.horizontal, 16)
                
                Text("80 hours of courses for SwiftUI, React and design tools.")
                    .font(.subheadline)
                    .frame(width: 250)
                
                Spacer()
            }
            .multilineTextAlignment(.center)
            .padding(.top, 100)
            .frame(height: 477)
            .frame(maxWidth: .infinity)
            .background(
                ZStack {
                    Image("Blob")
                        .offset(x: -150, y: -200)
                    .blendMode(.plusDarker)
                    Image("Blob")
                        .offset(x: -200, y: -250)
                        .blendMode(.overlay)
                }
            )
            .background(Image("Card3"),alignment: .bottom)
            .background(Color("newCol"))
        .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
        }
        
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
