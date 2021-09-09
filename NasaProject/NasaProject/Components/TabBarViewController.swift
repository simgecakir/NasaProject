//
//  TabBarViewController.swift
//  NasaProject
//
//  Created by Simge Çakır on 8.09.2021.
//

import UIKit
import NetworkAPI

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
            
        tabBar.tintColor = .white
        tabBar.barTintColor = .darkGray
        
        tabBar.layer.cornerRadius = 15
        tabBar.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        tabBar.layer.masksToBounds = true
        tabBarItem.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: -20)
        UITabBarItem.appearance().setTitleTextAttributes([.font: UIFont.boldSystemFont(ofSize: 15)], for: .normal)
        
        viewControllers = [
            setUpCuriosityViewController(),
            setUpOpportunityViewController(),
            setUpSpiritViewController()
        ]
    }
        
    private func setUpCuriosityViewController() -> UIViewController {
        let curiosityVC = CuriosityViewController()
        curiosityVC.viewModel = CuriosityViewModel(service: RoverPhotosService(roverType: .curiosity))
        curiosityVC.navigationItem.title = "Curiosity"
        let nav = UINavigationController(rootViewController: curiosityVC)
        nav.tabBarItem.title = "Curiosity"
        return nav
    }

    private func setUpOpportunityViewController() -> UIViewController {
        let opportunityVC = OpportunityViewController()
        opportunityVC.navigationItem.title = "Opportunity"
        let nav = UINavigationController(rootViewController: opportunityVC)
        nav.tabBarItem.title = "Opportunity"
        return nav
    }
    
    private func setUpSpiritViewController() -> UIViewController {
        let spiritVC = SpiritViewController()
        spiritVC.navigationItem.title = "Spirit"
        let nav = UINavigationController(rootViewController: spiritVC)
        nav.tabBarItem.title = "Spirit"
        return nav
    }
    
}
