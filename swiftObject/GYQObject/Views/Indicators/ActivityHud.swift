//
//  ActivityHud.swift
//  seven
//
//  Created by gengyongqiang on 16/12/1.
//  Copyright © 2016年 zokun. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class ActivityHud: UIView {

    static let width = 35

    var touchEnable:Bool = false {
        didSet{
            self.isUserInteractionEnabled = !touchEnable
        }
    }

    lazy var activityIndicatorView :NVActivityIndicatorView = {
        let activityView = NVActivityIndicatorView(frame: CGRect(x:100,y:100,width:width,height:width),
                                                   type: NVActivityIndicatorType(rawValue: 18)!)
        return activityView
    }()

    private var blackView:UIView = UIView()
    private var msgLabel:UILabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)

        blackView.backgroundColor = UIColor(red:0, green:0, blue:0, alpha: 0.7)
        blackView.layer.masksToBounds = true
        blackView.layer.cornerRadius = 10
        self.addSubview(blackView)
        blackView.alpha = 0
        blackView.addSubview(self.activityIndicatorView)

        msgLabel.textColor = UIColor.white
        msgLabel.textAlignment = .center
        msgLabel.font = UIFont.systemFont(ofSize: 12)
        msgLabel.adjustsFontSizeToFitWidth = true
        blackView.addSubview(msgLabel)
        self.setConstrants()
    }


    public func show(inView view:UIView, touch isTouch:Bool, text msg:String) -> Void {

        self.touchEnable = isTouch
        if !view.subviews.contains(self) {
            view.addSubview(self)
            self.snp.makeConstraints{
                make in
                make.left.right.bottom.top.equalTo(view)
            }
            self.layoutIfNeeded()
        }
        self.msgLabel.text = msg
        self.startAnimation()
    }

    func setConstrants() -> Void {

        blackView.snp.makeConstraints{
            [weak self]
            make in
            make.centerY.equalTo(self!.snp.centerY).offset(-20)
            make.centerX.equalTo(self!.snp.centerX)
            make.width.height.equalTo(90)

        }

        activityIndicatorView.snp.makeConstraints{
            [weak self]
            make in
            make.centerX.equalTo(self!.blackView)
            make.centerY.equalTo(self!.blackView.snp.centerY).offset(-10)
            make.size.equalTo(CGSize(width:ActivityHud.width,height:ActivityHud.width))
        }

        msgLabel.snp.makeConstraints{
            [weak self]
            make in
            make.top.equalTo(self!.activityIndicatorView.snp.bottom).offset(5)
            make.left.equalTo(self!.blackView.snp.left).offset(2)
            make.right.equalTo(self!.blackView.snp.right).offset(-2)
            make.height.lessThanOrEqualTo(20)

        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func startAnimation() -> Void {

        UIView.animate(withDuration: 0.1, animations: {
            [weak self]
            _ in
            self!.blackView.alpha = 1
            })
        self.activityIndicatorView.startAnimating()

    }

    func stopAnimation() -> Void {
        self.activityIndicatorView.stopAnimating()
        UIView.animate(withDuration: 0.1, animations: {
            [weak self]
            _ in
            self!.blackView.alpha = 0
            },completion:{
                [weak self] success in
                self?.removeFromSuperview()
            })
        
        
    }
    
    
}
