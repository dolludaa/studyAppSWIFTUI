//
//  CourseDetail.swift
//  designCodeNew
//
//  Created by Людмила Долонтаева on 24.08.2022.
//

import SwiftUI
import SDWebImageSwiftUI


struct CourseDetail: View {
    var course: Course
    @Binding var show: Bool
    @Binding var active: Bool
    @Binding var activeIndex: Int
    @Binding var activeView: CGSize
    @Binding var isScrollable: Bool
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack {
                VStack {
                    HStack(alignment: .top) {
                        VStack(alignment: .leading, spacing: 8) {
                            Text(course.title)
                                .font(.system(size: 24, weight: .bold))
                                .foregroundColor(Color.white)
                            Text(course.subtitle)
                                .foregroundColor(Color.white.opacity(0.7))
                            
                        }
                        Spacer()
                        ZStack {
                            VStack {
                                Image(systemName: "xmark")
                                    .font(.system(size: 16, weight: .medium))
                                    .foregroundColor(.white)
                                
                            }
                            .frame(width: 36, height: 36)
                            .background(Color.black)
                            .clipShape(Circle())
                            .offset(x: 2, y: -2)
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
                .onTapGesture {
                    self.show = false
                    self.active = false
                    self.activeIndex = -1
                    self.isScrollable = false 
                }
                .shadow(color: course.color.opacity(0.6), radius: 20, x: 0, y: 20)
                
                VStack(alignment: .leading, spacing: 30.0) {
                    
                    Text ("Take your SwiftUI app to the App Store with advanced techniques like API data, packages and CMS")
                    
                    Text ("About this course")
                        .font(.title).bold()
                    
                    Text("This course is unlike any other. We care about design and want to make sure that you get better at it in the process. It was written for designers and developers who are passionate about collaborating and building real apps for iOS and macOS. While it's not one codebase for all apps, you learn once and can apply the techniques and controls to all platforms with incredible quality, consistency and performance. It's beginner-friendly, but it's also packed with design tricks and efficient workflows for building great user interfaces and interactions.")
                    
                    Text("Minimal coding experience required, such as in HTML and CSS. Please note that Xcode 11 and Catalina are essential. Once you get everything installed, it'll get a lot friendlier! I added a bunch of troubleshoots at the end of this page to help you navigate the issues you might encounter.")
                }
                .padding(22)
                .padding(.bottom, active ? 80 : 0)
            }
        }
    }
}

struct CourseDetail_Previews: PreviewProvider {
    static var previews: some View {
        let course = Course (title: "Prototype designs in SwiftUi", subtitle: "18 sections", image: URL(string: "https://dl.dropbox.com/s/1e1a5isj56g922q/Card1%402x.png?dl=0")!, logo: Image("Logo1"), color: Color.cyan.opacity(0.5), show: false)
        
        CourseDetail(course: course, show: .constant(true),active: .constant(true), activeIndex: .constant(-1), activeView: .constant(.zero), isScrollable: .constant(true))
    }
}

