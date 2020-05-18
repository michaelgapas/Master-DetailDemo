//
//  ItunesMediaDataManager.swift
//  MSDMasterDetail
//
//  Created by Michael San Diego on 5/16/20.
//  Copyright © 2020 Michael San Diego. All rights reserved.
//

/*

This is used to manage data from the realm database and the cloud data.
This is built to abstract the viewModel on where the data would come from, either the local or cloud.
 
*/

import Foundation
import RxSwift

struct ItunesMediaDataManager {
    let disposeBag = DisposeBag()
    
    func getMediaInfos() -> Observable<[ItunesMediaInfo]> {
        return Observable.create { (observer) -> Disposable in

            let infoObjects = self.mediaInfos()
            
            if !infoObjects.isEmpty {
                observer.onNext(infoObjects)
            }
            
            let infoObjectsObservable = ItunesSearchManager.getItunesSearch()
            
            infoObjectsObservable.subscribe(onNext: { mediaObjects in
                self.saveMediaInfos(mediaObjects.results)
                observer.onNext(mediaObjects.results)
                observer.onCompleted()
            }).disposed(by: self.disposeBag)
            
            return Disposables.create()
        }
    }

    func mediaInfos() -> [ItunesMediaInfo] {
        return RealmItunesMediaManager().fetchMediaInfos()
    }
    
    func saveMediaInfos(_ mediaInfos: [ItunesMediaInfo]){
        RealmItunesMediaManager().saveMediaInfos(mediaInfos)
    }
}
