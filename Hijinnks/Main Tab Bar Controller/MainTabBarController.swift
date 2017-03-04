//
//  MainTabBarController.swift
//  Hijinnks
//
//  Created by adeiji on 3/3/17.
//  Copyright © 2017 adeiji. All rights reserved.
//

import Foundation
import UIKit

class MainTabBarController : UITabBarController {
    
    override func viewDidLoad() {
        let viewInvitationsViewController = ViewInvitationsViewController()
        let createInvitationViewController = CreateInvitationViewController()
        
        // Set the delegate to the create invitation view controller to the view invitations view controller so that when new invitations are added they will automatically be added on the view invitations view controller
        createInvitationViewController.delegate = viewInvitationsViewController
        let viewInvitationsNavigationController = UINavigationController(rootViewController: viewInvitationsViewController)
        let createInvitationNavigationController = UINavigationController(rootViewController: createInvitationViewController)
        var viewControllers:[UIViewController] = [UIViewController]()        
        viewControllers.append(createInvitationNavigationController)
        viewControllers.append(viewInvitationsNavigationController)
        self.viewControllers = viewControllers
        self.selectedViewController = self.viewControllers?.last
    }
    
}
