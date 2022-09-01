//
//  LoginView.swift
//  designCodeNew
//
//  Created by Людмила Долонтаева on 29.08.2022.
//

import SwiftUI
import Firebase
import FirebaseAuth

struct LoginView: View {
    @State var email = ""
    @State var password = ""
    @State var showAller = false
    @State var allertMessage = ""
    @State var isLoading = false
    @State var isSuccessful = false
    @EnvironmentObject var user: UserStore
    
    
    var body: some View {
        
        ZStack(alignment: .bottom) {
            
            ZStack(alignment: .top) {
                
                Color.white
                    .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
                    .edgesIgnoringSafeArea(.all)
                
                CoverView()
                    .ignoresSafeArea()
                
            }
            .onTapGesture {
                hideKeyboard()
            }
            
            LoginFieldsView(email: $email, password: $password)
                .padding(.bottom, 300)
                .padding(.horizontal, 20)
            
            HStack {
                Text ("Forgot password?")
                    .font(.subheadline)
                
                Spacer()
                
                Button{
                    login()
                } label: {
                    Text ("Log in").foregroundColor(.black)
                }
                .padding(12)
                .padding(.horizontal, 30)
                .background(Color("back").opacity(0.6))
                .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                .shadow(color: Color("Purple").opacity(0.4), radius: 20, x: 0, y: 20)
                .alert(isPresented: $showAller) {
                    Alert(title: Text ("Error \n Something went wrong"), message: Text (allertMessage) , dismissButton: .default(Text("OK")))
                }
            }
            .padding(.horizontal)
            
            
            if isLoading {
                LoadingView()
            }
            
            if isSuccessful {
                SuccessView()
            }
        }
        
    }
    
    func login() {
        hideKeyboard()
        isLoading = true
        
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            isLoading = false
            
            if error != nil {
                allertMessage = error?.localizedDescription ?? ""
                showAller = true
            } else {
                isSuccessful = true
                user.isLogged = true
                UserDefaults.standard.set(true, forKey: "isLogged")
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    isSuccessful = false
                    email = ""
                    password = ""
                }
            }
        }
    }
    
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}

struct CoverView: View {
    
    @State var show = false
    @State var viewState = CGSize.zero
    @State var isDragging = false
    
    var body: some View {
        VStack {
            GeometryReader { geometry in
                Text("Learn design & code.\nFrom scratch.")
                    .font(.system(size: geometry.size.width / 10, weight: .bold))
                    .foregroundColor(.white)
            }
            .frame(maxWidth: 375, maxHeight: 100)
            .padding(.horizontal, 16)
            .offset(x: viewState.width / 15, y: viewState.height / 15)
            
            Text("80 hours of courses for SwiftUI, React and design tools.")
                .font(.subheadline)
                .frame(width: 250)
                .offset(x: viewState.width / 20, y: viewState.height / 20)
            
            
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
                    .rotationEffect(Angle(degrees:show ? 360+90 : 90))
                    .blendMode(.plusDarker)
                 .animation(Animation.linear(duration: 120).repeatForever(autoreverses: false))
                    .onAppear {show = true}
                Image("Blob")
                    .offset(x: -200, y: -250)
                    .rotationEffect(Angle(degrees:show ? 360 : 0),anchor: .leading)
                    .blendMode(.overlay)
                    .animation(Animation.linear(duration: 100).repeatForever(autoreverses: false))
            }
        )
        .background(
            Image("Card3").offset(x: viewState.width/25, y: viewState.height/25)
            ,alignment: .bottom)
        .background(Color("newCol"))
        .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
        .scaleEffect(isDragging ? 0.9 : 1)
                .animation(.timingCurve(0.2, 0.8, 0.2, 1, duration: 0.8))
        
        .rotation3DEffect(Angle(degrees: 5) , axis: (x: viewState.width, y: viewState.height, z: 0))
        .gesture(
            DragGesture().onChanged{ value in
                viewState = value.translation
                isDragging = true
            }
                .onEnded{ value in
                    viewState = .zero
                    isDragging = false
                }
        )
    }
}

struct LoginFieldsView: View {
    
    @Binding var email: String
    @Binding var password: String
    @FocusState var isFocused: Bool
    
    var body: some View {
        VStack {
            
            HStack {
                Image (systemName: "person.crop.circle.fill")
                    .foregroundColor(Color("asset"))
                    .frame(width: 44, height: 44)
                    .background(Color.white)
                    .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                    .shadow(color: Color.black.opacity(0.15), radius: 5, x: 0, y: 5)
                    .padding(.leading)
                
                TextField( "Your email".uppercased(), text: $email)
                    .keyboardType(.emailAddress)
                    .font(.subheadline)
                    .padding(.leading)
                    .frame(height: 44)
                    .focused($isFocused)
            }
            
            Divider()
                .padding(.leading, 80)
            
            HStack {
                Image (systemName: "lock.fill")
                    .foregroundColor(Color("asset"))
                    .frame(width: 44, height: 44)
                    .background(Color.white)
                    .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                    .shadow(color: Color.black.opacity(0.15), radius: 5, x: 0, y: 5)
                    .padding(.leading)
                
                SecureField("Password".uppercased(), text: $password)
                    .keyboardType(.default)
                    .font(.subheadline)
                    .padding(.leading)
                    .frame(height: 44)
                    .focused($isFocused)
            }
        }
        .frame(height: 136)
        .frame(maxWidth: .infinity)
        .background(BlurView(style: .systemMaterial))
        .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
        .shadow(color: Color.black.opacity(0.15), radius: 20, x: 0, y: 20)
    }
}
