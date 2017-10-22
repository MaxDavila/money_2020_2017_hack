/**
 * Copyright (c) 2017 Razeware LLC
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
 * distribute, sublicense, create a derivative work, and/or sell copies of the
 * Software in any work that is designed, intended, or marketed for pedagogical or
 * instructional purposes related to programming, coding, application development,
 * or information technology.  Permission for such use, copying, modification,
 * merger, publication, distribution, sublicensing, creation of derivative works,
 * or sale is expressly withheld.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

import UIKit
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    // Override point for customization after application launch.
    registerForPushNotifications()

    return true
  }

    func registerForPushNotifications() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) {
            (granted, error) in
            print("Permission granted: \(granted)")
            self.getNotificationSettings()

        }
    }
    
    func getNotificationSettings() {
        UNUserNotificationCenter.current().getNotificationSettings { (settings) in
            print("Notification settings: \(settings)")
            guard settings.authorizationStatus == .authorized else { return }
            UIApplication.shared.registerForRemoteNotifications()
        }
    }
    
    func application(_ application: UIApplication,
                     didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        let tokenParts = deviceToken.map { data -> String in
            return String(format: "%02.2hhx", data)
        }
        
        let token = tokenParts.joined()
        print("Device Token: \(token)")
    }
    
    func application(_ application: UIApplication,
                     didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("Failed to register: \(error)")
    }
    
//    func bootsrap() {
//        // credentials for Synchrony API
//        let syusername = "syusername"
//        let sypa  ssword = "Password1!"
//        let syloginString = String(format: "%@:%@", syusername, sypassword)
//        let syloginData = syloginString.data(using: String.Encoding.utf8)!
//        let base64LoginString = syloginData.base64EncodedString()
//        // create the request for Synchrony API
//        let syurl = URL(string: "https://syf2020.syfwebservices.com/v1_0/next_purchase")!
//        var syrequest = URLRequest(url: syurl)
//        syrequest.httpMethod = "POST"
//        syrequest.setValue("Basic \(base64LoginString)", forHTTPHeaderField: "Authorization")
//        // prepare json data
//        let json: [String: Any] = ["accountNumber": "1337"]
//        let jsonData = try? JSONSerialization.data(withJSONObject: json)
//        // fire off the request
//        let urlConnection = NSURLConnection(request: syrequest, data: jsonData)
//        // parse JSON response
//        var syresponse = [String]()
//        var categories = [String]()
//
//        do {
//            if let data = jsonData,
//                let json = try JSONSerialization.jsonObject(with: data) as? [String: Any],
//                let blogs = json["categories"] as? [[String: Any]] {
//                for category in categories {
//                    if let name = category["categoryName"] as? String {
//                        syresponse.append(name)
//                    }
//                    if let probability = category["probability"] as? String {
//                        syresponse.append(probability)
//                    }
//                }
//            }
//        } catch {
//            print("Error deserializing JSON: \(error)")
//        }
//
//        // Initiate offer for scores > 60
//        if syresponse > 60 {
//            /// credentials for Marqeta API
//            let syusername = "mqusername"
//            let sypassword = "Password1!"
//            let mqloginString = String(format: "%@:%@", mqusername, mqpassword)
//            let mqloginData = mqloginString.data(using: String.Encoding.utf8)!
//            let base64LoginString = loginData.base64EncodedString()
//            // create a user object on Marqeta system
//            let syurl = URL(string: "https://money2020hackathon-api.marqeta.com/v3/users")!
//            var syrequest = URLRequest(url: url)
//            syrequest.httpMethod = "POST"
//            syrequest.setValue("Basic \(base64LoginString)", forHTTPHeaderField: "Authorization")
//            // prepare json data
//            let json: [String: Any] = ["token": "money2020hackathon"]
//            let jsonData = try? JSONSerialization.data(withJSONObject: json)
//            // fire off the request
//            let urlConnection = NSURLConnection(request: syrequest, data: jsonData)
//            // create a card object on Marqeta system
//            let syurl = URL(string: "https://money2020hackathon-api.marqeta.com/v3/cards")!
//            var syrequest = URLRequest(url: url)
//            syrequest.httpMethod = "POST"
//            syrequest.setValue("Basic \(base64LoginString)", forHTTPHeaderField: "Authorization")
//            // prepare json data
//            let json: [String: Any] = ["user_token": "money2020hackathon", "card_product_token":"2020cardproduct"]
//            let jsonData = try? JSONSerialization.data(withJSONObject: json)
//            // fire off the request
//            let urlConnection = NSURLConnection(request: syrequest, data: jsonData)
//            // create a control to lock down to merchant
//            let syurl = URL(string: "https://money2020hackathon-api.marqeta.com/v3/authcontrols")!
//            var syrequest = URLRequest(url: url)
//            syrequest.httpMethod = "POST"
//            syrequest.setValue("Basic \(base64LoginString)", forHTTPHeaderField: "Authorization")
//            // prepare json data
//            let json: [String: Any] = ["user_token": "money2020hackathon", "mid":"123456"]
//            let jsonData = try? JSONSerialization.data(withJSONObject: json)
//            // fire off the request
//            let urlConnection = NSURLConnection(request: syrequest, data: jsonData)
//            // add funds
//            let syurl = URL(string: "https://money2020hackathon-api.marqeta.com/v3/gpaorders")!
//            var syrequest = URLRequest(url: url)
//            syrequest.httpMethod = "POST"
//            syrequest.setValue("Basic \(base64LoginString)", forHTTPHeaderField: "Authorization")
//            // prepare json data
//            let json: [String: Any] = ["user_token": "money2020hackathon", "funding_source_token":"money2020hack", "amount": "10.00"]
//            let jsonData = try? JSONSerialization.data(withJSONObject: json)
//            // fire off the request
//            let urlConnection = NSURLConnection(request: syrequest, data: jsonData)
//            // add funds
//            let syurl = URL(string: "https://money2020hackathon-api.marqeta.com/v3/digitalwalletprovisionrequests/applepay")!
//            var syrequest = URLRequest(url: url)
//            syrequest.httpMethod = "POST"
//            syrequest.setValue("Basic \(base64LoginString)", forHTTPHeaderField: "Authorization")
//            // prepare json data
//            let json: [String: Any] = ["card_token": "money2020card", "device_type": "MOBILE_PHONE"]
//            let jsonData = try? JSONSerialization.data(withJSONObject: json)
//            // fire off the request
//            let urlConnection = NSURLConnection(request: syrequest, data: jsonData)
//
//    }
}

