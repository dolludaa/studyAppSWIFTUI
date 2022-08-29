import SwiftUI

struct Buttons: View {
    @State var tap = false
    @State var press = false
    
    
    var body: some View {
        VStack {
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
                        .background(Color("Purple"))
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
