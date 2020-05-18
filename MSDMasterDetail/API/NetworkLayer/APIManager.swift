//
//  APIManager.swift
//  MSDMasterDetail
//
//  Created by Michael San Diego on 5/11/20.
//  Copyright © 2020 Michael San Diego. All rights reserved.
//

import RxSwift
import Alamofire

class APIManager {
    
    internal static func  request<T: Codable> (_ urlConvertible: URLRequestConvertible) -> Observable<T> {

        return Observable<T>.create { observer in

            let decoder = JSONDecoder()
            let request = AF.request(urlConvertible)
            request.responseDecodable(of: T.self, queue: DispatchQueue.main, decoder: decoder, completionHandler: { response in
                
                print("response code - \(String(describing: response.response?.statusCode))")
                switch response.result {
                case .success(let value):
                    do {
                        _ = try JSONSerialization.jsonObject(with: response.data!, options: [])
                        
                        observer.onNext(value)
                        observer.onCompleted()
                    } catch let jsonError {
                        observer.onError(jsonError.localizedDescription as! Error)
                    }
                case .failure(let error):
                    print("Error in getting request - \(error.localizedDescription)")

                    if let data = response.data {
                        let json = try? JSONSerialization.jsonObject(with: data, options: [])
                        print("response error - \(String(describing: json))")
                    }
                }
            })
            return Disposables.create {
                print("cancel/dispose request")
            }
        }
        
        
    }
}
