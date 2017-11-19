/**
 Copyright (c) 2016 Razeware LLC
 
 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in
 all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 THE SOFTWARE.
 */
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        UIApplication.shared.statusBarStyle = UIStatusBarStyle.lightContent
        UINavigationBar.appearance().tintColor = UIColor.white
        return true
    }
    
    func presentDetailViewController(_ computer: Computer) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let detailVC = storyboard.instantiateViewController(withIdentifier: "DetailController")
            as! ComputerDetailController
        detailVC.item = computer
        
        // let navigationVC = storyboard.instantiateViewController(withIdentifier: "NavigationController") as! UINavigationController
        // navigationVC.modalPresentationStyle = .formSheet
        
        print("navigation push")
        if let rootVC = self.window?.rootViewController as? UINavigationController {
            rootVC.pushViewController(detailVC, animated: true)
        }
        
        // navigationVC.pushViewController(detailVC, animated: true)
    }
    
    func application(_ application: UIApplication,
                     continue userActivity: NSUserActivity,
                     restorationHandler: @escaping ([Any]?) -> Void) -> Bool {
        
        // 1
        print("step 1")
        guard userActivity.activityType == NSUserActivityTypeBrowsingWeb, let url = userActivity.webpageURL, let components = URLComponents(url: url, resolvingAgainstBaseURL: true) else {
            
            print("step 1a")
            return false
        }
        
        // 2
        print("components: " + components.debugDescription)
        print("components.path: " + components.path)
        print("step 2")
        
        let path = components.path.trimmingCharacters(in: ["/"])
        print("PATH: " + path)
        if let computer = ItemHandler.sharedInstance.items.filter({ $0.path == path }).first {
            print("step 2a")
            
            self.presentDetailViewController(computer)
            return true
        }
        
        // 3
        print("computer1: " + ItemHandler.sharedInstance.items[0].path)
        print("computer2: " + ItemHandler.sharedInstance.items[1].path)
        print("computer3: " + ItemHandler.sharedInstance.items[2].path)
        print("components: " + components.path.debugDescription)
        print("step 3")
        let webpageUrl = URL(string: "https://ios-universal-links-test.herokuapp.com/")!
        application.openURL(webpageUrl)
        
        return false
    }
}
