//
//  NetworkResponse.swift
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

/**
 网络响应结果（`Result`是基本类型和数组时使用）
 */
class NetworkResponse<Result>: Codable where Result : Codable {
	
	// MARK: - 属性
	
    /// 状态
    var status: Int
    /// 消息
    var message: String
    /// 结果
    var result: Result    
}

/**
 网络响应结果（`Result`是模型时使用）
 */
class NetworkResponseOptional<Result>: Codable where Result : Codable {
    
    // MARK: - 属性
    
    /// 状态
    var status: Int
    /// 消息
    var message: String
    /// 结果
    var result: Result?
}
