//
//  RealmProvider.swift
//  MSDMasterDetail
//
//  Created by Michael San Diego on 5/16/20.
//  Copyright © 2020 Michael San Diego. All rights reserved.
//

/*

**** Basic configurations for realm database.

*/

import Foundation
import RealmSwift

struct RealmProvider {
    let configuration: Realm.Configuration

    internal init(config: Realm.Configuration) {
        configuration = config
    }
    
    var realm: Realm {
        return try! Realm(configuration: configuration)
    }
    
    //MARK: - Defaul Config
    private static let defaultConfig = Realm.Configuration(
        schemaVersion: 1,
        deleteRealmIfMigrationNeeded: true
    )
    
    public static var defaultProvider: RealmProvider = {
        return RealmProvider(config:defaultConfig)
    }()
}
