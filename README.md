# bliss-application
Example iOS app developed for Bliss Applications.

## Development Setup:
* Swift 5
* Xcode 11.3.1
* macOS Mojave (10.14.6)

### Libraries/abstractions used:
* SnapKit for view code and auto-layout
* Moya for API requests and more straightforward JSON decoding
* Bindable class to abstract RxSwift Observable and to deliver reactivity
* Architecture: Model-View-ViewModel with Coordinators to handle navigation

### No time available stuff:
* No network handling, empty screens messages or API feedbacks. Integrating with MBProgressHUD (or building our own loading) was one of the next things I would like to have implemented, it would give a much more solid experience. 
* Began refactor of Controllers and ViewModels, but couldn't finish it. Those classes could easily be set as superclasses or protocols and be inherited by its child to increase code reusability.
* I would like to have used Realm as my CoreData alternative, but I'm currently working on a machine that couldn't have been updated (OS and development tools), so Realm turned out to be not an option. 
* I have decided to use a class called Bindable that implements one of the things that I like most when using RxSwift: Observables, but without the need to import such a huge and powerful SDK, keeping my tiny project clean and more feasible to deliver on time.
* Missing pagination on Apple repos screen. I was thinking of building something using the **UITableViewDataSourcePrefetching** protocol, but couldn't achieve a satisfactory result on time.
