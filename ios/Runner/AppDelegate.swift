import Flutter
import UIKit
import CoreLocation

@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    // Register plugin
    GeneratedPluginRegistrant.register(with: self)
    
    // Set navigation bar appearance
    if #available(iOS 13.0, *) {
      let appearance = UINavigationBarAppearance()
      appearance.configureWithOpaqueBackground()
      appearance.backgroundColor = UIColor(red: 76/255.0, green: 175/255.0, blue: 80/255.0, alpha: 1.0) // Green color for Juniper
      appearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
      UINavigationBar.appearance().standardAppearance = appearance
      UINavigationBar.appearance().scrollEdgeAppearance = appearance
    }
    
    // Ensure we always start with home tab selected
    UserDefaults.standard.set(0, forKey: "last_selected_tab")
    
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
  
  // Handle URL opens for deep linking
  override func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey: Any] = [:]) -> Bool {
    // Process the URL here
    return super.application(app, open: url, options: options)
  }
  
  // Support for background fetch
  override func application(_ application: UIApplication, performFetchWithCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
    // Fetch updated data
    completionHandler(.newData)
  }
}
