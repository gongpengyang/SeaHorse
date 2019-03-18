//
//  NibLoadable.swift
//  OCAlertToSwift
//
//  Created by mac on 2019/2/19.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit

// MARK: - 协议定义

/// 在以下情况下使您的UIView子类符合此协议：
/// *他们*是*基于NIB的，和
/// *此类用作XIB的根视图
///
/// 能够以类型安全的方式从NIB实例化它们
public protocol NibLoadable: class {
    /// 用于加载在XIB中设计的View的新实例的nib文件
    static var nib: UINib { get }
}

// MARK: - 默认实现
public extension NibLoadable {
    // 默认情况下，使用与类名相同的名称，
    /// 并位于该类的包中
    static var nib: UINib {
        return UINib(nibName: String(describing: self), bundle: Bundle(for: self))
    }
}

// MARK: - 支持NIB的实例化
public extension NibLoadable where Self: UIView {
    /**
     返回从nib实例化的`UIView`对象
     - 返回：一个`NibLoadable`，`UIView`实例
     */
    static func loadFromNib() -> Self {
        guard let view = nib.instantiate(withOwner: nil, options: nil).first as? Self else {
            fatalError("The nib \(nib) 根view应该是这种类型： \(self)")
        }
        return view
    }
}
