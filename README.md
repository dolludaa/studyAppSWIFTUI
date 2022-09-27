## :chart_with_upwards_trend: Study SwiftUI App

A full-fledged application that tracks your progress in mastering SwiftUI
<img align="right" width="25%" src="https://user-images.githubusercontent.com/111228178/192641799-73055818-821e-4265-8027-2395bdd5475d.png">

This application consists of the main screen, a screen with a list of courses, a separate login and password screen, a screen with certificates and a screen with course updates that can be edited.


## _WHAT I'VE LEARNED_ :bangbang:
* In order to create changing cards effect on the certificate screen, I studied 3D rotation effect, which helped me make my animation more dynamic and the screen itself unique :computer:
* Since many lines of code can be repeated, I implemented modifiers in my code that helped make my code cleaner and clearer, and most importantly more readable
```swift 
struct FontModifier: ViewModifier{
    var style: Font.TextStyle = .body
    func body(content: Content) -> some View {
        content
            .font(.system(style , design: .default))
    }
}
```
 In the main code, this modifier looks like this, which helped me not to overdo it and make my code more flexible

 ```swift
 VStack(alignment: .leading, spacing: 4.0)  {
                    Text ("7 minute left").bold().modifier(FontModifier(style: .subheadline))
                    Text ("watched 10 mins today") .modifier(FontModifier(style: .caption ))
                    
                }
                .modifier(FontModifier())
```
* Also, one of the main tasks was to explore the API and JSON. To upload data we'll create a function that'll make an API call. It'll be getting some data back from the API in JSON format and then I'll be decoding it. To do so, create a class API 
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
    
 * While working with the code, I also used two new libraries - ```Combine``` and ```Contentful```. With the help of these libraries, I was able to easily get data. The work will also be facilitated by the Contenful website, where you can easily download all the necessary data and then get them in code :books:
 * The app is also available in the dark version. :black_large_square: To do this, I worked out all the colors, added suitable dark shades to them, looked at the background, font color. And most importantly, I looked at how the symbols look in the dark version, if necessary, I also corrected them.
 
 * The application has a valid login, a keyboard on which you can enter your email and password and log in to your personal account
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

### The main 4 screens.

1.   On which the login and password are entered in order to get into the personal account
2.   The certificates that can be obtained for completing courses and answers to tests are shown
3.   A list of courses that are available.
4.   Inside each course there is a detailed description so that everyone can find the course that is right for him

<img align="right" width="%" src="https://user-images.githubusercontent.com/111228178/192650072-9fb8620f-e7e6-44eb-9a21-bd1c43a25044.png">



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
