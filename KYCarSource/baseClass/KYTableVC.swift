//
//  KYTableVC.swift
//  OCAlertToSwift
//
//  Created by mac on 2019/2/23.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit
import MJRefresh
import DZNEmptyDataSet

class KYTableVC: UIViewController {
    
    /// 上提刷新视图
    var m_footRefreshView: MJRefreshFooter?
    /// 下拉刷新视图
    var m_headRefreshView: MJRefreshHeader?
    private var tableViewConstraints: [NSLayoutConstraint] = [NSLayoutConstraint]()
    lazy var m_tableView: UITableView  = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.backgroundColor = .white
        tableView.rowHeight = 44
        tableView.estimatedRowHeight = 0
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        tableView.keyboardDismissMode = UIScrollViewKeyboardDismissMode.onDrag
        tableView.separatorStyle = .none
//        tableView.separatorInset = UIEdgeInsetsMake(0, 16, 0, 0)
//        tableView.separatorColor = UIColor(hex: 0xeeeeee)
        return tableView
    }()
    func uninstallTableViewConstraints() {
        
        m_tableView.removeConstraints(tableViewConstraints)
        m_tableView.removeConstraints(m_tableView.constraints)

        tableViewConstraints = []
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        m_tableView.emptyDataSetSource = self
        m_tableView.emptyDataSetDelegate = self
        if m_tableView.superview == nil {
            view.addSubview(m_tableView)
        }
        if #available(iOS 11.0, *) {
            m_tableView.contentInsetAdjustmentBehavior = .never;
        }
        if m_tableView.frame.size.width < 100 {
            uninstallTableViewConstraints()
            m_tableView.snp.makeConstraints({ (make) in
                make.edges.equalTo(self.view)
            })
            tableViewConstraints = m_tableView.constraints
        }
    }
    
    
    
    // MARK: - MJRefresh下拉刷新
    ///    添加下拉刷新
    func addpull2RefreshWithTableView(_ tableView: UITableView) {
        let header: TSRefreshHeader = TSRefreshHeader(refreshingTarget: self, refreshingAction: #selector(pull2RefreshWithScrollerView(_:)))
        m_tableView.mj_header = header
        m_headRefreshView = tableView.mj_header
        m_tableView.mj_header.endRefreshing()
    }
    // MARK: - MJRefresh上提加载更多
    ///   添加上提加载
    func addPush2LoadMoreWithTableView(_ tableView: UITableView) {
        let footer: TSRefreshFooter = TSRefreshFooter(refreshingTarget: self, refreshingAction: #selector(push2LoadMoreWithScrollerView(_:)))
        
        m_tableView.mj_footer = footer
        m_footRefreshView = tableView.mj_footer;
        m_tableView.mj_footer.endRefreshing()
    }
    
    /// 下拉刷新
    func pull2RefreshWithScrollerView(_ scrollerView: UIScrollView) {}
    /// 上提加载
    func push2LoadMoreWithScrollerView(_ scrollerView: UIScrollView) { }
    /// 停止刷新，包含上 、下
    func endRefreshing() {
        m_tableView.mj_header.endRefreshing()
        m_tableView.mj_footer.endRefreshing()
    }
    
    
    
    
}
extension KYTableVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
}
extension KYTableVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
extension KYTableVC: DZNEmptyDataSetSource {
    
    func image(forEmptyDataSet scrollView: UIScrollView!) -> UIImage! {
        return UIImage(named: "hyEmptyImg")
    }
    
    func title(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        let text = "你还没有常发货源，现在立刻创建一个吧"
        let attributes = [NSFontAttributeName: UIFont.systemFont(ofSize: 16.0),
                          NSForegroundColorAttributeName: UIColor(hex: 0xc5c5c5)]
        return NSAttributedString(string: text, attributes: attributes)
    }
    
    func backgroundColor(forEmptyDataSet scrollView: UIScrollView!) -> UIColor! {
        return UIColor(hex: 0xcffffff)
    }
    /// 图片和文字之间的距离，默认11，UI设计图片上是32
    func spaceHeight(forEmptyDataSet scrollView: UIScrollView!) -> CGFloat {
        /// http://172.16.201.25/qingyidai_UI/APP/%E6%B5%B7%E9%A9%AC%E8%81%8A%E5%A4%A91.0%E7%89%88%E6%9C%AC%E3%80%82/#artboard38
        return 32
    }
}
extension KYTableVC: DZNEmptyDataSetDelegate {

}
