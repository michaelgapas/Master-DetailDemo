//
//  ItunesMediaInfoViewModel.swift
//  MSDMasterDetail
//
//  Created by Michael San Diego on 5/16/20.
//  Copyright © 2020 Michael San Diego. All rights reserved.
//

import Foundation

struct ItunesMediaInfoViewModel {
    
    var model: ItunesMediaInfo
    
    init(model: ItunesMediaInfo) {
        self.model = model
    }
    
    var imageUrl: URL {
        return URL(string: model.artworkUrl100)!
    }
    
    var name: String {
        return model.trackName
    }
    var price: String {
        return "\(model.currency) \(model.trackPrice) "
    }
    
    var genre: String {
        return model.primaryGenreName
    }
    
    var releaseDate: String {
        let dateFormatterGet = ISO8601DateFormatter()

        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "yyyy"

        let date: Date? = dateFormatterGet.date(from: model.releaseDate)
        
        return dateFormatterPrint.string(from: date ?? Date())
    }
    
    var description: String {
        return model.longDescription
    }
    
    var buyHDPrice: String? {
        if model.trackHdPrice != nil {
            return "Buy HD \(model.currency) \(model.trackHdPrice ?? 0.0)"
        }
        else { return nil }
    }
    
    var rentHDPrice: String? {
        if model.trackHdRentalPrice != nil {
            return "Rent HD \(model.currency) \(model.trackHdRentalPrice ?? 0.0)"
        }
        else { return nil }
    }
    
    var buyPrice: String? {
        return "Buy \(model.currency) \(model.trackPrice)"
    }
    
    var rentPrice: String? {
        if model.trackRentalPrice != nil {
            return "Rent \(model.currency) \(model.trackRentalPrice ?? 0.0)"
        }
        else { return nil }
    }
}
