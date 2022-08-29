import SwiftUI

struct Buttons: View {
    
    
    var body: some View {
        VStack(spacing: 50) {
            
            RectangleButton()
            CircleButton()
            PayButton()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color("back").opacity(0.3))
        .animation(.spring(response: 0.5, dampingFraction: 0.5, blendDuration: 0))
    }
}

struct Buttons_Previews: PreviewProvider {
    static var previews: some View {
        Buttons()
    }
}

struct RectangleButton : View {
    @State var tap = false
    @State var press = false
    var body: some View {
        Text("Button")
            .font(.system(size: 20, weight: .semibold, design: .rounded))
            .frame(width: 200, height: 60 )
            .background(
                ZStack {
                    press ? Color.white : Color("back")
                    
                    RoundedRectangle(cornerRadius: 16, style: .continuous)
                        .foregroundColor(press ? Color.white : Color("back2"))
                        .blur(radius: 5)
                        .offset(x: -8, y: -8)
                    
                    RoundedRectangle(cornerRadius: 16, style: .continuous)
                        .fill(
                            LinearGradient(gradient: Gradient(colors: [Color("back2"), Color.white]), startPoint: .topLeading, endPoint: .bottomTrailing)
                        )
                        .padding(2)
                        .blur(radius: 2)
                }
            )
            .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
            .overlay(
                HStack {
                    Image(systemName: "person.crop.circle")
                        .font(.system(size: 26, weight: .light))
                        .foregroundColor(Color.white.opacity(press ? 0 : 1))
                        .frame(width:press ? 67 : 57, height: press ? 4 : 55 )
                        .background(Color("Purple").opacity(0.6))
                        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                        .shadow(color: Color.purple.opacity(0.4), radius: 10, x: 10, y: 10)
                        .offset(x:press ? 70 : -10, y: press ? 16 : 0)
                    Spacer()
                }
            )
            .shadow(color: press ? Color.white : Color("back"), radius: 20, x: 20, y: 20)
            .shadow(color: press ? Color("back")  : Color.white , radius: 20, x: -30, y: -20)
            .scaleEffect(tap ? 1.2 : 1 )
            .gesture(
                LongPressGesture(minimumDuration: 0.5, maximumDistance: 10).onChanged { value in
                    self.tap = true
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1){
                        self.tap = false
                    }
                }
                    .onEnded { value in
                        self.press.toggle()
                    }
            )
    }
}

struct CircleButton: View {
    @State var tap = false
    @State var press = false
    
    var body: some View {
        ZStack {
            Image(systemName: "sun.max")
                .font(.system(size: 44, weight: .light))
                .offset(x: press ? -90 : 0, y: press ? -90 : 0)
                .rotation3DEffect(Angle(degrees:press ? 20 : 0), axis: (x: 10, y: -10, z: 0))
            Image(systemName: "moon")
                .font(.system(size: 44, weight: .light))
                .offset(x: press ? 0 : 90, y: press ? 0 : 90)
                .rotation3DEffect(Angle(degrees:press ? 0 : 20), axis: (x: -10, y: 10, z: 0))
        }
        .frame(width: 100, height: 100)
        .background(
            ZStack {
                LinearGradient(gradient: Gradient(colors: [press ? Color("back2") : Color.white, press ? Color.white : Color("back2")]), startPoint: .topLeading, endPoint: .bottomTrailing)
                
                Circle()
                    .foregroundColor(press ? Color.white : Color("back"))
                    .blur(radius: 5)
                    .offset(x: -8, y: -8)
                Circle()
                    .fill(
                        LinearGradient(gradient: Gradient(colors: [Color("back"), Color.white]), startPoint: .topLeading, endPoint: .bottomTrailing)
                    )
                    .padding(2)
                    .blur(radius: 2)
                
            })
        .clipShape(Circle())
        .shadow(color: press ? Color("back") : Color.white,
                radius: 20, x: -20, y: -20)
        .shadow(color: press ? Color.white : Color("back"), radius: 20, x: 20, y: 20)
        .scaleEffect(tap ? 1.2 : 1)
        .gesture(
            LongPressGesture().onChanged{ value in
                self.tap = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1){
                    self.tap = false
                }
            }
                .onEnded { value in
                    self.press.toggle()
                }
        )
    }
}

struct PayButton: View {
    @GestureState var tap = false
    @State var press = false
    
    var body: some View {
        ZStack {
            Image("fingerprint")
                .opacity(press ? 0 : 1)
                .scaleEffect(press ? 0 : 1)
            
            Image("fingerprint-2")
                .clipShape(Rectangle().offset(y: tap ? 0 : 50))
                .animation(.easeInOut)
                .opacity(press ? 0 : 1)
                .scaleEffect(press ? 0 : 1)
            Image(systemName: "checkmark.circle.fill")
                .font(.system(size: 44, weight: .light))
                .foregroundColor(Color("Purple").opacity(0.7))
                .opacity(press ? 1 : 0)
                .scaleEffect(press ? 1 : 0)
        }
        .frame(width: 120, height: 120)
        .background(
            ZStack {
                LinearGradient(gradient: Gradient(colors: [press ? Color("back2") : Color.white, press ? Color.white : Color("back2")]), startPoint: .topLeading, endPoint: .bottomTrailing)
                
                Circle()
                    .foregroundColor(press ? Color.white : Color("back"))
                    .blur(radius: 5)
                    .offset(x: -8, y: -8)
                Circle()
                    .fill(
                        LinearGradient(gradient: Gradient(colors: [Color("back"), Color.white]), startPoint: .topLeading, endPoint: .bottomTrailing)
                    )
                    .padding(2)
                    .blur(radius: 2)
                
            })
        .clipShape(Circle())
        .overlay(
            Circle()
                .trim(from: tap ? 0.001 : 1 , to: 1)
                .stroke(LinearGradient(gradient: Gradient(colors: [Color("Purple"), Color.purple.opacity(0.2)]), startPoint: .topLeading, endPoint: .bottomTrailing), style: StrokeStyle(lineWidth: 5, lineCap: .round))
                .frame(width: 88, height: 88)
                .rotationEffect(Angle(degrees: 90))
                .rotation3DEffect(Angle(degrees: 180), axis: (x: 1, y: 0, z: 0))
                .shadow(color: Color("back"), radius: 5, x: 3, y: 3)
                .animation(.easeInOut)
        
        )
        .shadow(color: press ? Color("back") : Color.white,
                radius: 20, x: -20, y: -20)
        .shadow(color: press ? Color.white : Color("back"), radius: 20, x: 20, y: 20)
        .scaleEffect(tap ? 1.2 : 1)
        .gesture(
            LongPressGesture().updating($tap) { currentState, gestureState, transaction in
                gestureState = currentState
                
            }
                .onEnded { value in
                    self.press.toggle()
                }
        )
    }
}

