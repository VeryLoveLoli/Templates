//
//  TBC.swift
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
 标签栏控制器
 */
class TBC: UITabBarController, UITabBarControllerDelegate, StoryboardProtocol {
    
    // MARK: - 生命周期
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        delegate = self
        
        /// 重设标签栏 或者在 `Storyboard` 上重设 `tabBar` 类型
//        setValue(TB(), forKeyPath: "tabBar")
    }
    
    // MARK: - UITabBarControllerDelegate
    
    // MARK: - deinit
    
    deinit {
        
        NotificationCenter.default.removeObserver(self)
        Print.debug("\(self)")
    }
}
