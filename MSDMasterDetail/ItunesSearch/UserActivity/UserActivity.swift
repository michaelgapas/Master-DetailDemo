//
//  UserActivity.swift
//  MSDMasterDetail
//
//  Created by Michael San Diego on 5/18/20.
//  Copyright © 2020 Michael San Diego. All rights reserved.
//

import Foundation

class NSUserActivityEncoder: NSObject, NSCoding {
    private let activityTypeKey = "activityType"
    private let activityTitleKey = "activityTitle"
    private let activityUserInfoKey = "activityUserInfo"
    
    private (set) var userActivity: NSUserActivity

    init(_ userActivity: NSUserActivity) {
        self.userActivity = userActivity
    }

    required init?(coder: NSCoder) {
        if let activityType = coder.decodeObject(forKey: activityTypeKey) as? String {
            userActivity = NSUserActivity(activityType: activityType)
            if let title = coder.decodeObject(forKey: activityTitleKey) as? String {
                userActivity.title = title
            }
            if let userInfo = coder.decodeObject(forKey: activityUserInfoKey) as? [AnyHashable: Any] {
                userActivity.userInfo = userInfo
            }
        } else {
            return nil
        }
    }

    func encode(with coder: NSCoder) {
        coder.encode(userActivity.activityType, forKey: activityTypeKey)
        coder.encode(userActivity.title, forKey: activityTitleKey)
        coder.encode(userActivity.userInfo, forKey: activityUserInfoKey)
    }
}
