# ios_test_app_samples_uikit

# Expectation

- Handles Asynchronous Tasks
- Validate the Test

⇒ Expectations when fulfilled indicate that the asynchronous code executed in an expected way 

```swift
class TestingAsyncUsingExpectationsTests: XCTestCase {

    func test_GetAllPosts() {
        
        let expectation = XCTestExpectation(description: "Posts has been downloaded!")
        let url = URL(string: "https://jsonplaceholder.typicode.com/posts")!
        
        var posts = [Post]()
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            guard let data = data, error == nil else {
                XCTFail()
                return
            }
            
            posts =  try! JSONDecoder().decode([Post].self, from: data)
            expectation.fulfill()
            
        }.resume()
        
        wait(for: [expectation], timeout: 2.0)
        XCTAssertTrue(posts.count > 0)
              
    }

}
```

# Notification Test

```swift
import Foundation

extension Notification.Name {
    static let alertNotification = Notification.Name("alertPostedNotification")
}
```

```swift
import Foundation

class AlertManager {
    
    func postAlert() {
        NotificationCenter.default.post(name: Notification.Name.alertNotification, object: self)
    }
}
```

```swift
import XCTest
@testable import TestingMultipleExpectations

class when_posting_two_alerts_using_alert_manager: XCTestCase {

    func test_generates_two_notifications() {
        
        let alertManager = AlertManager()
        
        let exp = expectation(forNotification: Notification.Name.alertNotification, object: alertManager, handler: nil)
        
        exp.expectedFulfillmentCount = 2
        
        alertManager.postAlert()
        alertManager.postAlert()
        
        wait(for: [exp], timeout: 2.0)
        
    }

}
```

# Fake, Mocks, Stubs

### Stub

- Stub provide canned responses for the original object

ex) replace rest api with stub. (fake response)

ex) the piece of code is going to return to you the same exact response that the rest API was actually returning. 

### Fake

- Fakes can have **logic** and they provide test data

ex) pedometer app, testing “if there are 6000 steps, do something”

⇒ Pedometer depends on the device

⇒ Unit test should not depend on the device 

⇒ Create a fake pedometer that will run on the simulator and it will give you some sort of steps. 

### Mock

- Mocks are used to verify behavior

ex) When a user is successfully logged in then they should be taken to the home screen.

⇒ Mock Authentication Service 

# Dummy, Fake, Stubs, Spies, Mocks

- **Dummy** objects are passed around but never actually used. Usually they are just used to fill parameter lists.
- **Fake** objects actually have working implementations, but usually take some shortcut which makes them not suitable for production (an InMemoryTestDatabase is a good example).
- **Stubs** provide canned answers to calls made during the test, usually not responding at all to anything outside what's programmed in for the test.
- **Spies** are stubs that also record some information based on how they were called. One form of this might be an email service that records how many messages it was sent.
- **Mocks** are pre-programmed with expectations which form a specification of the calls they are expected to receive. They can throw an exception if they receive a call they don't expect and are checked during verification to ensure they got all the calls they were expecting.

# Testing Callbacks

```swift
// Test with expectation
// Testing Callback 
func test_WhenAuthDeniedAfterStartGenerateError() {
    let mockPedometer = MockPedometer()
    mockPedometer.error = MockPedometer.notAuthorizedError
    let pedometerVM = PedometerViewModel(pedometer: mockPedometer)
    let exp = expectation(for: NSPredicate(block: { thing, _ in
        // return bool here
        let vm = thing as! PedometerViewModel
        return vm.appState == .notAuthorized
    }), evaluatedWith: pedometerVM, handler: nil)
    pedometerVM.startPedomter()
    wait(for: [exp], timeout: 2.0)
}
```
