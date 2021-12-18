//
//  Global.swift
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
 全局
 */
struct Global {
    
    /// 界面样式 `unspecified:`自动; `light:`白色; `dark:`黑色
    public static var interfaceStyle: UIUserInterfaceStyle = .unspecified {
        
        didSet {
            
            if #available(iOS 15, *) {
                
                for scene in UIApplication.shared.connectedScenes {
                    
                    if let windowScene = scene as? UIWindowScene {
                        
                        for item in windowScene.windows {
                            
                            item.overrideUserInterfaceStyle = interfaceStyle
                        }
                    }
                }
            }
            else if #available(iOS 13, *) {
                
                for window in UIApplication.shared.windows {
                    
                    window.overrideUserInterfaceStyle = interfaceStyle
                }
            }
        }
    }
}
