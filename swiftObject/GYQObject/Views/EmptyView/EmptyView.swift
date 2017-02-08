//
//  EmptyView.swift
//  childrenStar
//
//  Created by gengyongqiang on 16/12/4.
//  Copyright © 2016年 zokun. All rights reserved.
//

import UIKit

private  var _emptyView : EmptyView = EmptyView(frame:CGRect.zero)

extension UIView {

    private(set) var emptyView: EmptyView? {
        get {
            return objc_getAssociatedObject(self, &_emptyView) as? EmptyView
        } set {
            objc_setAssociatedObject(self, &_emptyView, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }

    func showErrorData<T>(error:T,identifer:String) -> Void {


    }

    func showEmpty(msg:String) -> Void {

        if self.emptyView == nil {
            self.emptyView = EmptyView(frame:CGRect.zero)
        }
        if let _ = self.emptyView {
            if !self.subviews.contains(emptyView!) {
                self.addSubview(emptyView!)
                emptyView!.snp.makeConstraints({
                    [weak self]
                    make in
                    make.left.right.bottom.top.equalTo(self!)
                    })
            }

            self.emptyView?.emptyLabel.text = msg

        }

    }

    func hiddenEmytyView() -> Void {
        if let _ = emptyView {
            if self.subviews.contains(emptyView!) {
                self.emptyView!.removeFromSuperview()
                self.emptyView!.repeatBlock = nil
            }

        }

    }
    

}

typealias RepeatBlock = ()-> Void

class EmptyView: UIView {

    var repeatBlock:RepeatBlock?
    let button = UIButton(type:.custom)

    let emptyLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(button)
        //warning:先这样处理
        self.isUserInteractionEnabled = false
        button.addTarget(self, action: #selector(repeatPress), for: .touchUpInside)

        emptyLabel.font = UIFont.systemFont(ofSize: 13)
        emptyLabel.textColor = UIColor.gray
        emptyLabel.textAlignment = .center
        self.addSubview(emptyLabel)
        emptyLabel.snp.makeConstraints{
            [weak self]
            make in
            make.centerX.centerY.equalTo(self!)
            make.width.equalTo(200)
            make.height.equalTo(20)
        }
    }



    func repeatPress() -> Void {
        if let block = repeatBlock  {
            block()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}



