//
//  KYEdgeInsetsLabel.swift
//  ThinkSNSPlus
//
//  Created by mac on 2019/2/20.
//  Copyright © 2019 ZhiYiCX. All rights reserved.
//

import UIKit
/// 四周可设置间距的label
class KYEdgeInsetsLabel: TSLabel {
    // MARK: - public
    /// edgeInsets ，绘制文本间距
    var m_edgeInsets: UIEdgeInsets = .zero {
        didSet {
            setNeedsDisplay()
        }
    }
    // MARK: - override
    override public var intrinsicContentSize: CGSize {
        var preferredMaxLayoutWidth = self.preferredMaxLayoutWidth
        if preferredMaxLayoutWidth <= 0 {
            preferredMaxLayoutWidth = .greatestFiniteMagnitude
        }
        return sizeThatFits(CGSize(width: preferredMaxLayoutWidth, height: .greatestFiniteMagnitude))
    }
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        /// 水平方向上的间距和
        let hValue: CGFloat = m_edgeInsets.left + m_edgeInsets.right
        /// 垂直方向上的间距和
        let vValue: CGFloat = m_edgeInsets.top + m_edgeInsets.bottom
        var sizeNew = super.sizeThatFits(CGSize(width:size.width - hValue, height:size.height - vValue))
        sizeNew.width += hValue
        sizeNew.height += vValue
        return sizeNew
    }
    override func drawText(in rect: CGRect) {
        super.drawText(in: UIEdgeInsetsInsetRect(rect, m_edgeInsets))
    }
}
