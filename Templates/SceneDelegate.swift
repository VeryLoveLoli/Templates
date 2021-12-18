//
//  SceneDelegate.swift
//  Templates
//
//  Created by 韦烽传 on 2021/12/18.
//

import UIKit

@available(iOS 13.0, *)
class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    // MARK: - 属性
    
    /**
     窗口
     */
    var window: UIWindow? {
        
        didSet {
            
            (UIApplication.shared.delegate as? AppDelegate)?.window = window
        }
    }
    
    // MARK: - 生命周期
    
    /**
     将连接
     */
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        /// 链接进入
        linkLaunch(connectionOptions)
        
        guard let _ = (scene as? UIWindowScene) else { return }
    }
    
    /**
     取消连接
     */
    func sceneDidDisconnect(_ scene: UIScene) {
        
    }
    
    /**
     活跃
     */
    func sceneDidBecomeActive(_ scene: UIScene) {
        
    }
    
    /**
     将不活跃
     */
    func sceneWillResignActive(_ scene: UIScene) {
        
    }
    
    /**
     将进入前台
     */
    func sceneWillEnterForeground(_ scene: UIScene) {
        
    }
    
    /**
     进入后台
     */
    func sceneDidEnterBackground(_ scene: UIScene) {
        
    }
    
    // MARK: - 链接进入
    
    /**
     链接进入启动场景
     */
    func linkLaunch(_ connectionOptions: UIScene.ConnectionOptions) {
        
        for item in connectionOptions.urlContexts {
            
            AppDelegate.default?.linkHandler(item.url)
        }
    }
    
    /**
     链接进入
     */
    func scene(_ scene: UIScene, continue userActivity: NSUserActivity) {
        
        let _ = AppDelegate.default?.application(UIApplication.shared, continue: userActivity, restorationHandler: { restorings in
            
        })
    }
    
    /**
     链接进入
     */
    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        
        for item in URLContexts {
            
            let _ = AppDelegate.default?.application(UIApplication.shared, open: item.url, options: [:])
        }
    }
}
