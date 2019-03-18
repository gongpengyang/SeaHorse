//
//  NibOwnerLoadable.swift
//  OCAlertToSwift
//
//  Created by mac on 2019/2/19.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit

// MARK: - 协议定义

/// 在以下情况下使您的UIView子类符合此协议：
/// *他们*是*基于NIB的，和
/// *此类用作XIB的文件所有者
///
/// 能够以类型安全的方式从NIB实例化它们
public protocol NibOwnerLoadable: class {
    /// 用于加载在XIB中设计的View的新实例的nib文件
    static var nib: UINib { get }
}

// MARK: - 默认实现
public extension NibOwnerLoadable {
    /// 默认情况下，使用与类名相同的名称，
    /// 并位于该类的包中
    static var nib: UINib {
        return UINib(nibName: String(describing: self), bundle: Bundle(for: self))
    }
}

// MARK: - 支持NIB的实例化
public extension NibOwnerLoadable where Self: UIView {
    /**
     将从nib加载的内容添加到接收者的子视图列表的末尾，并自动添加约束。
     */
    func loadNibContent() {
        let layoutAttributes: [NSLayoutConstraint.Attribute] = [.top, .leading, .bottom, .trailing]
        for case let view as UIView in Self.nib.instantiate(withOwner: self, options: nil) {
            view.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview(view)
            NSLayoutConstraint.activate(layoutAttributes.map { attribute in
                NSLayoutConstraint(
                    item: view, attribute: attribute,
                    relatedBy: .equal,
                    toItem: self, attribute: attribute,
                    multiplier: 1, constant: 0.0
                )
            })
        }
    }
}

/// Swift < 4.2 support
#if !(swift(>=4.2))
private extension NSLayoutConstraint {
    typealias Attribute = NSLayoutAttribute
}
#endif
