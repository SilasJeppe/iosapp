//
//  TabBarController.swift
//  Runner
//
//  Created by Rasmus Juhl on 19/04/16.
//  Copyright © 2016 rjuhl.dk. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.selectedViewController = self.viewControllers![1] 
    }
}