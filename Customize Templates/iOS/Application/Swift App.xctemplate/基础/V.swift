//
//  V.swift
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
 视图
 */
class V: UIView, XIBProtocol {
    
    // MARK: - XIBProtocol
    
	// MARK: - 属性
    
    // MARK: - Nib
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
	
    // MARK: - IB 事件
    
	// MARK: - 事件
    
    // MARK: - deinit
    
    deinit {
        
        NotificationCenter.default.removeObserver(self)
        Print.debug("\(#function): \(self)")
    }
}
