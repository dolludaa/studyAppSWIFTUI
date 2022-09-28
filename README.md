## :chart_with_upwards_trend: Study SwiftUI App

A full-fledged application that tracks your progress in mastering SwiftUI
<img align="right" width="25%" src="https://user-images.githubusercontent.com/111228178/192774209-d76a67f0-ad4d-40a6-881b-8cc5d28c3491.png">

This application will be useful for anyone who has decided to get to know Swift and SwiftUI better. You can conveniently log into your personal account and use this to track your progress, monitor how long the study takes, how many percent of the course has already been done and how much is still left.


## _WHAT I'VE LEARNED_ :bangbang:
* I studied 3D rotation effect. That helped me to create changing cards effect on the certificate screen, so my animationbecame more dynamic and the screen itself unique :computer:
* Since many lines of code can be repeated, I implemented modifiers in my code that helped make my code cleaner and most importantly more readable
```swift 
struct FontModifier: ViewModifier{
    var style: Font.TextStyle = .body
    func body(content: Content) -> some View {
        content
            .font(.system(style , design: .default))
    }
}
```
 <br>

 While using, this modifier looks like this, which helped me not to overdo it and make my code more flexible

  <br>


 ```swift
 VStack(alignment: .leading, spacing: 4.0)  {
                    Text ("7 minute left").bold().modifier(FontModifier(style: .subheadline))
                    Text ("watched 10 mins today") .modifier(FontModifier(style: .caption ))
                    
                }
                .modifier(FontModifier())
```
* Also, one of the main tasks was to explore the API and JSON. To upload data I created a function that made an API call. It got some data back from the API in JSON format and then I decoded it. To do so, create a class API 
  ```swift
  class API {
    func getPosts(completion: @escaping ([Post]) -> () ) {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else {return}
        
        URLSession.shared.dataTask(with: url) { data, _, _ in
            
            guard let data = data else {return}
            let posts = try! JSONDecoder().decode([Post].self, from: data)
            DispatchQueue.main.async {
                completion(posts)

            }
            
        }
        .resume()
    }
    ```
    
 * While working with the code, I also used two new libraries - ```Combine``` and ```Contentful```. 

> With the help of Contentful, I was able to easily get data. The work will also be facilitated by the Contenful website, where you can easily request all the necessary data and then get them in code :books:

> I also used the Combine library, and with the help of Publisher I entered a variable in order to keep track of all the changes and most importantly they can transmit a sequence of values over time

```swift 
import Contentful
import Combine
```
```swift 
final class CourseStore: ObservableObject {
    @Published var courses: [Course] = []
     
init () {
        let colors = [
            Color.blue,
            .pink,
            .green,
            .brown,
            .cyan,
            .red
        ]
            .map { $0.opacity(0.5) }
        
        getArray(id: "course") { [weak self] items in
            self?.courses = items.enumerated().map { i, item in
                Course(
                    title: item.fields["title"] as! String,
                    subtitle: item.fields["subtitle"] as! String,
                    image: item.fields.linkedAsset(at: "image")?.url ?? URL(string: "")!,
                    logo: Image("Logo1"),
                    color: colors[i % colors.count],
                    show: false
                )
            }
        }
```
 * After my app was ready, I also implemented the dark version :black_large_square: To do this, I worked out all the colors, added suitable dark shades to them, looked at the background, font color. And most importantly, I looked at how the symbols look in the dark version, if necessary, I also corrected them.
 
 * A personal account is available in the application. You need to enter the correct username and password.
 ```swift
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

```                

## More about the app 
 <br>

###  The main 3 screens. 
 <br>



<p align="center" width="100%">
    <img width="30%" src="https://user-images.githubusercontent.com/111228178/192774313-9a35fd89-8bf8-47f2-87ff-fd6b9c459ddd.png">
    <img width="30%" src="https://user-images.githubusercontent.com/111228178/192774318-8213269c-0537-4f16-86e6-bafb042392f9.png">
    <img width="30%" src="https://user-images.githubusercontent.com/111228178/192774323-f9efd185-163e-4172-ab42-cd76eb6cfe9b.png">
</p>

1. The main screen that shows a scroll of courses, a list of courses that you are currently watching and the percentage of how many have been viewed
   
2. List of available courses
   
3. Inside each course there is a detailed description so that everyone can find the course that suits him

# Other features

 <br>

<img align="center" width="100%" src="https://user-images.githubusercontent.com/111228178/192779940-d8d2b0ac-8ea8-4768-bcdb-74aea07fccae.png">

 <br>

 1. The app also has fully custom navigation. clicking on the button of how many percent of the course is left, we go to the screen with available certificates that show how many courses have been completed

 2.  When you click on the certificate itself, we go to a nested screen that shows the name of the course for which the certificate was received, how many classes were in the course and by what percentage the test was finally passed
   
 3.   Also, when we log in to the personal account, we open another additional screen of the personal account, on which there is your photo, name, percentage of how many courses have been completed and various additional services such as payment, settings
     
 4.    And there is also a screen on which updates of courses are shown, which can be edited, added, moved, deleted in every possible way

 <br> 

## Installation

1. Clone or download the project to your local machine
2. Open the project in Xcode
3. In order to log in, you need to enter a login test@mail.ru and the password is 123456
4. Run the simulator


## Keyword
* SwiftUI
* Stacks
* Images and Text
* JSON & Codable
* 3D scroll animation 
* Combine, Contentful 
* Blur
* Firebase 
  

## Prerequisites
* A Mac running macOS Catalina
* Xcode 14



