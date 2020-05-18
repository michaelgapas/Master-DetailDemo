//
//  RLItunesMediaInfo.swift
//  MSDMasterDetail
//
//  Created by Michael San Diego on 5/15/20.
//  Copyright © 2020 Michael San Diego. All rights reserved.
//

import Foundation
import RealmSwift

@objcMembers class RLItunesMediaInfo: Object {
    
    enum Properties: String {
        case trackId
        case trackName
        case trackPrice
        case primaryGenreName
        case artworkUrl100
        
        case currency
        case longDescription
        
        case trackHdRentalPrice
        case trackRentalPrice
        case trackHdPrice
        
        case releaseDate
    }
    
    dynamic var trackId = -1
    dynamic var trackName = ""
    dynamic var trackPrice = 0.0
    dynamic var primaryGenreName = ""
    dynamic var artworkUrl100 = ""
    
    dynamic var currency = ""
    dynamic var longDescription = ""
    
    dynamic var trackHdRentalPrice = 0.0
    dynamic var trackRentalPrice = 0.0
    dynamic var trackHdPrice = 0.0
    
    dynamic var releaseDate = ""

    override static func primaryKey() -> String? {
        return Properties.trackId.rawValue
    }
    
    convenience init(mediaInfo: ItunesMediaInfo) {
        self.init()
        self.trackId = mediaInfo.trackId
        self.trackName = mediaInfo.trackName
        self.trackPrice = mediaInfo.trackPrice
        self.primaryGenreName = mediaInfo.primaryGenreName
        self.artworkUrl100 = mediaInfo.artworkUrl100
        
        self.currency = mediaInfo.currency
        self.longDescription = mediaInfo.longDescription
        
        self.trackHdPrice = mediaInfo.trackHdPrice ?? 0.0
        self.trackHdRentalPrice = mediaInfo.trackHdRentalPrice ?? 0.0
        self.trackRentalPrice = mediaInfo.trackRentalPrice ?? 0.0
        
        self.releaseDate = mediaInfo.releaseDate
    }
}
