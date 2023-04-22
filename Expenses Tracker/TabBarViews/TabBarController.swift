//
//  TabBarController.swift
//  Expenses Tracker
//
//  Created by Adrian Vîslă on 16.04.2023.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        UITabBar.appearance().barTintColor = .systemBackground
        tabBar.tintColor = .label
        setupViewControllers()
    }
    
    func setupViewControllers() {
        viewControllers = [
            createNavController(for: MainMenuController(), title: "Menu", image: UIImage(systemName: "house")!),
            createNavController(for: TransactionHistoryController(), title: "Transactions", image: UIImage(systemName: "list.triangle")!),
            createNavController(for: InvoiceAddController(), title: "Add New", image: UIImage(systemName: "plus")!),
            createNavController(for: TemplateController(), title: "Templates", image: UIImage(systemName: "doc.on.doc")!),
            createNavController(for: UserController(), title: "User", image: UIImage(systemName: "person")!)
        ]
    }
    
    func createNavController(for rootViewController : UIViewController, title: String, image: UIImage) -> UIViewController {
        let navController = UINavigationController(rootViewController: rootViewController)
        navController.tabBarItem.title = title
        navController.tabBarItem.image = image
        navController.navigationBar.prefersLargeTitles = true

        return navController
    }
}
