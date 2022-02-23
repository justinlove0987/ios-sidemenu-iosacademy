//
//  MenuCellViewModel.swift
//  SideMenu
//
//  Created by justin.tseng on 2022/2/23.
//

import Foundation


struct MenuCellViewModel {
    
    let menuOption: MenuController.MenuOptions
    
    var imageName: String {
        switch menuOption {
        case .home:
            return "house"
        case .settings:
            return "gear"
        case .info:
            return "airplane"
        case .appRating:
            return "star"
        case .shareApp:
            return "message"
        }
    }
    
    init(menuOption: MenuController.MenuOptions) {
        self.menuOption = menuOption
    }
    
}
