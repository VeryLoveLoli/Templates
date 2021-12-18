//
//  HTTP.swift
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
 HTTP
 */
struct HTTP {
    
    // MARK: - 属性
    
    /// 签名密钥
    private static let signKey = ""
    /// 令牌
    private static var token = ""
    
    // MARK: - 请求
    
    /**
     加载请求
     
     - parameter     host:                  主机
     - parameter     path:                  路径
     - parameter     headers:               请求头
     - parameter     parameters:            参数
     - parameter     body:                  包体
     - parameter     isBodyURLParameter:    是否包体参数格式 `true:` `key1=value1&key2=value2` `false:`使用JSON格式化对象
     - parameter     timeoutInterval:       超时时间
     */
    private static func loadRequest(_ host: String,
                                    path: String,
                                    headers: [String: String],
                                    parameters: [String: Any],
                                    body: Any?,
                                    isBodyURLParameter: Bool,
                                    timeoutInterval: TimeInterval) -> URLRequest {
        
        var request = URLRequest.init(url: URL(string: host + path + "?" + urlParameter(parameters, isEncode: true))!, cachePolicy: URLRequest.CachePolicy.reloadIgnoringLocalCacheData, timeoutInterval: timeoutInterval)
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        for (key, value) in headers {
            
            request.addValue(value, forHTTPHeaderField: key)
        }
        
        if let body = body {
            
            request.httpMethod = "POST"
            
            if isBodyURLParameter, let dict = body as? Dictionary<String,Any> {
                
                /// URL参数格式
                request.httpBody = urlParameter(dict, isEncode: false).data(using: .utf8)
            }
            else {
                
                /// JSON格式
                request.httpBody = json(body)
            }
        }
        else {
            
            request.httpMethod = "GET"
        }
        
        return request
    }
    
    /**
     上传请求
     
     - parameter     host:                  主机
     - parameter     path:                  路径
     - parameter     headers:               请求头
     - parameter     parameters:            参数
     - parameter     timeoutInterval:       超时时间
     - parameter     data:                  文件数据
     - parameter     name:                  参数名
     - parameter     fileType:              文件类型
     - parameter     fileName:              文件名
     - parameter     completionHandler:     完成事件
     */
    private static func uploadRequest(_ host: String,
                                      path: String,
                                      headers: [String: String],
                                      parameters: [String: Any],
                                      timeoutInterval: TimeInterval,
                                      data: Data,
                                      name: String,
                                      fileType: String,
                                      fileName: String) -> URLRequest {
        
        var request = URLRequest.init(url: URL(string: host + path + "?" + urlParameter(parameters, isEncode: true))!, cachePolicy: URLRequest.CachePolicy.reloadIgnoringLocalCacheData, timeoutInterval: timeoutInterval)
        
        request.httpMethod = "POST"
        
        /// 前缀
        let prefix = "--"
        /// 设置分隔线
        let boundary = String(format: "boundary-%08x%08x", arc4random(), arc4random())
        
        /// 数据包
        var body = Data()
        
        /// 开始
        let start = "\r\n" + prefix + boundary + "\r\n"
        body.append(start.data(using: .utf8)!)
        
        /// 参数
        let param = "Content-Disposition: form-data; name=\"" + name + "\"; filename=\"" + fileName + "\"\r\n"
            + "Content-Type:" + fileType + "\r\n"
        body.append(param.data(using: .utf8)!)
        
        /// 添加文件数据
        body.append("\r\n".data(using: .utf8)!)
        body.append(data)
        body.append("\r\n".data(using: .utf8)!)

        /// 结束
        let end = "\r\n" + prefix + boundary + prefix + "\r\n"
        body.append(end.data(using: .utf8)!)

        
        /// 设置类型
        request.addValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        /// 设置数据长度
        request.addValue("\(body.count)", forHTTPHeaderField: "Content-Length")
        /// 设置接收类型
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        for (key, value) in headers {
            
            request.addValue(value, forHTTPHeaderField: key)
        }
        
        return request
    }
    
    // MARK: - 格式化数据
    
    /**
     URL参数字符串
     
     - parameter    dict:       参数字典
     - parameter    isEncode:   是否编码键值
     
     - returns  参数字符串
     */
    static func urlParameter(_ dict: [String: Any], isEncode: Bool) -> String {
        
        var kvs: [String] = []
        
        if isEncode {
            
            for (k,v) in dict {
                
                kvs.append( k.urlEncode() + "=" + "\(v)".urlEncode())
            }
        }
        else {
            
            for (k,v) in dict {
                
                kvs.append( "\(k)=\(v)")
            }
        }
        
        return kvs.joined(separator: "&")
    }
    
    /**
     JSON数据
     
     - parameter    any:    数据
     
     - returns  参数字符串
     */
    static func json(_ any: Any) -> Data? {
        
        do {
            
            let data = try JSONSerialization.data(withJSONObject: any, options: [])
            
            return data
            
        } catch {
            
            Print.error(error)
            
            return nil
        }
    }
    
    // MARK: - 加载
    
    /**
     加载
     
     - parameter     path:                  路径
     - parameter     headers:               请求头
     - parameter     parameters:            参数
     - parameter     body:                  包体
     - parameter     isBodyURLParameter:    是否包体参数格式 `true:` `key1=value1&key2=value2` `false:`使用JSON格式化对象
     - parameter     modelType:             模型类型
     - parameter     result:                结果回调
     - parameter     error:                 错误回调
     */
    static func load<T: Codable>(_ path: String,
                                 headers: [String: String] = [:],
                                 parameters: [String: Any] = [:],
                                 body: Any? = nil,
                                 isBodyURLParameter: Bool = false,
                                 modelType: T.Type,
                                 result: @escaping ((T)->Void),
                                 error: @escaping ((Error)->Void)) {
        
        let request = loadRequest(Configuration.HTTP.host, path: path, headers: headers, parameters: parameters, body: body, isBodyURLParameter: isBodyURLParameter, timeoutInterval: Configuration.HTTP.timeoutInterval)
        
        let errorCallback = error
        
        Print.debug("\n\n\nNetwork:")
        Print.debug("\npath:")
        Print.debug(path)
        Print.debug("\nheader:")
        Print.debug(headers)
        Print.debug("\nparameters:")
        Print.debug(parameters)
        Print.debug("\nbody:")
        Print.debug(body ?? "")
        Print.debug("\nurl:")
        Print.debug(request.url?.absoluteString ?? "")
        Print.debug("\nallHTTPHeaderFields:")
        Print.debug(request.allHTTPHeaderFields ?? [:])
        
        Network.default.data(request) { data in
            
            Print.debug("\nNetwork \(path) data:")
            Print.debug(String(data: data, encoding: .utf8) ?? "nil")
            
            do {
                
                let model = try JSONDecoder().decode(modelType, from: data)
                
                result(model)
                
            } catch {
                
                Print.debug("\nNetwork \(path) error:")
                Print.error(error)
                
                errorCallback(error)
            }
            
        } error: { error in
            
            Print.debug("\nNetwork \(path) error:")
            Print.error(error)
            
            errorCallback(error)
        }
    }
    
    // MARK: - 账号接口
    
    /**
     登陆
     
     - parameter    name:       用户名
     - parameter    password:   密码
     */
    static func login(_ name: String,
                      password: String,
                      result: @escaping ((NetworkResponse<Bool>)->Void),
                      error: @escaping ((Error)->Void)) {
        
        let body = ["name": name,
                    "password": password]
        
        load("/login", body: body, modelType: NetworkResponse<Bool>.self, result: result, error: error)
    }
}
