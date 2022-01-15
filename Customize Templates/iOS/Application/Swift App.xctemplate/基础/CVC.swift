//
//  CVC.swift
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

import CollectionViewFlowLayout

/**
 集合视图控制器
 */
class CVC: VC, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    // MARK: - StoryboardProtocol
    
    // MARK: - 属性
    
    /// 集合
    @IBOutlet var collectionView: UICollectionView?
    
    /// 数据
    var items: [Any] = []
    
    // MARK: - 生命周期
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView?.delegate = self
        collectionView?.dataSource = self
    }
    
    // MARK: - UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let item = items[indexPath.row]
        
        var identifier = "Cell"
        
        if let model = item as? CellModelProtocol, let id = model.identifier {
            
            identifier = id
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath)
        
        (cell as? CCell)?.indexPath = indexPath
        (cell as? CCell)?.source = item
        
        return cell
    }
}
