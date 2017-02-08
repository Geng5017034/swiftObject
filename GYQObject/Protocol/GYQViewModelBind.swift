//
//  GYQViewModel.swift
//  seven
//
//  Created by gengyongqiang on 16/11/25.
//  Copyright © 2016年 zokun. All rights reserved.
//

import UIKit
import MJRefresh
///显示错误提示类型
@objc enum ErrorShowType:Int {
    case none            //什么也不提示
    case alert           //警告框提示
    case indicator       //弹窗提示
    case showView      //在页面提示
}

/// 加载下拉刷新状态
@objc enum RefreshViewType:Int {
    case header     // 只要下拉刷新
    case footer     // 是要上拉加载
    case all        // 都要
    case none       // 都不要
}

struct IndicatorConfig {
    public var msg:String?
    public var image:String?
    public var style:IndicatorStyle?
    public var topOffset:Float?

    init(msg:String = "",image:String = "", style:IndicatorStyle = .dotsLoader , topOffset:Float = 0) {
        self.msg = msg
        self.image = image
        self.style = style
        self.topOffset = topOffset
    }
}

//MARK:vc 绑定 viewmodel 协议
protocol GYQViewModelBind : NSObjectProtocol {

    ///**
    // *  统一在基类单独处理
    // *  showEmpty 成功之后是否数据为空
    // *  identfier 标识符
    // */
    func gyq_showSuccess(empty:Bool , identfier:String) -> Void

    ///加载指示器 (默认使用 dotsLoader风格)
    func gyq_showLogingView() -> Void

    ///msg 加载提示语(默认使用 nvActivity风格)
    func gyq_showLogingView(msg:String) -> Void


    ///**
    // *  隐藏lodding
    // *  animation 是否加动画
    // */
    func gyq_hidden(animation:Bool) -> Void

    ///**
    // *  失败在基类 统一调用
    // *  error 失败结果
    // *  urlString 请求连接
    // */
    func gyq_show<T>(error:T , urlStr:String) -> Void
}

///委托控制器默认调用
extension UIViewController : GYQViewModelBind {

    ///加载指示器
    func gyq_showLogingView() {
        self.inficator?.showLodding(inView: self.view)
    }

    ///msg 指示器提示语  默认activityhud
    func gyq_showLogingView(msg: String) {

        self.inficator?.showLodding(inView: UIApplication.shared.keyWindow!, alert: msg, style: .nvActivity)
    }


    /// 提示错误语
    func gyq_show<T>(error: T, urlStr: String) {

        let showErrorType:ErrorShowType? = self.viewModel?.gyq_showError()
        if  let type = showErrorType {
            switch type {
            case .none:            //什么也不提示

                return
            case .alert:           //警告框提示


                print("暂不处理")
                break
            case .indicator:       //弹窗提示


                if error is String {
                    GYQIndicator.showHint(type: .error, alert: error as!String)
                } else if error is NSError {
                    //TODO:以后再细分
                    //            let errors:NSError = error as!NSError
                    let errors:NSError = error as! NSError
                    if errors.code == -999 {
                        return
                    }
                    GYQIndicator.showHint(type: .error, alert: "网络不稳定")
                }
                break
            case .showView:      //在页面提示
                //warning:暂省去缓存这一步
                self.view.showErrorData(error: error, identifer: urlStr)
                guard let _ = self.view.emptyView?.repeatBlock else {
                    self.view.emptyView?.repeatBlock = {
                        [weak self] in
                        self?.viewModel?.repeatRefresh(url: urlStr)
                    }
                    return
                }
                break
            }

        }
    }

    ///成功回调是否显示空白页面（暂无数据页面）### 如果ErrorShowType = .showView 此方法必调
    func gyq_showSuccess(empty: Bool, identfier: String) {
         //warning:延缓处理
        if !empty {
            if let msg = self.viewModel?.gyq_emptyString() {
                self.view.showEmpty(msg: msg)
            } else {
                self.view.showEmpty(msg: "暂无数据")
            }
        } else {
            self.view.hiddenEmytyView()
        }
    }

    ///隐藏指示器
    func gyq_hidden(animation: Bool) {
        self.inficator?.hidden()
    }

}


/// 控制器的数据源
protocol GYQViewControllerDataSource : NSObjectProtocol  {

    ///只弹窗提示
    func gyq_showError() -> ErrorShowType
    ///空白数据页面提示语
    func gyq_emptyString() -> String

}


/// 控制器代理
protocol GYQViewControllerDelegate : NSObjectProtocol {
    ///下拉刷新
    func pullRefresh() -> Void
    ///上拉加载更多
    func pullReloadMore() -> Void
    ///重新请求
    func repeatRefresh(url:String) -> Void
}


///默认实现
extension GYQViewModel : GYQViewControllerDelegate,GYQViewControllerDataSource {

    func pullRefresh() -> Void {

    }

    func pullReloadMore() -> Void {

    }

    func repeatRefresh(url:String) -> Void {

    }

    ///默认弹窗
    func gyq_showError() -> ErrorShowType {
        return .indicator
    }


    func gyq_emptyString() -> String {
        return "暂无数据"
    }

}


protocol GYQViewController {
    ///指示器adpter
    var inficator: GYQIndicator? {get}
}

private var vm:GYQViewModel?
private var inficatorManage:GYQIndicator = GYQIndicator()
extension UIViewController : GYQViewController {

    ///viewmodel
   fileprivate var viewModel: GYQViewModel? {
    get {
        return objc_getAssociatedObject(self, &vm) as? GYQViewModel
    } set {
        objc_setAssociatedObject(self, &vm, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
      }
    }

    internal var inficator: GYQIndicator? {
        return inficatorManage
    }

    final func setViewModel(to vm:GYQViewModel) {
        viewModel = vm
        self.bindedViewModel()
    }

    final func setListRefresh(type: RefreshViewType, listView: UIScrollView) {
        switch type {
            case .all:
                listView.mj_header = MJRefreshNormalHeader.init(refreshingBlock: {
                    [weak self] in
                    print(self!.viewModel!)
                    self?.viewModel?.pullRefresh()
                })
                listView.mj_footer = MJRefreshBackNormalFooter.init(refreshingBlock: {
                    [weak self] in
                    self?.viewModel?.pullReloadMore()
                })

                break;
            case .footer:
                listView.mj_footer = MJRefreshBackNormalFooter.init(refreshingBlock: {

                    [weak self] in
                    self?.viewModel?.pullReloadMore()
                })
                break
            case .header:
                listView.mj_header = MJRefreshNormalHeader.init(refreshingBlock: {
                    [weak self] in
                    self?.viewModel?.pullRefresh()

                })
                break
            case .none:
                break
        }
    }

}


private weak var _vmSource : GYQViewControllerDataSource?
private weak var _vmDelegate : GYQViewControllerDelegate?

extension UIViewController {

    private(set) weak var vmSource:GYQViewControllerDataSource? {
        get {
            return objc_getAssociatedObject(self, &_vmSource) as? GYQViewControllerDataSource
        } set {
            objc_setAssociatedObject(self, &_vmSource, newValue, .OBJC_ASSOCIATION_ASSIGN)
        }
    }

    private(set) weak var vmdelegate:GYQViewControllerDelegate? {
        get {
            return objc_getAssociatedObject(self, &_vmDelegate) as? GYQViewControllerDelegate
        } set {
            objc_setAssociatedObject(self, &_vmDelegate, newValue, .OBJC_ASSOCIATION_ASSIGN)
        }
    }

    func bindedViewModel() -> Void {

            if let vm = viewModel {
                self.vmdelegate = vm
                self.vmSource = vm
                vm.delegate = self
            }
    }
}


