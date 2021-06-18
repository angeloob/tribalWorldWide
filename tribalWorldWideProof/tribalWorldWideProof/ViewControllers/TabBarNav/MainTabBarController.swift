//
//  MainTabBarController.swift
//  tribalWorldWideProof
//
//  Created by Angel Olvera on 17/06/21.
//

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView(){
        let FavoritesVC = FavoriteSection()
        let MainVC = MainVC()
        viewControllers = [
            generateNavigationController(rootViewController: MainVC, title: "Principal", image: UIImage(systemName: "photo.on.rectangle")!), generateNavigationController(rootViewController: FavoritesVC, title: "Favoritos", image: UIImage(systemName: "star")!)]
    }
    
    private func generateNavigationController(rootViewController: UIViewController, title: String, image: UIImage) -> UIViewController {
        let navigationVC = UINavigationController(rootViewController: rootViewController)
        navigationVC.tabBarItem.title = title
        navigationVC.tabBarItem.image = image
        return navigationVC
    }

}
