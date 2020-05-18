//
//  ItunesSearchManager.swift
//  MSDMasterDetail
//
//  Created by Michael San Diego on 5/12/20.
//  Copyright © 2020 Michael San Diego. All rights reserved.
//

import Foundation
import RxSwift

class ItunesSearchManager: APIManager {
    
    static func getItunesSearch() -> Observable<ItunesSearchData> {
        return request(APIRouterNetwork.getItunesSearch)
    }
}
