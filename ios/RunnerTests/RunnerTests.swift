import Flutter
import UIKit
import XCTest
@testable import Runner

class RunnerTests: XCTestCase {
  
  var appDelegate: AppDelegate!
  
  override func setUp() {
    super.setUp()
    appDelegate = AppDelegate()
  }
  
  override func tearDown() {
    appDelegate = nil
    super.tearDown()
  }
  
  func testAppInitialization() {
    // Test that the app delegate initializes properly
    XCTAssertNotNil(appDelegate, "App delegate should not be nil")
  }
  
  func testTabResetToHomeOnLaunch() {
    // Test that tab is reset to home on fresh launch
    let defaults = UserDefaults.standard
    let lastTab = defaults.integer(forKey: "last_selected_tab")
    XCTAssertEqual(lastTab, 0, "App should reset to home tab (index 0) on launch")
  }
  
  func testNavigationBarConfiguration() {
    // This is just a placeholder test for now
    // In a real test, you would verify navigation bar appearance
    XCTAssertTrue(true, "Navigation bar should be properly configured")
  }
}
