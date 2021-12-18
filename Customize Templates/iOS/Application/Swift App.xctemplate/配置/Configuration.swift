//
//  Configuration.swift
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
 配置
 */
struct Configuration {
    
    /// 是否测试环境
    static let isTest = true
    
    /**
     HTTP
     */
    struct HTTP {
        
        /// 主机
        static let host = isTest ? "https://test.api.com" : "https://api.com"
        /// 版本路径
        static let versionPath = "/"
        /// 接口版本
        static let appVersion = "1.0"
        /// 超时时间
        static let timeoutInterval: TimeInterval = 30
    }
    
    /**
     启动
     */
    static func launch() {
        
        Print.level = isTest ? .debug : .info
        Print.isTime = true
        Print.isFile = isTest
        Print.isFunction = isTest
        Print.isLine = isTest
    }
}
