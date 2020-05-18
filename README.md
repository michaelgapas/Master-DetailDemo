# MSDMasterDetail

Swift app to demonstrate master-detail application and state preservation and restoration.

## Overview

This sample project demonstrates the master-detail application wherein it shows a list of data that has been parsed from the Itunes Store API and saved to a local database using Realm. This app also preserves and restores app's state information.

## Build and Runtime Requirements

 * Xcode 11.4.1
 * iOS 13.4

## Written in

 * Swift
 * MVVM

## CocoaPods used (links for reference)

 * Alamofire 5.1    : https://cocoapods.org/pods/Alamofire
 * RxSwift 5        : https://cocoapods.org/pods/RxSwift
 * SDWebImage 5.0   : https://cocoapods.org/pods/SDWebImage
 * RealmSwift       : https://cocoapods.org/pods/RealmSwift

## Features and

 * APIManager and NetworkLayer: classes that handles the API consumption. It is mostly coded with RxSwift.
                                Default configuration for network protocols are also defined here.

 * Realm Local Data: Saves data object from cloud to local database.

 * DateStamp: Tracks last date usage of the app with UserDefaults.
              UserDefaults is easy to use and good for storing default information.

 * UserActivity:  Handles restoration and preservation of app's state information.
 
 * Master-Detail: Shows list of data from Itunes Store API and also the details for each.

## Notes

 * To understand more about the usage of each frameworks or methodlogies used, please refer to the links provided.

## Other Resources/Reference

 - Apple Sample Code: State Restoration : https://developer.apple.com/library/content/samplecode/StateRestore/
 - Itunes Web Service Documentation: https://affiliate.itunes.apple.com/resources/documentation/itunes-store-web-service-search-api/#searching

 - Why use Realm? This blog post explains most of the reasons why I used realm in persisting my data. (https://sebastiandobrincu.com/blog/5-reasons-why-you-should-choose-realm-over-coredata)
