//
//  DotsLoader.swift
//  Example
//
//  Created by Mathieu Bolard on 12/09/2016.
//  Copyright © 2016 Mathieu Bolard. All rights reserved.
//

import UIKit
import SnapKit
@IBDesignable

class DotsLoaderView: UIView {

    let dotsLoader = DotsLoader(frame:CGRect.zero)
    var touchEnable:Bool = false {
        didSet{
            self.isUserInteractionEnabled = !touchEnable
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)

        self.dotsLoader.tintColor = UIColor.red
        self.addSubview(self.dotsLoader)
        self.dotsLoader.snp.makeConstraints{
            make in
            make.centerX.centerY.equalTo(self)
            make.size.equalTo(CGSize(width:100,height:100))
        }
    }

    func show(inView view:UIView, touch isTouch:Bool) -> Void {

        self.touchEnable = true
        if !view.subviews.contains(self) {
            view.addSubview(self)
            self.snp.makeConstraints{
                make in
                make.left.top.equalTo(view)
                make.width.equalTo(view.snp.width)
                make.height.equalTo(view.snp.height)
            }
            self.layoutIfNeeded()
        }

        self.startAnimation()
    }

    func startAnimation() -> Void {
        self.dotsLoader.alpha = 0
        UIView.animate(withDuration: 0.15, animations: {
            [weak self] in
            self?.dotsLoader.alpha = 1
            }, completion:{
                [weak self] success in
                self?.dotsLoader.startAnimating()

            })

    }

    func stopAnimation() -> Void {

        self.dotsLoader.stopAnimating()
        UIView.animate(withDuration: 0.15, animations: {
            [weak self] in
            self?.dotsLoader.alpha = 0
            },completion:{
                [weak self] success in
                self?.removeFromSuperview()
            })
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}


class DotsLoader : UIView {
    private var dotLayers = [CAShapeLayer]()
    private var dotsScale = 1.4
    
    
    var dotsCount :Int = 3 {
        didSet {
            self.layer.sublayers?.forEach { $0.removeFromSuperlayer() }
            self.dotLayers.removeAll()
            self.setupLayers()
        }
    }
    
    var dotsRadius :CGFloat = 4.2 {
        didSet {
            for layer in dotLayers {
                layer.bounds = CGRect(origin: CGPoint.zero, size: CGSize(width: dotsRadius*2.0, height: dotsRadius*2.0))
                layer.path = UIBezierPath(roundedRect: layer.bounds, cornerRadius: dotsRadius).cgPath
            }
            self.setNeedsLayout()
        }
    }
    
    var dotsSpacing :CGFloat = 4.2 {
        didSet {
            self.setNeedsLayout()
        }
    }
    
    override var tintColor: UIColor! {
        didSet {
            for layer in dotLayers {
                layer.fillColor = tintColor.cgColor
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setupLayers()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.setupLayers()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let center = CGPoint(x: self.frame.size.width/2.0, y: self.frame.size.height/2.0)
        let even = (dotsCount % 2 == 0)
        let middle :Int = dotsCount/2
        for (index, layer) in dotLayers.enumerated() {
            let x = center.x+CGFloat(index-middle)*((dotsRadius*2)+dotsSpacing)+(even ? (dotsRadius+(dotsSpacing/2)) : 0)
            layer.position = CGPoint(x: x, y: center.y)
        }
        startAnimating()
    }
    
    func startAnimating() {
        var offset :TimeInterval = 0.0
        dotLayers.forEach {
            $0.removeAllAnimations()
            $0.add(scaleAnimation(offset), forKey: "scaleAnim")
            offset = offset+0.25
        }
    }


    
    func stopAnimating() {
        dotLayers.forEach { $0.removeAllAnimations() }

    }
    
    private func dotLayer() -> CAShapeLayer {
        let layer = CAShapeLayer()
        layer.bounds = CGRect(origin: CGPoint.zero, size: CGSize(width: dotsRadius*2.0, height: dotsRadius*2.0))
        layer.path = UIBezierPath(roundedRect: layer.bounds, cornerRadius: dotsRadius).cgPath
        layer.fillColor = tintColor.cgColor
        return layer
    }
    
    private func setupLayers() {
        for _ in 0..<dotsCount {
            let layer = dotLayer()
            self.dotLayers.append(layer)
            self.layer.addSublayer(layer)
        }
    }
    
    private func scaleAnimation(_ after: TimeInterval = 0) -> CAAnimationGroup {
        let scaleUp = CABasicAnimation(keyPath: "transform.scale")
        scaleUp.beginTime = after
        scaleUp.fromValue = 1
        scaleUp.toValue = dotsScale
        scaleUp.duration = 0.3
        scaleUp.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        scaleUp.isRemovedOnCompletion = false;
        let scaleDown = CABasicAnimation(keyPath: "transform.scale")
        scaleDown.beginTime = after+scaleUp.duration
        scaleDown.fromValue = dotsScale
        scaleDown.toValue = 1.0
        scaleDown.duration = 0.2
         scaleDown.isRemovedOnCompletion = false;
        scaleDown.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        
        let group = CAAnimationGroup()
        group.animations = [scaleUp, scaleDown]
        group.repeatCount = Float.infinity
        group.isRemovedOnCompletion = false;
        let sum = CGFloat(dotsCount)*0.3+CGFloat(0.4)
        group.duration = CFTimeInterval(sum)
        
        return group
    }
}
