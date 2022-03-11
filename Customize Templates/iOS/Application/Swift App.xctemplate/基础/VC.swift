//
//  VC.swift
//  Templates
//
//  Created by 韦烽传 on 2021/12/11.
//

import UIKit

import Print
import Protocol
import Extension

import Network
import JSONValue
import JSONDecoderExtension

import Prompt
import DragLoad

/**
 视图控制器
 */
class VC: UIViewController, StoryboardProtocol, ModalPresentProtocol, NavigationItemProtocol {
    
    // MARK: - StoryboardProtocol
    
    // MARK: - 属性
    
    /// 滑动视图
    @IBOutlet var scrollView: UIScrollView?
    
    /// 刷新视图
    var reloadView = DragLoadTitleView(.down(60))
    /// 加载更多视图
    var loadMoreView = DragLoadTitleView(.up(60))
    
    /// 无网络视图
    var noNetworkView = UIView()
    
    // MARK: - 生命周期
    
    /**
     视图加载
     */
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /// 隐藏默认返回按钮
        navigationItem.hidesBackButton = true
    }
    
    /**
     视图将转换（iPad分屏调整大小、横竖屏切换触发）
     */
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
    }
    
    // MARK: - 导航
    
    /**
     添加导航返回按钮
     */
    func addNavItemBack() {
        
        addNavItem(nil, title: "返回", titleColor: .white, target: self, action: #selector(backEvent(_:)), location: .left)
    }
    
    @IBAction @objc func backEvent(_ sender: Any?) {
        
        navItemBackEvent(nil)
    }
    
    // MARK: - 网络
    
    /**
     添加拖动回调
     */
    func addDragLoadCallback() {
        
        reloadView.dragLoadCallback = { [weak self] in
            
            self?.reload()
        }
        
        loadMoreView.dragLoadCallback = { [weak self] in
            
            self?.loadMore()
        }
    }
    
    /**
     刷新
     */
    func reload() {
        
    }
    
    /**
     加载更多
     */
    func loadMore() {
        
    }
    
    // MARK: - 事件
    
    /**
     显示无网络视图
     */
    func showNoNetworkView() {
        
        if noNetworkView.superview == nil {
            
            view.addSubview(noNetworkView)
            
            noNetworkView.translatesAutoresizingMaskIntoConstraints = false
            
            let lcs = [NSLayoutConstraint(item: noNetworkView, attribute: .left, relatedBy: .equal, toItem: view.safeAreaLayoutGuide, attribute: .left, multiplier: 1, constant: 0),
                       NSLayoutConstraint(item: noNetworkView, attribute: .right, relatedBy: .equal, toItem: view.safeAreaLayoutGuide, attribute: .right, multiplier: 1, constant: 0),
                       NSLayoutConstraint(item: noNetworkView, attribute: .top, relatedBy: .equal, toItem: view.safeAreaLayoutGuide, attribute: .top, multiplier: 1, constant: 0),
                       NSLayoutConstraint(item: noNetworkView, attribute: .bottom, relatedBy: .equal, toItem: view.safeAreaLayoutGuide, attribute: .bottom, multiplier: 1, constant: 0)]
            
            NSLayoutConstraint.activate(lcs)
        }
        
        view.bringSubviewToFront(noNetworkView)
        
        noNetworkView.isHidden = false
    }
    
    /**
     隐藏无网络视图
     */
    func hideNoNetworkView() {
        
        noNetworkView.isHidden = true
    }
    
    // MARK: - deinit
    
    deinit {
        
        NotificationCenter.default.removeObserver(self)
        Print.debug("\(self)")
    }
}
