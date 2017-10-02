Sixt-Assignment
=====================================
## Problem ##

The problem statement is
  * At http://www.codetalk.de/cars.json you get a JSON list of cars with some basic information.
  * Implement an iOS app with the latest tools in SWIFT, that downloads this file and use all information available that you think makes sense to display:
    * Displays these cars in a list.
    * Displays these cars on a map.
    * Note: The carImageUrl is not up to date anymore, therefore, you can get the correct URL to the car image using this pattern:
https://prod.drive-now-content.com/fileadmin/user_upload_global/assets/cars/{modelIdentifier}/{color}/2x/car.png
    * In case there are still images missing, use a fallback.
    * You may use any external frameworks / libraries you like, just add a short note why you chose this one and what you use it for.
      * No Rx*/Reactive*
    * Focus more on architecture, structure & clean code, less on design.
    
## Solution ##

The code is written in Swift 4.0 (although needed Pods to compile in Swift 3.2, as they were not updated).

### Architecture ###
The code is in **[RIBLER](https://eng.uber.com/new-rider-app/)** architecture introduced by _UBER_ in this [post](https://eng.uber.com/new-rider-app/).
![picture alt](http://eng.uber.com/wp-content/uploads/2016/12/riblets.png)

RIBLER is actually an adaptation of 
**[VIPER](https://www.google.co.in/url?sa=t&rct=j&q=&esrc=s&source=web&cd=3&ved=0ahUKEwjxkP-B_9DWAhUJP48KHU0eDP0QFggtMAI&url=https%3A%2F%2Fwww.objc.io%2Fissues%2F13-architecture%2Fviper%2F&usg=AOvVaw2qUYV6vglF7jK2W3Z0FewL)**, 
with a solution to its [incoherent problem of communication between modules](https://medium.com/@ankoma22/the-good-the-bad-and-the-ugly-of-viper-architecture-for-ios-apps-7272001b5347).
![picture alt](http://eng.uber.com/wp-content/uploads/2016/12/riblet_comms.png)

### Libraries ###
  * [Alamofire](https://github.com/Alamofire/Alamofire)
    - I used Alamofire to make Network calls. Although it was a single simple API call which could have been easily done with NSURLSesssion, I used Alamofire as it playes well with Alamofire Object Mapper
  * [Alamofire Object Mapper](https://github.com/tristanhimmelman/AlamofireObjectMapper)
    - To parse JSON to PONSOs
  * [Kingfisher](https://github.com/onevcat/Kingfisher)
    - To download and use images
