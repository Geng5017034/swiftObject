//
//  GYQIndicator.swift
//  seven
//
//  Created by gengyongqiang on 16/11/25.
//  Copyright © 2016年 zokun. All rights reserved.
//

import UIKit


enum IndicatorShowType {
    case success      //成功状态
    case error        //错误状态
    case warned       //警告状态
    case none         //纯文字状态
}

enum IndicatorStyle {
    case nvActivity   //NVActivityIndicatorView
    case dotsLoader   //DotsLoader
}

class GYQIndicator: NSObject {

    var style:IndicatorStyle = .dotsLoader
    //MARK: property
    /// 弹窗指示器
    lazy var activityIndicatorView :ActivityHud = {
        let activityView = ActivityHud(frame: CGRect.zero)
        return activityView
    }()

    /// 加载指示器
    lazy var dotsLoaderView:DotsLoaderView = {
        let dotsloader = DotsLoaderView(frame:CGRect.zero)
        return dotsloader
    }()

    //MARK:指示器
    /// 弹出指示器 msg 默认为空
    public func showLodding(inView view:UIView,
                            alert msg:String = "",
                            style:IndicatorStyle = .dotsLoader) ->Void {
        self.style = style
        switch style {
            case .dotsLoader:
               dotsLoaderView.show(inView: view, touch: true)
                break
            case .nvActivity:

                activityIndicatorView.show(inView: view, touch: false, text: msg)

                break;
        }
    }

    /// 隐藏指示器
    public func hidden(animation:Bool = true) {

        switch style {
        case .dotsLoader:
            self.dotsLoaderView.stopAnimation()
            break

        case .nvActivity:
            self.activityIndicatorView.stopAnimation()
            break;
        }

    }

    //MARK:toast 提示
    public class func showHint(type:IndicatorShowType = .none , alert msg:String = "") ->Void {
        
        switch type {
            case .warned:
                DispatchQueue.main.async {
                    SwiftNotice.showNoticeWithText(NoticeType.info, text: msg, autoClear: true, autoClearTime: 1.7)
                }
                break
            case .none:
                DispatchQueue.main.async {
                    SwiftNotice.showText(msg,autoClearTime: 1.7)
                }

                break
            case .success:
                DispatchQueue.main.async {
                    SwiftNotice.showNoticeWithText(NoticeType.success, text: msg, autoClear: true, autoClearTime: 1.7)
                }

                break
            case .error:
                DispatchQueue.main.async {
                     SwiftNotice.showNoticeWithText(NoticeType.error, text: msg, autoClear: true, autoClearTime: 1.7)
                }

                break
        }
    }

    //MARK:根据值判断失败类型提示

}
