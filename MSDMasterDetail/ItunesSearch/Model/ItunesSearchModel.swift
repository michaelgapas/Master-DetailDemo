//
//  ItunesSearchModel.swift
//  MSDMasterDetail
//
//  Created by Michael San Diego on 5/12/20.
//  Copyright © 2020 Michael San Diego. All rights reserved.
//

import Foundation

struct ItunesSearchData: Codable {
    let resultCount: Int
    let results: [ItunesMediaInfo]
}

struct ItunesMediaInfo: Codable {
    let trackId: Int
    let trackName: String
    let primaryGenreName: String
    let artworkUrl100: String
    
    let currency: String
    let longDescription: String
    
    let trackPrice: Double
    let trackHdPrice: Double?
    let trackRentalPrice: Double?
    let trackHdRentalPrice: Double?
    
    let releaseDate: String
}

