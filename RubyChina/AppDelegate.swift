//
//  AppDelegate.swift
//  RubyChina
//
//  Created by Jianqiu Xiao on 5/19/15.
//  Copyright (c) 2015 Jianqiu Xiao. All rights reserved.
//

import AFNetworking
import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        if #available(iOS 9.1, *) {
            application.shortcutItems = [
                UIApplicationShortcutItem(type: "topics", localizedTitle: "社区", localizedSubtitle: nil, icon: UIApplicationShortcutIcon(type: .home), userInfo: nil),
                UIApplicationShortcutItem(type: "compose", localizedTitle: "发帖", localizedSubtitle: nil, icon: UIApplicationShortcutIcon(type: .compose), userInfo: nil),
            ]
        }

        AFNetworkActivityIndicatorManager.shared().isEnabled = true

        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = MainViewController()
        window?.tintColor = Helper.tintColor
        window?.makeKeyAndVisible()
        
        //注册URL Loading System协议，让每一个请求都会经过MyURLProtocol处理
        URLProtocol.registerClass(MyURLProtocol.self)

        return true
    }

    @available(iOS 9.0, *)
    func application(_ application: UIApplication, performActionFor shortcutItem: UIApplicationShortcutItem, completionHandler: @escaping (Bool) -> Void) {
        guard let splitViewController = window?.rootViewController as? SplitViewController else { return }
        switch shortcutItem.type {
        case "topics":
            guard let navigationController = splitViewController.viewControllers.first as? UINavigationController else { return }
            navigationController.popToRootViewController(animated: true)
        case "compose":
            splitViewController.showDetailViewController(UINavigationController(rootViewController: ComposeController()), sender: nil)
        default: Void()
        }
    }
    
    // MARK: - Core Data stack
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "RubyChina")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                
                
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                
                
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
