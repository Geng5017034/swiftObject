//
//  GYQCheckReachability.swift
//  seven
//
//  Created by gengyongqiang on 16/11/28.
//  Copyright © 2016年 zokun. All rights reserved.
//

import UIKit
import AFNetworking

enum ReachabilityStatus {
    case not                  //无网络
    case viaWWAN
    case wifi
    case via3g
    case via4g
}

class GYQCheckReachability: NSObject {

    private(set) var timeoutInterval:Int = 10
    public var status:ReachabilityStatus = .not

    static var sharedInstance : GYQCheckReachability {
        struct Static {
            static let instance : GYQCheckReachability = GYQCheckReachability()
        }
        return Static.instance
    }

    override init() {
        super.init()
        self.checkReachblitity()
    }

    private func checkReachblitity() {

        AFNetworkReachabilityManager.shared().startMonitoring()

        AFNetworkReachabilityManager.shared().setReachabilityStatusChange{
            status in
            switch status {
                case .notReachable:
                    self.timeoutInterval = 5
                    self.status = .not
                print("无网络链接")

                case .reachableViaWWAN:
                    self.timeoutInterval = 20
                    self.status = .viaWWAN
                print("无线网络链接")

                case .reachableViaWiFi:
                print("WiFi网络链接")
                    self.timeoutInterval = 10
                    self.status = .wifi
                case .unknown:
                     self.timeoutInterval = 5
                     self.status = .not
                print("无网络链接")


            }
        }
    }
}
