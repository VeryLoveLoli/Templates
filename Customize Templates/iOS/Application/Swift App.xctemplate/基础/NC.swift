//
//  NC.swift
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
 导航控制器
 */
class NC: UINavigationController, UINavigationControllerDelegate, StoryboardProtocol, NavigationBarProtocol, NavigationGestureBackProtocol, ModalPresentProtocol {
    
    // MARK: - 属性
    
    /// 手势协议
    var gestureRecognizerDelegate: UIGestureRecognizerDelegate?
    
    // MARK: - 生命周期
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        gestureRecognizerDelegate = interactivePopGestureRecognizer?.delegate
        delegate = self
        
        isNavigationBarTranslucent = true
        isNavigationBarScrollShow = false
        navigationBarBackgroundColor = UIColor.blue
        navigationBarBackgroundImage = nil
        navigationBarShadowColor = UIColor.clear
        navigationBarShadowImage = UIImage()
        navigationBarTitleTextAttributes = [.foregroundColor: UIColor.black, .font: UIFont.boldSystemFont(ofSize: 20)]
        
        /*
        /// `true:`点击显示导航和工具栏
        hidesBarsWhenVerticallyCompact = true
        /// `true:`上滑隐藏导航和工具栏
        hidesBarsOnSwipe = true
        /// `true:`点击显示/隐藏导航和工具栏
        hidesBarsOnTap = true
         */
        
    }
    
    // MARK: - UINavigationControllerDelegate
    
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        
        isGestureBack = viewControllers.count > 1
    }
    
    // MARK: - 事件
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        
        viewController.hidesBottomBarWhenPushed = true
        isGestureBack = false
        
        super.pushViewController(viewController, animated: animated)
    }
    
    // MARK: - deinit
    
    deinit {
        
        NotificationCenter.default.removeObserver(self)
        Print.debug("\(#function): \(self)")
    }
}
