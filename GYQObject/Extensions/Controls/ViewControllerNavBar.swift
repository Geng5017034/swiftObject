//
//  ViewControllerExtentsion.swift
//  seven
//
//  Created by gengyongqiang on 16/11/3.
//  Copyright © 2016年 zokun. All rights reserved.
//

import UIKit


protocol ViewControllerSystemNavBar {

    func gyq_setSystemNavigationBar(title:String) -> Void
    func gyq_setSystemNavigationBar(title:String,leftString:String,rightString:String) -> Void
    func gyq_setSystemNavigationBar(title:String,leftImage:UIImage?,rightImage:UIImage?) -> Void
    func gyq_makeSystem(leftbutton:UIButton) -> Void
    func gyq_makeSystem(rightbutton:UIButton) -> Void

}


//为扩展添加属性
private var gyq_leftBt:UIButton = UIButton(type:.custom)
private var gyq_rightBt:UIButton = UIButton(type:.custom)

extension UIViewController:ViewControllerSystemNavBar {

   private(set) var gyq_leftButton:UIButton {
        get {
             return (objc_getAssociatedObject(self, &gyq_leftBt) as? UIButton)!
        } set {
            objc_setAssociatedObject(self, &gyq_leftBt, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }

   private(set) var gyq_rightButton:UIButton {
        get {
            return (objc_getAssociatedObject(self, &gyq_rightBt) as? UIButton)!
        } set {
            objc_setAssociatedObject(self, &gyq_rightBt, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }



    func gyq_setSystemNavigationBar(title: String) {
        self.navigationItem.title = title;
    }

    func gyq_setSystemNavigationBar(title:String,leftString:String,rightString:String) -> Void {
        self.navigationItem.title = title;
        if leftString.characters.count > 0 {

            let leftButton = UIButton(type:.custom);
            leftButton.frame = CGRect(x:0,y:0,width:44,height:44);
            leftButton.setTitle(leftString, for: .normal)
            leftButton.titleLabel?.font = font_13
            var titleEdgeInsets = leftButton.titleEdgeInsets;
            titleEdgeInsets.left = -28.0;
            leftButton.titleEdgeInsets = titleEdgeInsets;
            let leftItem = UIBarButtonItem(customView: leftButton);

            leftButton.addTarget(self, action: #selector(gyq_systemLeftMethod(sender:)), for:.touchUpInside);
            gyq_leftButton = leftButton;
            self.navigationItem.leftBarButtonItem = leftItem;

        }

        if rightString.characters.count > 0 {

        }
    }

    func gyq_setSystemNavigationBar(title:String,leftImage:UIImage?,rightImage:UIImage?) -> Void {
        self.navigationItem.title = title;

        if leftImage != nil {
            let leftButton = UIButton(type:.custom);
            leftButton.frame = CGRect(x:0,y:0,width:44,height:44);
            leftButton.setImage(leftImage, for: .normal);
            var imageEdgeInsets = leftButton.imageEdgeInsets;
            imageEdgeInsets.left = -28.0;
            leftButton.imageEdgeInsets = imageEdgeInsets;
            let leftItem = UIBarButtonItem(customView: leftButton);

            leftButton.addTarget(self, action: #selector(gyq_systemLeftMethod(sender:)), for:.touchUpInside);
            gyq_leftButton = leftButton;
            self.navigationItem.leftBarButtonItem = leftItem;
        }

        if rightImage != nil {
            let rightButton = UIButton(type:.custom);
            rightButton.frame = CGRect(x:0,y:0,width:44,height:44);
            rightButton.setImage(rightImage, for: .normal);
            var imageEdgeInsets = rightButton.imageEdgeInsets;
            imageEdgeInsets.right = -20.0;
            rightButton.imageEdgeInsets = imageEdgeInsets;
            let rightItem = UIBarButtonItem(customView: rightButton);

            rightButton.addTarget(self, action: #selector(gyq_systemRightMethod(sender:)), for:.touchUpInside);

            self.navigationItem.rightBarButtonItem = rightItem;
        }
    }


    func gyq_makeSystem(leftbutton:UIButton) -> Void {
        var contentEdgeInsets = leftbutton.contentEdgeInsets;
        contentEdgeInsets.left = -28.0;
        leftbutton.contentEdgeInsets = contentEdgeInsets;
        leftbutton.addTarget(self, action: #selector(gyq_systemLeftMethod(sender:)), for:.touchUpInside);
        let leftItem = UIBarButtonItem(customView: leftbutton);
        self.gyq_leftButton = leftbutton
        self.navigationItem.leftBarButtonItem = leftItem

    }

    func gyq_makeSystem(rightbutton:UIButton) -> Void {

        var titleEdgeInsets = rightbutton.titleEdgeInsets;
        titleEdgeInsets.right = -20.0;
        rightbutton.titleEdgeInsets = titleEdgeInsets;

        var imageEdgeInsets = rightbutton.imageEdgeInsets;
        imageEdgeInsets.right = -20.0;
        rightbutton.imageEdgeInsets = imageEdgeInsets;

        rightbutton.addTarget(self, action: #selector(gyq_systemRightMethod(sender:)), for:.touchUpInside);
        let rightItem = UIBarButtonItem(customView: rightbutton);

        self.gyq_rightButton = rightbutton
        self.navigationItem.rightBarButtonItem = rightItem
    }


    func gyq_systemLeftMethod(sender:AnyObject) -> Void {

        if let navigationController = self.navigationController {
                navigationController.popViewController(animated: true);
        }

    }

    func gyq_systemRightMethod(sender:AnyObject) -> Void {
        

    }



}

