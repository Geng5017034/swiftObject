//
//  NetRequest.swift
//  childrenStar
//
//  Created by gengyongqiang on 16/11/28.
//  Copyright © 2016年 zokun. All rights reserved.
//

import UIKit
import AFNetworking
import RxCocoa
import RxSwift

enum RequestMethod {
    case post
    case get
    case delete
    case put
}

class GYQNetRequest: NSObject {

    lazy var sessionManager : AFHTTPSessionManager = {

        let session = AFHTTPSessionManager()
        session.responseSerializer.acceptableContentTypes = ["application/json", "text/json", "text/javascript","text/html"];
        return session
    }()

    static var sharedInstance : GYQNetRequest {
        struct Static {
            static let instance : GYQNetRequest = GYQNetRequest()
        }
        return Static.instance
    }

    override init() {
        super.init()
    }

    
    func request<T>(method:RequestMethod = .get,
                 path:String = "",
                 header:Dictionary<String,T> = Dictionary<String,T>(),
                 param:Dictionary<String,T> = Dictionary<String,T>(),
                 tastcomplition:@escaping (_ task:URLSessionDataTask) -> Void = {_ in }) -> Observable<Any> {

        sessionManager.requestSerializer.timeoutInterval = TimeInterval(GYQCheckReachability.sharedInstance.timeoutInterval)

        if header.count > 0 {
            setHeaderField(header: header)
        }
        var url:String = ""
        if path.hasPrefix("http://") {
            url = path
        } else {
            url =  "baseurl" + "" + path
        }
        switch method {
            case .get:
                return self.getApi(path: url,
                                   param:param as Dictionary<String, AnyObject>,
                                   tastcomplition: {
                     task in
                     tastcomplition(task)
                })
            case .put:
                return self.putApi(path: url,
                                   param:param as Dictionary<String, AnyObject>,
                                   tastcomplition: {
                                    task in
                                    tastcomplition(task)
                })
            case .delete:
                return self.deleteApi(path: url,
                                   param:param as Dictionary<String, AnyObject>,
                                   tastcomplition: {
                                    task in
                                    tastcomplition(task)
                })
            case .post:
                return self.postApi(path: url,
                                   param:param as Dictionary<String, AnyObject>,
                                   tastcomplition: {
                                    task in
                                    tastcomplition(task)
                })
        }
    }


    //MARK: get 
    func getApi(path:String = "",param:Dictionary<String,AnyObject> = Dictionary<String,AnyObject>(),tastcomplition:@escaping (_ task:URLSessionDataTask) -> Void = {_ in }) -> Observable<Any> {

        return Observable.create {
            [weak self]
            (observer) -> Disposable in
            let requestTask = self?.sessionManager.get(path, parameters: param, progress: nil, success: {
                (task, responseObject) in
                    observer.onNext(responseObject)
                    observer.onCompleted()
                }, failure: {
                    (task, error) in
                    observer.onError(error)
            })
            if let task = requestTask {
                tastcomplition(task)

                print(task.currentRequest?.url?.absoluteString)
            }
            return Disposables.create {
                if let task = requestTask {
                    task.cancel()
                }
            }
            }.shareReplay(1)
    }

    //MARK: post

    func postApi(path:String = "",param:Dictionary<String,AnyObject> = Dictionary<String,AnyObject>(),tastcomplition:@escaping (_ task:URLSessionDataTask) -> Void = {_ in }) -> Observable<Any> {

        return Observable.create {
            [weak self]
            (observer) -> Disposable in
            let requestTask = self?.sessionManager.post(path, parameters: param, progress: nil, success: {
                (task, responseObject) in
                observer.onNext(responseObject)
                observer.onCompleted()
                }, failure: {
                    (task, error) in
                    observer.onError(error)
            })
            if let task = requestTask {
                tastcomplition(task)
            }
            return Disposables.create {
                if let task = requestTask {
                    task.cancel()
                }
            }
        }.shareReplay(1)
    }

    //MARK: delete

    func deleteApi(path:String = "",param:Dictionary<String,AnyObject> = Dictionary<String,AnyObject>(),tastcomplition:@escaping (_ task:URLSessionDataTask) -> Void = {_ in }) -> Observable<Any> {

        return Observable.create {
            [weak self]
            (observer) -> Disposable in
            let requestTask = self?.sessionManager.delete(path, parameters: param, success: {
                (task, responseObject) in
                observer.onNext(responseObject)
                observer.onCompleted()
                }, failure: {
                    (task, error) in
                    observer.onError(error)
            })
            if let task = requestTask {
                tastcomplition(task)
            }
            return Disposables.create {
                if let task = requestTask {
                    task.cancel()
                }
            }
        }.shareReplay(1)
    }
    //MARK: put
    func putApi(path:String = "",param:Dictionary<String,AnyObject> = Dictionary<String,AnyObject>(),tastcomplition:@escaping (_ task:URLSessionDataTask) -> Void = {_ in }) -> Observable<Any> {

        return Observable.create {
            [weak self]
            (observer) -> Disposable in
            let requestTask = self?.sessionManager.put(path, parameters: param, success: {
                (task, responseObject) in
                observer.onNext(responseObject)
                observer.onCompleted()
                }, failure: {
                    (task, error) in
                    observer.onError(error)
            })
            if let task = requestTask {
                tastcomplition(task)
            }
            return Disposables.create {
                if let task = requestTask {
                    task.cancel()
                }
            }
        }.shareReplay(1)
    }


    func uploadImage(path:String = "",
                     param:Dictionary<String,Any> = Dictionary<String,AnyObject>(),
                     data:Data,
                     tastcomplition:@escaping (_ task:URLSessionDataTask) -> Void = {_ in }) -> Observable<Any> {

        return Observable.create {
            [weak self]
            (observer) -> Disposable in

            let requestTask = self?.sessionManager.post(path, parameters: param, constructingBodyWith: {
                formData in
                    let filename = Date().exDateString(format: "yyyyMMddHHmmss") + "user.jpg"
                    formData.appendPart(withFileData: data, name: "file", fileName: filename, mimeType: "jpg")

                }, progress: nil, success: {
                    task,responseObject in
                    observer.onNext(responseObject)
                    observer.onCompleted()

                }, failure: {
                    task,error in
                     observer.onError(error)
            })

            if let task = requestTask {
                tastcomplition(task)
            }
            return Disposables.create {
                if let task = requestTask {
                    task.cancel()
                }
            }
            }.shareReplay(1)



    }

    func setHeaderField<T>(header:Dictionary<String,T>) -> Void {

    }
    

}
