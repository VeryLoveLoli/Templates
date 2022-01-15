//
//  TVC.swift
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
 列表视图控制器
 */
class TVC: VC, UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - StoryboardProtocol
    
    // MARK: - 属性
    
    /// 列表视图
    @IBOutlet var tableView: UITableView?
    /// 列表项
    var items: [Any] = []
    
    // MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let item = items[indexPath.row]
        
        var identifier = "Cell"
        
        if let model = item as? CellModelProtocol, let id = model.identifier {
            
            identifier = id
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        
        (cell as? TCell)?.indexPath = indexPath
        (cell as? TCell)?.source = item
        
        return cell
    }
}
