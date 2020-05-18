//
//  SceneDelegate.swift
//  MSDMasterDetail
//
//  Created by Michael San Diego on 5/7/20.
//  Copyright © 2020 Michael San Diego. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate, UISplitViewControllerDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        
        if let userActivity = connectionOptions.userActivities.first ?? session.stateRestorationActivity {
            // Setup the detail view controller with it's restoration activity.
            if !configure(window: window, with: userActivity) {
                print("Failed to restore DetailViewController from \(userActivity)")
            }
        }
    }
    
    func configure(window: UIWindow?, with activity: NSUserActivity) -> Bool {
        if let detailViewController = DetailViewController.loadFromStoryboard() {
            if let navigationController = window?.rootViewController as? UINavigationController {
                navigationController.pushViewController(detailViewController, animated: false)
                detailViewController.restoreUserActivityState(activity)
                return true
            }
        }
        return false
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not neccessarily discarded (see `application:didDiscardSceneSessions` instead).
        DateStamp().saveDateStamp()
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        DateStamp().saveDateStamp()
        
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
        if let navController = window!.rootViewController as? UINavigationController {
            if let detailViewController = navController.viewControllers.last as? DetailViewController {
                // Fetch the user activity from our detail view controller so restore for later.
                scene.userActivity = detailViewController.detailUserActivity
            }
        }
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        DateStamp().saveDateStamp()
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }
}

// MARK: State Restoration

extension SceneDelegate {
    
//     This is the NSUserActivity that will be used to restore state when the scene reconnects.
    func stateRestorationActivity(for scene: UIScene) -> NSUserActivity? {
        return scene.userActivity
    }
    
}

