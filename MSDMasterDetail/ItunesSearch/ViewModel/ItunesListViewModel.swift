//
//  ItunesListViewModel.swift
//  MSDMasterDetail
//
//  Created by Michael San Diego on 5/13/20.
//  Copyright © 2020 Michael San Diego. All rights reserved.
//

import Foundation
import RxSwift
import RealmSwift

class ItunesListViewModel {
    
    let disposeBag = DisposeBag()
    let userDefaults = UserDefaults.standard
    let kLastVisit = "lastVisit"

    var onDataChanged:(() -> Void)?
        
    private var itunesMediaInfos = [ItunesMediaInfo]()
    
    func getItunesSearch() {
        ItunesMediaDataManager().getMediaInfos()
            .subscribe(onNext: { mediaInfos in
                self.itunesMediaInfos = mediaInfos
            }, onError: { error in
                print("error - \(error.localizedDescription)")
            }, onCompleted: {
                self.onDataChanged?()
            }).disposed(by: disposeBag)
    }
    
    func numberOfRows() -> Int {
        return itunesMediaInfos.count
    }
    
    func viewModel(at index: Int) -> ItunesMediaInfoViewModel {
        
        let mediaInfo = itunesMediaInfos[index]
        return ItunesMediaInfoViewModel(model: mediaInfo)
    }

    func getPrimaryKey(at index: Int) -> Int {
        
        let mediaInfo = itunesMediaInfos[index]
        let primaryKey = mediaInfo.trackId
        return primaryKey
    }
}
