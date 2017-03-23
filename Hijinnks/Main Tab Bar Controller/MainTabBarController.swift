//
//  MainTabBarController.swift
//  Hijinnks
//
//  Created by adeiji on 3/3/17.
//  Copyright © 2017 adeiji. All rights reserved.
//

import Foundation
import UIKit
import Parse

class MainTabBarController : UITabBarController {
    
    override func viewDidLoad() {
        let viewInvitationsViewController = ViewInvitationsViewController()
        viewInvitationsViewController.navigationItem.title = StringConstants.Hijinnks.rawValue
        let createInvitationViewController = getCreateInvitationViewController(viewInvitationsViewController: viewInvitationsViewController)
        let profileViewController = getProfileViewController()
        
        var viewControllers:[UIViewController] = [UIViewController]()
        viewControllers.append(getViewInvitationsViewController(viewInvitationsViewController: viewInvitationsViewController))
        viewControllers.append(profileViewController)
        viewControllers.append(getConnectViewController())
        viewControllers.append(createInvitationViewController)
        // Add this last so that it's the firs thing the user sees when they open the application
        
        
        self.viewControllers = viewControllers
        self.tabBar.tintColor = .black
        self.selectedViewController = self.viewControllers?.first
    }
    
    func getConnectViewController () -> UINavigationController {
        let connectViewController = ViewUsersViewController(setting: Settings.ViewUsersAll)
        connectViewController.showAllUsers()
        connectViewController.navigationItem.title = StringConstants.Hijinnks.rawValue
        let connectViewControllerTabBarItem = UITabBarItem()
        connectViewControllerTabBarItem.image = UIImage(named: Images.ConnectButton.rawValue)?.withRenderingMode(.alwaysOriginal)
        connectViewControllerTabBarItem.title = StringConstants.Friends.rawValue
        connectViewController.tabBarItem = connectViewControllerTabBarItem
        let connectNavigationController = UINavigationController(rootViewController: connectViewController)
        return connectNavigationController
    }
    
    func getViewInvitationsViewController (viewInvitationsViewController : ViewInvitationsViewController) -> UINavigationController {
        let viewInvitationsNavigationController = UINavigationController(rootViewController: viewInvitationsViewController)
        // Set up the UI
        let tabBarItem = UITabBarItem()
        tabBarItem.image = UIImage(named: Images.HouseButton.rawValue)?.withRenderingMode(.alwaysOriginal)
        tabBarItem.title = StringConstants.ViewInvitations.rawValue
        self.tabBarItem = tabBarItem
        viewInvitationsViewController.tabBarItem = tabBarItem
        
        return viewInvitationsNavigationController
    }
    
    func getProfileViewController () -> UINavigationController {
        let profileViewController = ProfileViewController(user: PFUser.current()!)
        profileViewController.navigationItem.title = StringConstants.Hijinnks.rawValue
        let profileViewControllerTabBarItem = UITabBarItem()
        profileViewControllerTabBarItem.image = UIImage(named: Images.ProfileImageButton.rawValue)?.withRenderingMode(.alwaysOriginal)
        profileViewControllerTabBarItem.title = StringConstants.Profile.rawValue
        profileViewController.tabBarItem = profileViewControllerTabBarItem        
        
        let profileNavigationController = UINavigationController(rootViewController: profileViewController)
        return profileNavigationController
    }

    func getCreateInvitationViewController (viewInvitationsViewController : ViewInvitationsViewController) -> UINavigationController {
        let createInvitationViewController = CreateInvitationViewController()
        createInvitationViewController.navigationItem.title = StringConstants.CreateInvitation.rawValue
        let createInvitationViewControllerTabBarItem = UITabBarItem()
        createInvitationViewControllerTabBarItem.image = UIImage(named: Images.CreateInvitationButton.rawValue)?.withRenderingMode(.alwaysOriginal)
        createInvitationViewControllerTabBarItem.title = StringConstants.CreateInvitation.rawValue
        createInvitationViewController.tabBarItem = createInvitationViewControllerTabBarItem
        // Set the delegate to the create invitation view controller to the view invitations view controller so that when new invitations are added they will automatically be added on the view invitations view controller
        createInvitationViewController.delegate = viewInvitationsViewController
        let createInvitationNavigationController = UINavigationController(rootViewController: createInvitationViewController)
        return createInvitationNavigationController
    }
    
}
