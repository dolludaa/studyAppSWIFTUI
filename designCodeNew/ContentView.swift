import SwiftUI

struct ContentView: View {
    
    @State var show = false
    @State var viewState = CGSize.zero
    @State var showCard = false
    @State var bottomState = CGSize.zero
    @State var showFull = false
    
    var body: some View  {
        ZStack {
            TitleView()
                .blur(radius: show ? 20 : 0)
                .opacity(showCard ? 0.4 : 1)
                .offset(y: showCard ? -200 : 0)
                .animation(
                    .default.delay(0.1),
                    value: showCard
                )
                
            
            BackCardView()
                .frame(width:showCard ? 300 : 340, height: 220)
                .background(show ? Color("colo") : Color("colo"))
                .cornerRadius(20)
                .shadow(radius: 20)
                .offset(x: 0, y: show ? -400 : -40)
                .offset(x: viewState.width, y: viewState.height)
                .offset(y: showCard ? -180 : 0)
                .scaleEffect(showCard ? 1 : 0.9)
                .rotationEffect(.degrees(show ? 0 : 10))
                .rotationEffect(Angle(degrees: showCard ? -10 : 0))
                .rotation3DEffect(Angle(degrees: showCard ? 0 : 10), axis: (x: 10.0, y: 0, z: 0))
                .blendMode(.multiply)
                .animation(.easeIn(duration: 0.3), value: [showCard, show])

            BackCardView()
                .frame(width: 340, height: 220)
                .background(show ? Color("asset") : Color("asset"))
                .cornerRadius(20)
                .shadow(radius: 20)
                .offset(x: 0, y: show ? -200 : -20)
                .offset(x: viewState.width, y: viewState.height)
                .offset(y: showCard ? -140 : 0)
                .scaleEffect(showCard ? 1 : 0.95)
                .rotationEffect(Angle.degrees(show ? 0: 5))
                .rotationEffect(Angle(degrees: showCard ? -5 : 0))
                .rotation3DEffect(Angle(degrees: showCard ? 0 : 5), axis: (x: 10.0, y: 0, z: 0))
                .animation(.easeIn(duration: 0.25), value: [showCard, show])

            CardView()
                .frame(minWidth: 0, maxWidth: showCard ? .infinity : 340)
                .frame(height: 220)
                .background(Color("mycol4"))
                .clipShape(
                    RoundedRectangle(
                        cornerRadius: showCard ? 30 : 20,
                        style: .continuous
                    )
                )
                .shadow(radius: 20)
                .offset(x: viewState.width, y: viewState.height)
                .offset(y: showCard ? -100 : 0)
                .animation(.spring(response: 0.3, dampingFraction: 0.6, blendDuration: 0), value: showCard)
                .onTapGesture {
                    showCard.toggle()
                }
                .gesture(
                    DragGesture().onChanged{ value in
                        showCard = false
                        viewState = value.translation
                        show = true
                    }
                        .onEnded { value in
                            viewState = .zero
                            show = false

                        }
                )
            
            GeometryReader { bounds in
                BottomCardView(showCircle: $showCard)
                    .offset(x: 0, y: showCard ? bounds.size.height / 2 : bounds.size.height + bounds.safeAreaInsets.top + bounds.safeAreaInsets.bottom)
                    .offset(y: bottomState.height)
                    .blur(radius: show ? 20 : 0)
                    .animation(.timingCurve(0.2, 0.8, 0.2, 1, duration: 0.8), value: showCard)
                    .gesture(
                        DragGesture().onChanged { value in
                            bottomState = value.translation
                            if showFull {
                            bottomState.height += -300
                            }
                            if bottomState.height < -300 {
                                bottomState.height = -300
                            }
                        }
                            .onEnded { value in
                                if bottomState.height > 50 {
                                    showCard = false
                                }
                                if (bottomState.height < -100 && !showFull) || (bottomState.height < -250 && showFull) {
                                    bottomState.height = -300
                                    showFull = true
                                } else {
                                    bottomState = .zero
                                    showFull = false
                                    
                                }
                                
                            }
                )
            }
        }
    }
}

struct ContentView_Previews:  PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct CardView: View {
    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading) {
                    Text("Swift UI Full Course")
                        .font(.title)
                        .fontWeight(.semibold)
                        .foregroundColor(Color.white)
                    
                    Text("Certificate")
                        .foregroundColor(Color("accent"))
                }
                Spacer()
                
                Image("Logo1")
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 20)
            Spacer() 
            Image("Card1")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 300, height: 110, alignment: .top)
        }
            }
}

struct BackCardView: View {
    var body: some View {
        VStack {
            Spacer()
        }
         
    }
}

struct TitleView: View {
    var body: some View {
        VStack {
            HStack {
                Text("Certificates")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                Spacer()
            }
            .padding()
            Image("Background1")
            Spacer()
        }
    }
}

struct BottomCardView: View {
    @Binding var showCircle: Bool
    @State var percent: CGFloat = 0
    
    var body: some View {
        VStack(spacing: 20) {
            Rectangle()
                .frame(width: 40, height: 5)
                .cornerRadius(3)
                .opacity(0.1)
            Text("This certificate is proof that Liudmila Dolontaeva has achieved the UI Design course with approval from an instructor.")
                .font(.subheadline)
                .multilineTextAlignment(.center)
                .lineSpacing(4)
            
            HStack(spacing: 20.0) {
                RingView(
                    color1: Color.purple,
                    color2: Color.blue,
                    width: 88,
                    height: 88,
                    percent: 80,
                    showCircle: $showCircle
                )
                
                
                VStack(alignment: .leading, spacing: 8.0) {
                    Text ("Swift UI").fontWeight(.bold)
                    Text ("12 of 12 sections complited \n10 hours spent so far")
                        .font(.footnote)
                        .foregroundColor(.gray)
                        .lineSpacing(4)
                }
                .padding(20)
                .background(Color("background3"))
                .cornerRadius(20)
                .shadow(color: Color.black.opacity(0.2), radius: 20, x: 0, y: 10)
                
            }
            
            Spacer()
            
        }
        .padding(.top, 8)
        .padding(.horizontal, 20)
        .frame(maxWidth: 712)
        .background(BlurView(style: .systemThinMaterial))
        .cornerRadius(30)
        .shadow(radius: 20)
        .frame(maxWidth: .infinity)
    }
}
