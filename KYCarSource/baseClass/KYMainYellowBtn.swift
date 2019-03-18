//
//  KYMainYellowBtn.swift
//  OCAlertToSwift
//
//  Created by mac on 2019/2/15.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit
/// 主要黄色的按钮
class KYMainYellowBtn: TSButton {
    override var isHighlighted: Bool {
        get {
            return false
        }
        set {}
    }
    private func configUI() {
        let corner: CGFloat = 2.0
        clipsToBounds = true
        layer.cornerRadius = corner
        /// #39383E 100%
        setTitleColor(UIColor(hex: 0x39383e), for: .normal)
        titleLabel?.font = UIFont.systemFont(ofSize: 18)
        /// #FDDA43 100%
        let norImg = image(color: UIColor(hex: 0xfdda43))
        setBackgroundImage(norImg, for: .normal)
        /// 禁用状态下颜色改变
//        let disableStatusChangeColor = true
//        if (disableStatusChangeColor) {
            /// #FDDA43 100%
            //            setTitleColor(UIColor.init(rgba: "#FDDA43"), for: .disabled)
            //            let norImg = image(color: UIColor.yellow)
            //            setBackgroundImage(norImg, for: .normal)
//        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        configUI()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configUI()
    }
    // MARK: - 可抽取或调用外部方法
    private func image(color: UIColor, frame: CGRect) -> UIImage {
        UIGraphicsBeginImageContext(frame.size)
        guard let context = UIGraphicsGetCurrentContext() else {
            return UIImage()
        }
        context.setFillColor(color.cgColor)
        context.fill(frame)
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return img ?? UIImage()
    }
    private func image(color: UIColor) -> UIImage {
        return image(color: color, frame: CGRect(x: 0, y: 0, width: 1, height: 1))
    }
}
