import SwiftUI

struct HomeView: View {
    @Binding var showProfile: Bool
    @State var showUpdate = false
    var body: some View {
        VStack {
            HStack{
                Text("Watching")
                    .font(.system(size: 28, weight: .bold))
                Spacer()
                
                AvatarView(showProfile: $showProfile)
                Button(action: {self.showUpdate.toggle()}) {
                    Image (systemName: "bell")
                        .tint(.black)
                        .font(.system(size: 16, weight: .medium))
                        .frame(width: 36, height: 36)
                        .background(Color.white)
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
            
            HStack(spacing: 12.0) {
                RingView(color1: Color.purple, color2: Color.blue , color3: Color.white, width: 44, height: 44, percent: 68, showCircle: .constant(true))
                VStack(alignment: .leading, spacing: 4.0)  {
                    Text ("7 minute left").font(.subheadline).fontWeight(.bold)
                    Text ("watched 10 mins today").font(.caption)

                }
            }
            .padding(8)
            .background(Color.white)
            .cornerRadius(20)
            .shadow(color:Color.black.opacity(0.2), radius: 20, x: 0, y: 20)
            .shadow(color:Color.black.opacity(0.1), radius: 1, x: 0, y: 1)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 25) {
                    ForEach(sectionData) { item in
                        GeometryReader { geometry in
                            
                        SectionView(section: item)
                                .rotation3DEffect(Angle(degrees:
                Double(geometry.frame(in: .global).minX - 30) / -20
                        ), axis: (x: 0, y: 10.0, z: 0))
                    }
                        .frame(width: 275, height: 275)
                }
            }
               
                .padding(30)
                .padding(.bottom, 30)
                .padding(.trailing, 40)
            }
            Spacer()
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(showProfile: .constant(false))
    }
}


struct SectionView: View {
    var section: Section
    
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
        .frame(width: 275, height: 275)
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

let sectionData = [Section(title: "Prototype designs in SwiftUi ", text: "18 sections" , logo: "Logo1", image: Image("Card5"), color: (Color("colo"))),
    Section(title: "Build a SwiftUI App", text: "20 sections" , logo: "Logo1", image: Image("Card4"), color: (Color("mycol2"))),
    Section(title: "SwiftUI Advanced", text: "15 sections" , logo: "Logo1", image: Image("Card3"), color: (Color("asset"))),
    Section(title: "UI and Animations in SwiftUI ", text: "19 sections" , logo: "Logo1", image: Image("Card1"), color: (Color("mycol3"))),
    Section(title: "SwiftUI Concurrency ", text: "23 sections" , logo: "Logo1", image: Image("Card2"), color: (Color("mycol4"))), ]
