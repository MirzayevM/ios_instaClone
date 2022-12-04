//
//  ios_instaCloneApp.swift
//  ios_instaClone
//
//  Created by Mirzabek on 01/11/22.
//

import SwiftUI
import Firebase
@main
struct ios_instaCloneApp: App {
    @UIApplicationDelegateAdaptor private var appDelegate: AppDelegate
    var body: some Scene {
        WindowGroup {
            StarterScreen().environmentObject(SessionStore())
        }
    }
}
class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()
    return true
  }

}
