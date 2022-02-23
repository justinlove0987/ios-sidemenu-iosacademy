//
//  MenuCell.swift
//  SideMenu
//
//  Created by justin.tseng on 2022/2/23.
//

import UIKit

class MenuCell: UITableViewCell {
    
    // MARK: - Properties
    
    var viewModel: MenuCellViewModel? {
        didSet { configure() }
    }
    
    // MARK: - Lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers
    
    func configure() {
        guard let viewModel = viewModel else { return }
        imageView?.image = UIImage(systemName: viewModel.imageName)
        textLabel?.text = viewModel.menuOption.rawValue
        textLabel?.textColor = .white
        
        imageView?.tintColor = .white
        backgroundColor = Color.gray
        contentView.backgroundColor = Color.gray
        
    }
    
}
