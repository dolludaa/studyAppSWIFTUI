//
//  Home .swift
//  designcode
//
//  Created by Людмила Долонтаева on 12.08.2022.
//

import SwiftUI

struct Home_: View {
    @State var showProfile = false
    @State var viewState = CGSize.zero
    
    var body: some View {
        ZStack {
            
            Color.gray.opacity(showProfile ?  0.4 : 0)
                .animation(.spring(response: 0.9, dampingFraction: 0.7, blendDuration:0.8), value: showProfile)
                .edgesIgnoringSafeArea(.all)
            
            HomeView(showProfile: $showProfile)
                .padding(.top, 44)
                .background(Color.white)
                .clipShape(RoundedRectangle(cornerRadius: showProfile ? 30 : 0, style: .continuous))
                .ignoresSafeArea()
                .shadow(color: Color.black.opacity(0.2), radius: 20, x: 0, y: 20)
                .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0), value: showProfile)
                .offset(y: showProfile ? -450 : 0)
                .rotation3DEffect(Angle(degrees: showProfile ? Double(viewState.height / 10) - 10 : 0), axis: (x: 10, y: 0, z: 0))
                .scaleEffect(showProfile ? 0.9 : 1)
            
            MenuView()
                .background(Color.black.opacity(0.001))
                .offset(y: showProfile ? 0 : UIScreen.main.bounds.size.height)
                .offset(y: viewState.height)
                .shadow(color: Color.black.opacity(0.1), radius: 20, x: 0, y: 20)
                .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0), value: showProfile)
                .onTapGesture {
                    self.showProfile.toggle()
                }
                .gesture(
                    DragGesture().onChanged{ value in
                        self.viewState = value.translation
                    }
                        .onEnded{ value  in
                            if viewState.height > 50 {
                                self.showProfile = false
                            }
                            self.viewState = .zero
                        }
                )
            
            
        }
    }
}

struct Home__Previews: PreviewProvider {
    static var previews: some View {
        Home_()
    }
}

struct AvatarView: View {
    @Binding var showProfile: Bool
    
    var body: some View {
        Button(action: {self.showProfile.toggle()}) {
            Image("Avatar")
                .resizable()
                .frame(width: 36, height: 36 )
                .clipShape(Circle())
        }
    }
}
let sceen = UIScreen.main.bounds
