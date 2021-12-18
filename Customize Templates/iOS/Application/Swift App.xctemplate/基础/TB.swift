//
//  TB.swift
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
 标签栏
 */
class TB: UITabBar, XIBProtocol, BeyondProtocol {
    
    /// 超出视图列表
    var beyondViews: [UIView] = []
    
    /**
     点击视图
     */
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        
        /**
         `hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView?`
         会调用
         `point(inside point: CGPoint, with event: UIEvent?) -> Bool`
         */
        if let view = super.hitTest(point, with: event) {
            
            return view
        }
        
        return beyondHitTest(point, with: event)
    }
    
    /// `pad` 图片文字依然上下显示
    override var traitCollection: UITraitCollection {
        
        if UIDevice.current.userInterfaceIdiom == .pad, !super.traitCollection.containsTraits(in: UITraitCollection(horizontalSizeClass: .compact)) {
            
            return UITraitCollection(traitsFrom: [super.traitCollection, UITraitCollection(horizontalSizeClass: .compact)])
        }
        
        return super.traitCollection
    }
}
