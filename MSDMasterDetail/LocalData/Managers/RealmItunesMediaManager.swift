//
//  RealmItunesMediaManager.swift
//  MSDMasterDetail
//
//  Created by Michael San Diego on 5/16/20.
//  Copyright © 2020 Michael San Diego. All rights reserved.
//

/*
 
 This is used to manage data from realm database.
 
 */

import Foundation
import RealmSwift

struct RealmItunesMediaManager {
    let realm = RealmProvider.defaultProvider.realm
    
    /** This method saves data object to local/realm database.
    */
    
    func saveMediaInfos(_ mediaInfos:[ItunesMediaInfo], replace: Bool = false) {
        
        let realmObjects = mediaInfos.map {
            self.rlMediaInfo(from: $0)}
        
        try! realm.write {
            if replace == true {
                let currentObjects = realm.objects(RLItunesMediaInfo.self)
                realm.delete(currentObjects)
            }
            realm.add(realmObjects, update: .modified)
        }
    }
    
    /** This method gets data from the realm database and converts it to your specified model.
    */
    
    func fetchMediaInfos() -> [ItunesMediaInfo] {
        
        let objects = realm.objects(RLItunesMediaInfo.self)
        
        return objects.map{ mediaInfo(from: $0) }
    }
    
    /** This method converts your data model  to realm data object.
    */
    
    private func rlMediaInfo(from mediaInfo:ItunesMediaInfo) -> RLItunesMediaInfo {
        return RLItunesMediaInfo(mediaInfo: mediaInfo)
    }
    
    /** This method converts your realm data object to your data model.
    */
    
    func mediaInfo(from rlMediaInfo: RLItunesMediaInfo) -> ItunesMediaInfo {
        return ItunesMediaInfo(
            trackId: rlMediaInfo.trackId,
            trackName: rlMediaInfo.trackName,
            primaryGenreName: rlMediaInfo.primaryGenreName,
            artworkUrl100: rlMediaInfo.artworkUrl100,
            currency: rlMediaInfo.currency,
            longDescription: rlMediaInfo.longDescription,
            trackPrice: rlMediaInfo.trackPrice,
            trackHdPrice: rlMediaInfo.trackHdPrice,
            trackRentalPrice: rlMediaInfo.trackRentalPrice,
            trackHdRentalPrice: rlMediaInfo.trackHdRentalPrice,
            releaseDate: rlMediaInfo.releaseDate)
    }
    
    /** This method gets specific object from realm database using the primaryKey and converts it to your data model.
    */
    
    func getObject(with primaryKey:Int) -> ItunesMediaInfo? {
        let object = realm.object(ofType: RLItunesMediaInfo.self, forPrimaryKey: primaryKey)
        return object.map { mediaInfo(from: $0 )}
    }
}
