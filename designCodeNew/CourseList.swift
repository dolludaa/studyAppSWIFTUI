

import SwiftUI
import SDWebImageSwiftUI

struct CourseList: View {
    
    @ObservedObject var store = CourseStore()
    @State var active = false
    @State var activeIndex = -1
    @State var avtiveView = CGSize.zero
    
    
    var body: some View {
        ZStack {
            Color.white
                .animation(.linear, value: active)
                .edgesIgnoringSafeArea(.all)
            
            
            ScrollView(showsIndicators: false) {
                VStack(spacing: 20) {
                    Text ("Courses")
                        .font(.largeTitle).bold()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 30)
                        .padding(.top,30)
                        .blur(radius: active ? 20 : 0)
                    
                    
                    ForEach(store.courses.indices, id: \.self ) { index in
                        GeometryReader { geometry in
                            CourseView(
                                show: $store.courses[index].show,
                                course: store.courses[index],
                                active: $active,
                                index: index,
                                activeIndex: self.$activeIndex
                            )
                            .offset(y: store.courses[index].show
                                    ? -geometry.frame (in:.global).minY : 0)
                            .opacity(self.activeIndex != index && self.active ? 0 : 1)
                            .scaleEffect(self.activeIndex != index && self.active ? 0.5 : 1)
                            .offset(x: self.activeIndex != index && self.active ? screen.width : 0)
                            
                            
                        }
                        .frame(height: 280)
                        .frame(maxWidth: self.store.courses[index].show ? .infinity : screen.width - 60)
                        .zIndex(self.store.courses[index].show ? 1 : 0)
                        
                    }
                    
                }
                .frame(width: screen.width)
                .animation(.spring())
            }
        }
        
        
    }
}



struct CourseList_Previews: PreviewProvider {
    static var previews: some View {
        CourseList()
    }
}

struct CourseView: View {
    
    @Binding var show: Bool
    var course: Course
    @Binding var active: Bool
    var index: Int
    @Binding var activeIndex: Int
    @State var activeView = CGSize.zero
    @State var isScrollable = false
    
    var body: some View {
        ZStack(alignment: .top) {
            
            VStack(alignment: .leading, spacing: 30.0) {
                
                Text ("Take your SwiftUI app to the App Store with advanced techniques like API data, packages and CMS")
                
                Text ("About this course")
                    .font(.title).bold()
                
                Text("This course is unlike any other. We care about design and want to make sure that you get better at it in the process. It was written for designers and developers who are passionate about collaborating and building real apps for iOS and macOS. While it's not one codebase for all apps, you learn once and can apply the techniques and controls to all platforms with incredible quality, consistency and performance. It's beginner-friendly, but it's also packed with design tricks and efficient workflows for building great user interfaces and interactions.")
                
                Text("Minimal coding experience required, such as in HTML and CSS. Please note that Xcode 11 and Catalina are essential. Once you get everything installed, it'll get a lot friendlier! I added a bunch of troubleshoots at the end of this page to help you navigate the issues you might encounter.")
            }
            .padding(22)
            .frame(maxWidth: CGFloat(show ? .infinity : screen.width ), maxHeight: show ? 2000 : 280, alignment: .top)
            .offset(y: show ? 350 : 0)
            .background(Color("background1"))
            .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
//            .shadow(color: Color.black.opacity(0.2), radius: 20, x: 0, y: 20)
            .opacity(show ? 1 : 0)
            
            
            
            VStack {
                HStack(alignment: .top) {
                    VStack(alignment: .leading, spacing: 8.0) {
                        Text(course.title)
                            .font(.system(size: 24, weight: .bold))
                            .foregroundColor(Color.white)
                        Text(course.subtitle)
                            .foregroundColor(Color.white.opacity(0.7))
                        
                    }
                    Spacer()
                    ZStack {
                        course.logo
                            .opacity(show ? 0 : 1)
                        
                        VStack {
                            Image(systemName: "xmark")
                                .font(.system(size: 16, weight: .medium))
                                .foregroundColor(.white)
                            
                        }
                        .frame(width: 36, height: 36)
                        .background(Color.black)
                        .clipShape(Circle())
                        .opacity(show ? 1 : 0 )
                        
                    }
                }
                Spacer()
                
                WebImage(url: course.image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: .infinity)
                    .frame(height: 140, alignment: .top)
            }
            .padding(show ? 30 : 20)
            .padding(.top, show ? 30 : 0)
            .frame(width: show ? screen.width : screen.width - 60, height: show ? 360 : 280)
            .background(course.color)
            .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
            .shadow(color: course.color.opacity(0.6), radius: 20, x: 0, y: 20)
            .onTapGesture {
                self.show.toggle()
                self.active.toggle()
                if self.show {
                    self.activeIndex = self.index
                } else {
                    self.activeIndex = -1
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
                    self.isScrollable = true
                }
            }
            
            if isScrollable {
                CourseDetail(course: course, show: $show, active: $active, activeIndex: $activeIndex, activeView: $activeView, isScrollable: $isScrollable)
                    .background(Color.white)
                    .animation(nil)
                    .transition(.identity)
            }
            
        }
        .frame(height: show ? screen.height : 280)
//        .scaleEffect(1 - self.activeView.height / 1000)
        .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0))
        .edgesIgnoringSafeArea(.all)
        
        
    }
}

struct Course: Identifiable {
    var id = UUID()
    var title: String
    var subtitle: String
    var image: URL
    var logo: Image
    var color: Color
    var show: Bool
}

var courseData = [
    Course (title: "Prototype designs in SwiftUi", subtitle: "18 sections", image: URL(string: "https://dl.dropbox.com/s/1e1a5isj56g922q/Card1%402x.png?dl=0")!, logo: Image("Logo1"), color: Color.cyan.opacity(0.5), show: false),
    Course (title: "SwiftUI Advanced", subtitle: "15 sections", image: URL(string: "https://dl.dropbox.com/s/qbfli2ix4efs8jf/Card2%402x.png?dl=0")!, logo: Image("Logo1"), color: Color.teal.opacity(0.5), show: false),
     Course (title: "Build a SwiftUI App", subtitle: "20 sections", image: URL(string: "https://dl.dropbox.com/s/n44t2dpj8lz4l5b/Card4%402x.png?dl=0")!, logo: Image("Logo1"), color: Color.red.opacity(0.5), show: false)
]

