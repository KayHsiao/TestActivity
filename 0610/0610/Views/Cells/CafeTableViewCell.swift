//
//  CafeTableViewCell.swift
//  0610
//
//  Created by Chris on 2019/6/28.
//  Copyright © 2019 user. All rights reserved.
//

import UIKit

class CafeTableViewCell: UITableViewCell {

    @IBOutlet weak var cardView: UIView!



    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        cardView.cornerRadius = 5
        cardView.shadowColor = .blue
        cardView.shadowOffset = CGSize(width: 0, height: 4)
        cardView.shadowRadius = 2
        cardView.shadowOpacity = 0.5
        cardView.layer.masksToBounds = false

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
