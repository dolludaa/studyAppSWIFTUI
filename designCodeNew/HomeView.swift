import SwiftUI

struct HomeView: View {
    @Binding var showProfile: Bool
    @State var showUpdate = false
    @Binding var showContent: Bool
    
    var body: some View {
        ScrollView {
            VStack {
                HStack{
                    Text("Watching")
                        .font(.system(size: 28, weight: .bold))
                    Spacer()
                    
                    AvatarView(showProfile: $showProfile)
                    Button(action: {self.showUpdate.toggle()}) {
                        Image (systemName: "bell")
//                            .tint(.black)
                            .foregroundColor(.primary)
                            .font(.system(size: 16, weight: .medium))
                            .frame(width: 36, height: 36)
                            .background(Color("background3"))
                            .clipShape(Circle())
                            .shadow(color: .black.opacity(0.1), radius: 1, x: 0, y: 1)
                            .shadow(color: .black.opacity(0.2), radius: 10, x: 0, y: 10)
                        
                        
                    }
                    .sheet(isPresented: $showUpdate) {
                        UpdateList()
                    }
                }
                .padding(.horizontal)
                .padding(.leading, 20)
                .padding(.top)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    WatchRingsView()
                        .padding(.horizontal, 30)
                        .padding(.bottom, 30)
                        .onTapGesture {
                            showContent = true
                        }
                }
                
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 25) {
                        ForEach(sectionData) { item in
                            GeometryReader { geometry in

                                SectionView(section: item)
                                    .rotation3DEffect(Angle(degrees:
                                                                Double(geometry.frame(in: .global).minX - 70) / 40
                                                           ), axis: (x: 0, y: 10.0, z: 0))
                            }
                            .frame(width: 275, height: 275)
                        }
                    }
                    
                    .padding(30)
                    .padding(.bottom, 30)
                    .padding(.trailing, 40)
                }
                .offset(y: -30)
                
                HStack {
                    Text ("Courses")
                        .font(.title).bold()
                    Spacer()
                }
                .padding(.leading, 30)
                .offset(y: -60)

                
                SectionView(section: sectionData[2], width: screen.width - 60  , height: 275)
                    .offset(y: -60)

                Spacer()
            }
            .frame(width: screen.width)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(showProfile: .constant(false), showContent: .constant(false ))
    }
}


struct SectionView: View {
    var section: Section
    var width: CGFloat = 275
    var height: CGFloat = 275
    
    var body: some View {
        VStack {
            HStack(alignment: .top) {
                Text (section.title)
                    .font(.system(size: 24, weight: .bold))
                    .frame(width: 160,alignment: .leading)
                    .foregroundColor(.white)
                Spacer()
                Image(section.logo)
            }
            Text (section.text.uppercased())
                .frame(maxWidth: .infinity, alignment: .leading)
            
            section.image
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 210)
        }
        .padding(.top, 20)
        .padding(.horizontal, 20)
        .frame(width: width, height: height)
        .background(section.color)
        .cornerRadius(30)
        .shadow(color: section.color.opacity(0.6), radius: 20, x: 0, y: 20)
    }
}

struct Section: Identifiable{
    var id = UUID()
    var title: String
    var text: String
    var logo:String
    var image: Image
    var color: Color
}

let sectionData = [Section(title: "Prototype designs in SwiftUi", text: "18 sections" , logo: "Logo1", image: Image("Card5"), color: (Color("colo"))),
                   Section(title: "Build a SwiftUI App", text: "20 sections" , logo: "Logo1", image: Image("Card4"), color: (Color("mycol2"))),
                   Section(title: "SwiftUI Advanced", text: "15 sections" , logo: "Logo1", image: Image("Card3"), color: (Color("asset"))),
                   Section(title: "UI and Animations in SwiftUI ", text: "19 sections" , logo: "Logo1", image: Image("Card1"), color: (Color("mycol3"))),
                   Section(title: "SwiftUI Concurrency ", text: "23 sections" , logo: "Logo1", image: Image("Card2"), color: (Color("mycol4"))), ]

struct WatchRingsView: View {
    var body: some View {
        HStack(spacing: 15) {
            HStack(spacing: 12.0) {
                RingView(color1: Color.purple, color2: Color.cyan, width: 44, height: 44, percent: 53 , showCircle: .constant(true))
              
                VStack(alignment: .leading, spacing: 4.0)  {
                    Text ("7 minute left").bold().modifier(FontModifier(style: .subheadline))
                    Text ("watched 10 mins today") .modifier(FontModifier(style: .caption ))
                    
                }
                .modifier(FontModifier())
            }
            .padding(8)
            .background(Color("background3"))
            .cornerRadius(20)
            .modifier(ShadowModifier())
            
            
            HStack(spacing: 12.0) {
                
                RingView(color1: Color.white, color2: Color.blue, width: 32, height: 32, percent: 68, showCircle: .constant(true))
            }
            .padding(8)
            .background(Color("background3"))
            .cornerRadius(20)
            .modifier(ShadowModifier())
            
            
            HStack(spacing: 12.0) {
                RingView(color1:Color.purple, color2: Color.white, width: 32, height: 32, percent: 88 , showCircle: .constant(true))
                
            }
            .padding(8)
            .background(Color("background3"))
            .cornerRadius(20)
            .modifier(ShadowModifier())
            
            
            HStack(spacing: 12.0) {
                RingView(color1: Color("mycol3"), color2: Color.brown,width: 32, height: 32, percent: 90, showCircle: .constant(true))
                
            }
            .padding(8)
            .background(Color("background3"))
            .cornerRadius(20)
            .modifier(ShadowModifier())
        }
    }
}
