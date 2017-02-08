////
////  SwizzleControllerMethod.swift
////  seven
////
////  Created by gengyongqiang on 16/11/3.
////  Copyright © 2016年 zokun. All rights reserved.
////
//
//import UIKit
//
//extension UIViewController {
//
//
//    open override static func initialize() {
//        struct Static {
//            static var token = NSUUID().uuidString
//        }
//
//        // 确保不是子类
//        if self != UIViewController.self {
//            return
//        }
//
//        DispatchQueue.once(token: Static.token) {
//            let originalSelector = #selector(UIViewController.viewDidLoad)
//            let swizzledSelector = #selector(UIViewController.gyq_viewDidLoad)
//
//            let originalMethod = class_getInstanceMethod(self, originalSelector)
//            let swizzledMethod = class_getInstanceMethod(self, swizzledSelector)
//
//
//            //在进行 Swizzling 的时候,需要用 class_addMethod 先进行判断一下原有类中是否有要替换方法的实现
//            let didAddMethod: Bool = class_addMethod(self, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod))
//            //如果 class_addMethod 返回 yes,说明当前类中没有要替换方法的实现,所以需要在父类中查找,这时候就用到 method_getImplemetation 去获取 class_getInstanceMethod 里面的方法实现,然后再进行 class_replaceMethod 来实现 Swizzing
//
//            if didAddMethod {
//                class_replaceMethod(self, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod))
//            } else {
//                method_exchangeImplementations(originalMethod, swizzledMethod)
//            }
//        }
//    }
//
//    func gyq_viewDidLoad() {
//        self.gyq_viewDidLoad()
//        
//    }
//}
//
//extension DispatchQueue {
//
//
//    private static var onceTracker = [String]()
//
//    open class func once(token: String, block:() -> Void) {
//        objc_sync_enter(self)
//        defer { objc_sync_exit(self) }
//
//        if onceTracker.contains(token) {
//            return
//        }
//        
//        onceTracker.append(token)
//        block()
//    }
//}
