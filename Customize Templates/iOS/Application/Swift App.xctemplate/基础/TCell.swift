//
//  TCell.swift
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
 列表元件
 
 使用范型 `TCell<M>` 无法在 `Storyboard` 上直接关联 需继承指定`M`类型后关联
 */
class TCell<M>: UITableViewCell, XIBProtocol {
    
    // MARK: - 属性
    
    /// 数据源
    var source: M? {
        
        didSet {
            
            update()
        }
    }
    
    /// 索引路径
    var indexPath: IndexPath?
    
    // MARK: - 生命周期
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    // MARK: - 事件
    
    /**
     更新
     */
    func update() {
        
    }
}
