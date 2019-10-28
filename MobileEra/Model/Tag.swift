//
//  Tag.swift
//  Mobile Era
//
//  Created by Konstantin Loginov on 22/04/2018.
//  Copyright © 2018 FotMob. All rights reserved.
//

import Foundation
import UIKit

public class Tag: UIButton {

    override public var backgroundColor: UIColor? {
        didSet {
            if backgroundColor?.cgColor.alpha == 0 {
                backgroundColor = oldValue
            }
        }
    }
    
    public func updateState() {
        guard let tag = currentTitle else { return }
        
        alpha = SettingsDataManager.instance.selectedTags.contains(tag) || SettingsDataManager.instance.selectedTags.isEmpty ? 1 : 0.25
    }

    struct LargeTag {
        static let contentEdgeInsets = UIEdgeInsets(top: 6, left: 12, bottom: 6, right: 12)
        static let fontSize: CGFloat = 16
    }
    
    struct SmallTag {
        static let contentEdgeInsets = UIEdgeInsets(top: 2, left: 6, bottom: 2, right: 6)
        static let fontSize: CGFloat = 12
    }
    
    static func createTag(label: String, clickable: Bool = false) -> Tag {
        let tag = Tag()
        tag.setTitle(label, for: .normal)
        tag.setTitleColor(UIColor.white, for: .normal)
        tag.contentEdgeInsets = clickable ? LargeTag.contentEdgeInsets : SmallTag.contentEdgeInsets
        tag.backgroundColor = Tag.color(by: label)
        tag.titleLabel?.font = UIFont.systemFont(ofSize: clickable ? LargeTag.fontSize : SmallTag.fontSize, weight: .semibold)
        tag.sizeToFit()
        tag.layer.cornerRadius = tag.frame.height / 2
        tag.clipsToBounds = true
        tag.alpha = SettingsDataManager.instance.selectedTags.isEmpty || SettingsDataManager.instance.selectedTags.contains(label) ? 1 : 0.7
        return tag
    }
    
    static func color(by name: String) -> UIColor {
        switch name {
        case "Odin":
            return UIColor.fromRGB(187, 94, 125)
        case "Freyja":
            return UIColor.fromRGB(135, 124, 176)
        case "Thon":
            return UIColor.fromRGB(64, 127, 127)
        case "Android":
            return UIColor.fromRGB(164, 198, 57)
        case "iOS":
            return UIColor.fromRGB(95, 201, 248)
        case "tvOS (UX, Design, Swift)":
            return UIColor.fromRGB(95, 201, 248)
        case "Cross-platform":
            return UIColor.fromRGB(179, 142, 248)
        case "Xamarin":
            return UIColor.fromRGB(179, 142, 248)
        case "Flutter":
            return UIColor.fromRGB(179, 142, 248)
        case "Productivity":
            return UIColor.fromRGB(255, 89, 124)
        case "Mobile Web":
            return UIColor.fromRGB(140, 136, 124)
        case "JS-to-Native":
            return UIColor.fromRGB(140, 136, 124)
        case "Security":
            return UIColor.fromRGB(69, 69, 69)
        case "IoT":
            return UIColor.fromRGB(255, 158, 124)
        case "AI":
            return UIColor.fromRGB(242, 213, 0)
        case "Machine Learning":
            return UIColor.fromRGB(72, 31, 240)
        case "Architecture":
            return UIColor.fromRGB(253, 151, 39)
        case "Backend":
            return UIColor.fromRGB(43, 152, 240)
        case "Backends":
            return UIColor.fromRGB(43, 152, 240)
        case "CI":
            return UIColor.fromRGB(205, 218, 73)
        default:
            return UIColor.black
        }
    }
}
