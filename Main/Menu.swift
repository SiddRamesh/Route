//
//  Menu.swift
//  Route
//
//  Created by Ramesh Siddanavar on 25/03/18.
//  Copyright © 2018 Ramesh Siddanavar. All rights reserved.
//

import UIKit
import Material
import Graph

class Menu: UIViewController {
    var samp = SampleData()
    var window: UIWindow?
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
          self.samp.loadData()
     //   SampleData.createSampleData()
        let graph = Graph()
        let search = Search<Entity>(graph: graph).for(types: "Category")
        
        var viewControllers = [PostsViewController]()
        
        for category in search.sync() {
            if let name = category["name"] as? String {
                viewControllers.append(PostsViewController(category: name))
            }
        }
        
        let tabsController = AppTabsController(viewControllers: viewControllers)
        let toolbarController = AppToolbarController(rootViewController: tabsController)
        let menuController = AppFABMenuController(rootViewController: toolbarController)
        
        window = UIWindow(frame: Screen.bounds)
        window!.rootViewController = menuController
        window!.makeKeyAndVisible()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
