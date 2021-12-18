//
//  AppDelegate.swift
//  Templates
//
//  Created by 韦烽传 on 2021/12/18.
//

import UIKit

import Print

@main
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {

    // MARK: - 属性
    
    /// 默认
    static var `default`: AppDelegate? { UIApplication.shared.delegate as? AppDelegate }
    
    /// 窗口
    var window: UIWindow?
    
    /// 后台任务
    var backgroundTask: UIBackgroundTaskIdentifier?
    
    // MARK: - 应用 生命周期
    
    /**
     启动
     */
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        /// 启动配置
        Configuration.launch()
        
        /// 注册远程推送（需配置证书和`Capabilities`添加 `Push Notifications`）
//        registerForRemoteNotifications(application)
        
        /// 链接进入
        linkLaunch(launchOptions)
        
        return true
    }
    
    /**
     活跃
     */
    func applicationDidBecomeActive(_ application: UIApplication) {
        
        /// 结束后台任务
        if let task = self.backgroundTask {
            
            UIApplication.shared.endBackgroundTask(task)
        }
    }
    
    /**
     将不活跃
     */
    func applicationWillResignActive(_ application: UIApplication) {
        
        /// 开启后台任务
        UIApplication.shared.beginBackgroundTask {
            
            if let task = self.backgroundTask {
                
                UIApplication.shared.endBackgroundTask(task)
            }
            
            self.backgroundTask = .invalid
        }
    }
    
    /**
     将进入前台
     */
    func applicationWillEnterForeground(_ application: UIApplication) {
        
    }
    
    /**
     进入后台
     */
    func applicationDidEnterBackground(_ application: UIApplication) {
        
    }

    // MARK: - 场景会话 生命周期
    
    /**
     场景会话配置
     */
    @available(iOS 13.0, *)
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    /**
     场景会话废弃
     */
    @available(iOS 13.0, *)
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        
    }

    // MARK: - 远程推送注册
    
    /**
     注册远程推送通知
     */
    func registerForRemoteNotifications(_ application: UIApplication) {
        
        UNUserNotificationCenter.current().delegate = self
        
        /// 获取权限
        UNUserNotificationCenter.current().getNotificationSettings { setting in
            
            Print.debug(setting)
            
            switch setting.authorizationStatus {
            
            case .authorized:
                
                DispatchQueue.main.async {
                    
                    /// 注册远程通知
                    application.registerForRemoteNotifications()
                }
                
            case .notDetermined:
                
                UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { bool, error in
                    
                    if bool {
                        
                        Print.debug("获取推送权限成功")
                        
                        DispatchQueue.main.async {
                            
                            /// 注册远程通知
                            application.registerForRemoteNotifications()
                        }
                    }
                    else {
                        
                        Print.debug("获取推送权限失败")
                    }
                    
                    if let error = error {
                        
                        Print.error("推送权限错误：")
                        Print.error(error.localizedDescription)
                    }
                }
            default:
                break
            }
        }
        
        /// 清除通知数量标记
        application.applicationIconBadgeNumber = 0
    }
    
    /**
     远程推送注册成功
     */
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        
    }
    
    /**
     远程推送注册失败
     */
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        
    }
    
    // MARK: - UNUserNotificationCenterDelegate
    
    /**
     点击通知设置选项获得通知
     */
    func userNotificationCenter(_ center: UNUserNotificationCenter, openSettingsFor notification: UNNotification?) {
        
        UIApplication.shared.applicationIconBadgeNumber = 0
        
        let _ = notification?.request.content.userInfo
    }
    
    /**
     点击获得通知
     */
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        
        UIApplication.shared.applicationIconBadgeNumber = 0
        
        let _ = response.notification.request.content.userInfo
        
        completionHandler()
    }
    
    /**
     在前台获得通知
     */
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        /// 显示通知
        completionHandler([.alert, .badge, .sound])
    }
    
    // MARK: - 链接进入
    
    /**
     链接进入启动App
     */
    func linkLaunch(_ launchOptions: [UIApplication.LaunchOptionsKey: Any]?) {
        
        if let url = launchOptions?[.url] as? URL {
            
            linkHandler(url)
        }
    }
    
    /**
     链接进入
     */
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        
        linkHandler(url)
        
        return true
    }
    
    /**
     链接进入
     */
    func application(_ application: UIApplication, continue userActivity: NSUserActivity, restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void) -> Bool {
        
        if let url = userActivity.webpageURL {
            
            linkHandler(url)
        }
        
        if let url = userActivity.referrerURL, userActivity.referrerURL != userActivity.webpageURL {
            
            linkHandler(url)
        }
        
        return true
    }
    
    /**
     链接处理
     */
    func linkHandler(_ url: URL) {
        
    }
}
