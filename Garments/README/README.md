## General Information - Build Tools & Version 

- Xcode Version: 13.4.1
- Swift Version: 5
- iOS Version: 15.5 and above

## Key Points

1. Unit testing covers 50% of the code, with a total of 5 tests.
2. Instruments was used to profile the app and fix memory leaks if any were found.
3. Localization of the string files has been enabled by default for future language support.
4. There are no third-party frameworks or external dependencies in the code.
5. A generalized/abstracted code has been created to allow for future extensibility.

## Additional features

A few basic features are added to the app to get a sense of a production-ready application, as there was no hard requirement to add more features than necessary.

1. The app is compatible with iPhone and iPad.
2. Device Orientations supported: Portrait, Upside Down, Landscape Left & Landscape Right.
3. The List screen shows - 'No Products Available' till the time no products are added to the app.
4. Input field becomes active as the ADD Screen opens up to allow immediate entry by the user.
5. The user is not allowed to save the product name until something is written in the input field on ADD screen. As soon as the user starts typing, the save button gets enabled. It is disabled again if the user removes text from the input field to avoid saving empty product name.


## Focus Areas

The main areas focussed were:

1. Use a structural design pattern: MVVM (Model-View-ViewModel) to allow debugging, testing, and reading code easier. 
2. UI Logic can be easily verified with the viewmodel dependency injection, without having to worry about the UI elements being changed later according to the changes in design requirements.
2. CoreData has been used for persistent storage to enable operarions like fetch, sort, and create. 
3. Easy to follow UX has been created to build production-ready UI.
4. Unit testing performed to attain high code coverage.
5. Each method and class are properly documented.

## Architecture

[Model–view–viewmodel] is John Gossman's Architecture.

MVVM separates all the UI logic (presenting the data) from the business logic (processing the data). There is a transparent communication between the layers of the application:
- Model: App data that the app operates on.
- View: The user interface’s visual elements. In iOS, the view controller is inseparable from the concept of the view.
- ViewModel: Updates the model from view inputs and updates views from model outputs.

When a new feature is implemented, these steps are followed:
1. Foremost, the view controller will get called and the view will have a reference to the ViewModel.
2. The View will get some user action and the view will call ViewModel.
3. ViewModel will request database (CoreData) and CoreData sends a response back to the ViewModel.
4. Once we receive a response, ViewModel notifies the view through binding.
5. The View will update the UI with data.

## Contributors

- [Arshdeep Kaur](https://www.linkedin.com/in/arshdeep-kaur-2590b237/)
