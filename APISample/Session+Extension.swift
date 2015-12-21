//
//  Session+Extension.swift
//  APISample
//
//  Created by shinichiro.todaka on 2015/12/19.
//
//

import APIKit
import RxSwift

extension Session {
    public static func rx_response<T: RequestType>(request: T) -> Observable<T.Response> {
        return create { observer in
            let task = sendRequest(request) { result in
                switch result {
                case .Success(let response):
                    observer.onNext(response)
                    observer.onCompleted()
                case .Failure(let error):
                    observer.onError(error)
                }
            }
            let t = task
            t?.resume()
            
            return AnonymousDisposable {
                task?.cancel()
            }
        }
    }
}