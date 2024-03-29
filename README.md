#  ✈️

# Example project for Contacts

## Misssion (Completed)

* __Handle the acceptance criteria__
* __Well maintaineable with MVVM architecture & Rx__
* __Unit test cases (Coverage 75%)__

![test case status](https://github.com/ratzr15/telephony-directory/blob/master/Extra/Test%20Case%20Status.png)


## Architecture Details

| Module                         | Deisgn Pattern   | Language           |
| ------------------------------ | --------------   | ------------------ |
| List Module                    | MVVM.            | Swift              |
| Detail Module                  | MVVM.            | Swift              |
| Add/Edit Module                | MVVM.            | Swift              |

## Thirdparty Libs

- **[Moya](https://github.com/Moya/Moya)**  - Networking library with Alamofire
- **[RxSwift](https://github.com/ReactiveX/RxSwift)**   - Reactive Swift  
- **[SnapKit](https://github.com/SnapKit/SnapKit)**   - Autolayout DSL
- **[Kingfisher](https://github.com/onevcat/Kingfisher)**   - Image caching library


## MVVM

* __The reason for using MVVM architecture is to display the possiblities of extending the test cases & using Rx__
* __[MVVM vs VIP](https://medium.com/ios-os-x-development/ios-architecture-patterns-ecba4c38de52)__

## Usage 

* __User can launch the app and find list of contacts from API__
* __User can view details of the contacts - call, message or edit__
* __User can add or remove contact__


## Notes 

* __CleanSwift is not used since we are using MVVM + Rx already__(https://clean-swift.com/add-reactive-ness-clean-swift/)

## Author

- [Rathish Kannan](https://www.linkedin.com/in/rathishkannan/)


## Commit History

![Commit messages(as requested)](https://github.com/ratzr15/telephony-directory/blob/feature/edit/Extra/GitHistory.png)



