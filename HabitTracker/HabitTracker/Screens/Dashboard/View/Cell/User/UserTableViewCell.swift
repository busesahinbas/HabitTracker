//
//  UserTableViewCell.swift
//  HabitTracker
//
//  Created by Buse Şahinbaş on 25.01.2025.
//  Copyright © 2025 busesahinbas. All rights reserved.
//

import UIKit

protocol UserTableViewCellDelegate: AnyObject {
    func didTapAddButton()
}

class UserTableViewCell: UITableViewCell {
    // MARK: - Properties
    weak var delegate: UserTableViewCellDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    @IBAction func addButtonTapped(_ sender: Any) {
        delegate?.didTapAddButton()
    }
}
