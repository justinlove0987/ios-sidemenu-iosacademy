//
//  ViewController.swift
//  SideMenu
//
//  Created by justin.tseng on 2022/2/21.
//

import UIKit

class ContainerController: UIViewController {
    
    enum MenuState {
        case opened
        case closed
    }
    
    private var menuState: MenuState = .closed
    
    let menuVC = MenuController()
    let homeVC = HomeController()
    var navVC: UINavigationController?
    lazy var infoVC = InfoController()
    
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        addChildVCs()
    }
    
    // MARK: - Helpers
    
    private func addChildVCs() {
        // Menu
        menuVC.delegate = self
        addChild(menuVC)
        view.addSubview(menuVC.view)
        
        // Home
        homeVC.delegate = self
        let navVC = UINavigationController(rootViewController: homeVC)
        addChild(navVC)
        view.addSubview(navVC.view)
        navVC.didMove(toParent: self)
        self.navVC = navVC
        
    }
    
    
}

// MARK: - HomeViewControllerDelegate

extension ContainerController: HomeViewControllerDelegate {
    
    func didTapMenuButton() {
        toggleMenu(completion: nil)
    }
    
    func toggleMenu(completion: (() -> Void)?) {
        // Animate the menu
        switch menuState {
        case .closed:
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut) {
                self.navVC?.view.frame.origin.x = self.homeVC.view.frame.size.width - 100
            } completion: { done in
                if done {
                    self.menuState = .opened
                }
            }
            
        case .opened:
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut) {
                self.navVC?.view.frame.origin.x = 0
            } completion: { done in
                if done {
                    self.menuState = .closed
                    DispatchQueue.main.async {
                        completion?()
                    }
                }
            }
        }
    }
}

// MARK: - MenuViewControllerDelegate

extension ContainerController: MenuViewControllerDelegate {
    func didSelect(menuItem: MenuController.MenuOptions) {
        
        toggleMenu { [weak self] in
            
            switch menuItem {
                
            case .home:
                self?.resetToHome()
            case .settings:
                break
            case .info:
                // Add info child
                self?.addInfo()
                //                self?.present(UINavigationController(rootViewController: vc), animated: true, completion: nil)
            case .appRating:
                break
            case .shareApp:
                break
            }
        }
        
    }
    
    func addInfo() {
        let vc = infoVC
        homeVC.addChild(vc)
        homeVC.view.addSubview(vc.view)
        vc.didMove(toParent: homeVC)
        vc.view.frame = view.frame
        homeVC.title = vc.title
    }
    
    func resetToHome() {
        infoVC.view.removeFromSuperview()
        infoVC.didMove(toParent: nil)
        homeVC.title = "Home"
    }
}
