//
//  MenuView.swift
//  designcode
//
//  Created by Людмила Долонтаева on 29.07.2022.
//

import SwiftUI

struct MenuView: View {
    @EnvironmentObject var user: UserStore
    @Binding var showProfile: Bool
    

    var body: some View {
        VStack {
            Spacer()
            
            VStack(spacing: 16) {
                Text ("Liudmila - 28% complete")
                    .font(.caption)
                
                Color.white
                    .frame(width: 38, height: 6)
                    .cornerRadius(3)
                    .frame(width: 130, height: 6,alignment: .leading)
                    .background(Color.black.opacity(0.08))
                    .cornerRadius(3)
                    .padding()
                    .frame(width: 150, height: 24)
                    .background(Color.black.opacity(0.1))
                    .cornerRadius(12)
                
                MenuRow(title: "Account ", icon: "gear")
                MenuRow(title: "Billing ", icon: "creditcard")
                MenuRow(title: "Sign out ", icon: "person.crop.circle")
                    .onTapGesture {
                        UserDefaults.standard.set(false, forKey: "isLogged")
                        user.isLogged = false
                        showProfile = false 
                    }

            }
            .frame(maxWidth: .infinity)
            .frame(height: 300)
            .background(
                LinearGradient(gradient: Gradient(colors: [Color("background3"),Color("background3").opacity(0.6)]),
                    startPoint: .top,
                    endPoint: .bottom
                )
            )
            .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
            .shadow(color: Color.black.opacity(0.2), radius: 20, x: 0, y: 20)
            .padding(.horizontal, 30 )
            .overlay {
                Image("Avatar")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 60, height: 60 )
                    .clipShape(Circle())
                    .offset(y:-150)
                 
            }
        }
        .padding(.bottom, 30)
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View  {
        MenuView( showProfile: .constant(true)).environmentObject(UserStore())
    }
}

struct  MenuRow: View {
    var title: String
    var icon: String
    var body: some View {
        HStack(spacing: 16) {
            Image(systemName: icon)
                .font(.system(size: 20, weight: .light))
                .imageScale(.large)
                .frame(width: 32, height: 32)
                .foregroundColor(Color(red: 169 / 255, green: 187 / 255, blue: 212 / 255, opacity: 1))
            
            Text(title )
                .font(.system(size: 20, weight: .bold, design: .default))
                .frame(width: 120, alignment: .leading)
        }
    }
}
                              
