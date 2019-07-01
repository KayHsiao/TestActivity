//
//  CafeTableViewCell.swift
//  0610
//
//  Created by Chris on 2019/6/28.
//  Copyright © 2019 user. All rights reserved.
//

import UIKit

protocol CafeTableViewCellDelegate: class {
    func didClickCollectButton(_ sender: UIButton, at indexPath: IndexPath)
}

class CafeTableViewCell: UITableViewCell {

    var cafe: Cafe? {
        didSet {
            if let cafe = cafe {
                // name
                nameLabel.text = cafe.name

                // address
                addressLabel.text = cafe.address

                // wifi
                let wifiText = (0..<cafe.wifi).reduce("") { (acc, _) -> String in
                    return acc + "★"
                }
                let emptyWifiText = (cafe.wifi..<5).reduce("") { (acc, _) -> String in
                    return acc + "☆"
                }
                wifiStarLabel.text = wifiText + emptyWifiText

                // seat
                let seatText = (0..<cafe.seat).reduce("") { (acc, _) -> String in
                    return acc + "★"
                }
                let emptySeatText = (cafe.seat..<5).reduce("") { (acc, _) -> String in
                    return acc + "☆"
                }
                wifiStarLabel.text = seatText + emptySeatText

                // quiet
                let quietText = (0..<cafe.quiet).reduce("") { (acc, _) -> String in
                    return acc + "★"
                }
                let emptyQuietText = (cafe.quiet..<5).reduce("") { (acc, _) -> String in
                    return acc + "☆"
                }
                wifiStarLabel.text = quietText + emptyQuietText

                // tasty
                let tastyText = (0..<cafe.tasty).reduce("") { (acc, _) -> String in
                    return acc + "★"
                }
                let emptyTastyText = (cafe.tasty..<5).reduce("") { (acc, _) -> String in
                    return acc + "☆"
                }
                wifiStarLabel.text = tastyText + emptyTastyText

                // cheap
                let cheapText = (0..<cafe.cheap).reduce("") { (acc, _) -> String in
                    return acc + "★"
                }
                let emptyCheapText = (cafe.cheap..<5).reduce("") { (acc, _) -> String in
                    return acc + "☆"
                }
                wifiStarLabel.text = cheapText + emptyCheapText

                // music
                let musicText = (0..<cafe.music).reduce("") { (acc, _) -> String in
                    return acc + "★"
                }
                let emptyMusicText = (cafe.music..<5).reduce("") { (acc, _) -> String in
                    return acc + "☆"
                }
                wifiStarLabel.text = musicText + emptyMusicText
            }
        }
    }

    var indexPath: IndexPath!

    weak var delegate: CafeTableViewCellDelegate?

    // IBOutlet

    @IBOutlet weak var cardView: UIView!

    @IBOutlet weak var infoView: UIView!

    @IBOutlet weak var nameLabel: UILabel!

    @IBOutlet weak var collectButton: UIButton!

    @IBOutlet weak var wifiLabel: UILabel!
    @IBOutlet weak var wifiStarLabel: UILabel!

    @IBOutlet weak var seatLabel: UILabel!
    @IBOutlet weak var seatStarLabel: UILabel!

    @IBOutlet weak var quiteLabel: UILabel!
    @IBOutlet weak var quiteStarLabel: UILabel!

    @IBOutlet weak var tastyLabel: UILabel!
    @IBOutlet weak var tastyStarLabel: UILabel!

    @IBOutlet weak var cheapLabel: UILabel!
    @IBOutlet weak var cheapStarLabel: UILabel!

    @IBOutlet weak var musicLabel: UILabel!
    @IBOutlet weak var musicStarLabel: UILabel!

    @IBOutlet weak var addressLabel: UILabel!

    // IBAction

    @IBAction func clickCollectButton(_ sender: UIButton) {
        delegate?.didClickCollectButton(sender, at: indexPath)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        cardView.cornerRadius = 10
        cardView.shadowColor = UIColor.init(hexString: "67B9D0")
        cardView.shadowOffset = CGSize(width: 0, height: 4)
        cardView.shadowRadius = 4
        cardView.shadowOpacity = 0.7
        cardView.layer.masksToBounds = false

        collectButton.setImage(UIImage(named: "youhui")?.withRenderingMode(.alwaysTemplate), for: .normal)
        collectButton.setImage(UIImage(named: "speaker")?.withRenderingMode(.alwaysTemplate), for: .selected)
        collectButton.tintColor = .white
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

}
