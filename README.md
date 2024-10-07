# Fetch-Recipe-App---iOS

# Steps to Run the App
- Just download the project/zip from github and run it (would be able to work seamlessly)

# Focus Areas: What specific areas of the project did you prioritize? Why did you choose to focus on these areas?
- Architecture and Scalability: Used MVVM with DI and Swift Concurrency to separate business logic and data-fetching making it easier to test.
- State Management: Handled all the states (empty, success, failure and idle) cases for seamless UX.
- Image Caching: Since app performance was the focus, used SDWebImageSwiftUI for proper caching of images to avoid unnecessary bandwith usage and improve performance.
- Test Coverage: Covered entired ViewModel and Network Manager for testing logics

# Time Spent: Approximately how long did you spend working on this project? How did you allocate your time?
- approx 4-4:30 hours. I sat on sunday evening and finished the project and wrote some test-cases in monday morning.

# Trade-offs and Decisions: Did you make any significant trade-offs in your approach?
- Error Handling: Could be done better (e.g could create custom errors as per app requirements for complex app)

# Weakest Part of the Project: What do you think is the weakest part of your project?
- Error Handling: While it covers basic API scenarios and hangles everything that is important for seamless UX, the error messaging could be more informative and custom. For e.g differentiating between network issues, server issues, decoding issues or malformed data
  
# External Code and Dependencies: Did you use any external code, libraries, or dependencies?
- SDWebImageSwiftUI: To ensure image caching are cached to disk, reducing network load and improving performance.

# Additional Information: Is there anything else we should know? Feel free to share any insights or constraints you encountered.
- State Management: I used a simple ApiState enum to handle the various API states, improving code readability and separation of concerns.
