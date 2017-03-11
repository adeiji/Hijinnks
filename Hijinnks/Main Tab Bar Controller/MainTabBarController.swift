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
        viewControllers.append(createInvitationViewController)
        viewControllers.append(getViewInvitationsViewController(viewInvitationsViewController: viewInvitationsViewController))
        viewControllers.append(profileViewController)
        self.viewControllers = viewControllers
        self.tabBar.tintColor = .gray
        self.selectedViewController = self.viewControllers?.last
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
        let profileViewController = ProfileViewController()
        profileViewController.navigationItem.title = StringConstants.Hijinnks.rawValue
        let profileViewControllerTabBarItem = UITabBarItem()
        profileViewControllerTabBarItem.image = UIImage(named: Images.ProfileImageButton.rawValue)?.withRenderingMode(.alwaysOriginal)
        profileViewControllerTabBarItem.title = StringConstants.CreateInvitation.rawValue
        profileViewController.tabBarItem = profileViewControllerTabBarItem        
        profileViewController.user = PFUser.current()
        
        let profileNavigationController = UINavigationController(rootViewController: profileViewController)
        return profileNavigationController
    }

    func getCreateInvitationViewController (viewInvitationsViewController : ViewInvitationsViewController) -> UINavigationController {
        let createInvitationViewController = CreateInvitationViewController()
        createInvitationViewController.navigationItem.title = StringConstants.Hijinnks.rawValue
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
