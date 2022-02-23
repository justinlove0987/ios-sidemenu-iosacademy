//
//  MenuViewController.swift
//  SideMenu
//
//  Created by justin.tseng on 2022/2/21.
//

import UIKit

protocol MenuViewControllerDelegate: AnyObject {
    func didSelect(menuItem: MenuController.MenuOptions)
}

private let resueIdentifier = "MenuCellIdentifier"

class MenuController: UIViewController {
    
    // MARK: - Properties
    
    weak var delegate: MenuViewControllerDelegate?
    
    let grayColor = UIColor(red: 33/255.0, green: 33/255.0, blue: 33/255.0, alpha: 1)
    
    enum MenuOptions: String, CaseIterable {
        case home = "Home"
        case settings = "Settings"
        case info = "Information"
        case appRating = "App Rating"
        case shareApp = "Share App"
    }
    
    private let tableView: UITableView = {
        let table = UITableView()
        table.register(MenuCell.self, forCellReuseIdentifier: resueIdentifier)
        table.backgroundColor = nil
        return table
    }()
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    // MARK: - Helpers
    
    func configure() {
        view.backgroundColor = grayColor
        
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.frame = view.bounds
    }
}


// MARK: - UITableViewDelegate

extension MenuController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let item = MenuOptions.allCases[indexPath.row]
        delegate?.didSelect(menuItem: item)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MenuOptions.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: resueIdentifier, for: indexPath) as! MenuCell
        
        cell.viewModel = MenuCellViewModel(menuOption: MenuOptions.allCases[indexPath.row])
        
        return cell
    }
}
