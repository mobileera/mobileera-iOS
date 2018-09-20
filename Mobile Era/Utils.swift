//
//  Utils.swift
//  Mobile Era
//
//  Created by Konstantin Loginov on 22/04/2018.
//  Copyright © 2018 FotMob. All rights reserved.
//

import Foundation
import UIKit

extension Collection where Indices.Iterator.Element == Index {
    
    subscript (safe index: Index) -> Iterator.Element? {
        return indices.contains(index) ? self[index] : nil
    }
}

extension String {
    public func stringSize(_ font: UIFont) -> CGSize {
        return self.stringSize(font, constrainedToSize: CGSize(width: CGFloat.infinity, height: CGFloat.infinity))
    }

    public func stringSize(_ font : UIFont, constrainedToSize : CGSize) -> CGSize {
        return NSString(string: self).boundingRect(with: constrainedToSize, options: .usesLineFragmentOrigin, attributes: [NSAttributedStringKey.font : font], context: nil).size
    }
}

public class UILabelPadding: UILabel {
    
    public var padding = UIEdgeInsets(top: 2, left: 6, bottom: 2, right: 6) {
        didSet {
            invalidateIntrinsicContentSize()
        }
    }
    
    public override func textRect(forBounds bounds: CGRect, limitedToNumberOfLines numberOfLines: Int) -> CGRect {
        let insetRect = UIEdgeInsetsInsetRect(bounds, padding)
        let textRect = super.textRect(forBounds: insetRect, limitedToNumberOfLines: numberOfLines)
        let invertedInsets = UIEdgeInsets(top: -padding.top,
                                          left: -padding.left,
                                          bottom: -padding.bottom,
                                          right: -padding.right)
        return UIEdgeInsetsInsetRect(textRect, invertedInsets)
    }
    
    public override func drawText(in rect: CGRect) {
        super.drawText(in: UIEdgeInsetsInsetRect(rect, padding))
    }
}

extension UIColor {
    public class func fromHex(_ hexValue : Int) -> UIColor {
        return fromHexA(hexValue, 1)
    }
    
    public class func fromHexA(_ hexValue : Int, _  alpha : Float) -> UIColor {
        let red = Float((hexValue & 0xFF0000) >> 16) / Float(255.0)
        let green = Float((hexValue & 0xFF00) >> 8) / Float(255.0)
        let blue = Float((hexValue & 0xFF)) / Float(255.0)
        return UIColor(red: CGFloat(red), green: CGFloat(green), blue: CGFloat(blue), alpha: CGFloat(alpha))
    }
    
    public class func fromRGB(_ r: Int, _ g: Int, _ b: Int) -> UIColor {
        return fromRGBA(r, g, b, 255)
    }
    
    public class func fromRGBA(_ r: Int, _ g: Int, _ b: Int, _ a: Int) -> UIColor {
        return  UIColor(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: CGFloat(a) / 255.0)
    }
}


public class FixedBackgroundUILabel: UILabel {
    public var fixedBackgroundColor: UIColor?
    
    private var _isHighlighted: Bool = false
    public override var isHighlighted: Bool {
        get {
            return _isHighlighted
        }
        set {
            _isHighlighted = newValue
            if let fixedBackgroundColor = fixedBackgroundColor {
                backgroundColor = fixedBackgroundColor
            }
        }
    }
}

public class FixedBackgroundView: UIView {
    override public var backgroundColor: UIColor? {
        didSet {
            if oldValue == UIColor.clear {
                return
            }
            
            if backgroundColor?.cgColor.alpha == 0 {
                backgroundColor = oldValue
            }
        }
    }
}

extension CAShapeLayer {
    func drawCircleAtLocation(location: CGPoint, withRadius radius: CGFloat, andColor color: UIColor, filled: Bool) {
        fillColor = filled ? color.cgColor : UIColor.white.cgColor
        strokeColor = color.cgColor
        let origin = CGPoint(x: location.x - radius, y: location.y - radius)
        path = UIBezierPath(ovalIn: CGRect(origin: origin, size: CGSize(width: radius * 2, height: radius * 2))).cgPath
    }
}

private var handle: UInt8 = 0

extension UIBarButtonItem {
    private var badgeLayer: CAShapeLayer? {
        if let b: AnyObject = objc_getAssociatedObject(self, &handle) as AnyObject? {
            return b as? CAShapeLayer
        } else {
            return nil
        }
    }
    
    func addBadge(number: Int, withOffset offset: CGPoint = CGPoint.zero, andColor color: UIColor = UIColor.red, andFilled filled: Bool = true) {
        guard let view = self.value(forKey: "view") as? UIView else { return }
        
        badgeLayer?.removeFromSuperlayer()
        
        // Initialize Badge
        let badge = CAShapeLayer()
        let radius = CGFloat(7)
        let location = CGPoint(x: view.frame.width - (radius + offset.x), y: (radius + offset.y))
        badge.drawCircleAtLocation(location: location, withRadius: radius, andColor: color, filled: filled)
        view.layer.addSublayer(badge)
        
        // Initialiaze Badge's label
        let label = CATextLayer()
        label.string = "\(number)"
        label.alignmentMode = kCAAlignmentCenter
        label.fontSize = 11
        label.frame = CGRect(origin: CGPoint(x: location.x - 4, y: offset.y), size: CGSize(width: 8, height: 16))
        label.foregroundColor = filled ? UIColor.white.cgColor : color.cgColor
        label.backgroundColor = UIColor.clear.cgColor
        label.contentsScale = UIScreen.main.scale
        badge.addSublayer(label)
        
        // Save Badge as UIBarButtonItem property
        objc_setAssociatedObject(self, &handle, badge, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }
    
    func updateBadge(number: Int) {
        if let text = badgeLayer?.sublayers?.filter({ $0 is CATextLayer }).first as? CATextLayer {
            text.string = "\(number)"
        }
    }
    
    func removeBadge() {
        badgeLayer?.removeFromSuperlayer()
    }
}
