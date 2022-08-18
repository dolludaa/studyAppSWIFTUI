

import SwiftUI

struct CourseList: View {
    
    var body: some View {
        VStack {
            CourseView()
        }
    }
}

struct CourseList_Previews: PreviewProvider {
    static var previews: some View {
        CourseList()
    }
}

struct CourseView: View {
    @State var show = false
    
    var body: some View {
        VStack {
            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: 8.0) {
                    Text("Swift UI Advanced")
                        .font(.system(size: 24, weight: .bold))
                        .foregroundColor(Color.white)
                    Text("20 sections")
                        .foregroundColor(Color.white.opacity(0.7))

                }
                Spacer()
                Image("Logo1")
            }
            Spacer()
            Image("Card4")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(maxWidth: .infinity)
                .frame(height: 140, alignment: .top)
        }
        .padding(show ? 30 : 20)
        .padding(.top, show ? 30 : 0)
        .frame(width: show ? screen.width : screen.width - 60, height: show ? screen.height : 280)
        .background(Color.blue.opacity(0.5))
        .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
        .shadow(color: Color.pink.opacity( 0.3), radius: 20, x: 0, y: 20)
        .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0), value: show)
        .onTapGesture {
            self.show.toggle()
        }
        .ignoresSafeArea(.all)
    }
}
