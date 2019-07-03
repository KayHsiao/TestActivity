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
                if #available(iOS 11.0, *) {
                    wifiStarLabel.textColor = cafe.wifi == 5 ? UIColor(named: "Yellow") : UIColor(named: "Gray 1")
                    wifiStarLabel.textColor = cafe.wifi == 1 ? UIColor(named: "Red") : wifiStarLabel.textColor
                } else {
                    // Fallback on earlier versions
                    wifiStarLabel.textColor = cafe.wifi == 5 ? UIColor(hexString: "F1C84B") : UIColor(hexString: "333333")
                    wifiStarLabel.textColor = cafe.wifi == 1 ? UIColor(hexString: "EB5757") : wifiStarLabel.textColor
                }


                // seat
                let seatText = (0..<cafe.seat).reduce("") { (acc, _) -> String in
                    return acc + "★"
                }
                let emptySeatText = (cafe.seat..<5).reduce("") { (acc, _) -> String in
                    return acc + "☆"
                }
                seatStarLabel.text = seatText + emptySeatText
                if #available(iOS 11.0, *) {
                    seatStarLabel.textColor = cafe.seat == 5 ? UIColor(named: "Yellow") : UIColor(named: "Gray 1")
                    seatStarLabel.textColor = cafe.seat == 1 ? UIColor(named: "Red") : seatStarLabel.textColor
                } else {
                    // Fallback on earlier versions
                    seatStarLabel.textColor = cafe.seat == 5 ? UIColor(hexString: "F1C84B") : UIColor(hexString: "333333")
                    seatStarLabel.textColor = cafe.seat == 1 ? UIColor(hexString: "EB5757") : seatStarLabel.textColor
                }


                // quiet
                let quietText = (0..<cafe.quiet).reduce("") { (acc, _) -> String in
                    return acc + "★"
                }
                let emptyQuietText = (cafe.quiet..<5).reduce("") { (acc, _) -> String in
                    return acc + "☆"
                }
                quiteStarLabel.text = quietText + emptyQuietText
                if #available(iOS 11.0, *) {
                    quiteStarLabel.textColor = cafe.quiet == 5 ? UIColor(named: "Yellow") : UIColor(named: "Gray 1")
                    quiteStarLabel.textColor = cafe.quiet == 1 ? UIColor(named: "Red") : quiteStarLabel.textColor
                } else {
                    // Fallback on earlier versions
                    quiteStarLabel.textColor = cafe.quiet == 5 ? UIColor(hexString: "F1C84B") : UIColor(hexString: "333333")
                    quiteStarLabel.textColor = cafe.quiet == 1 ? UIColor(hexString: "EB5757") : quiteStarLabel.textColor
                }

                // tasty
                let tastyText = (0..<cafe.tasty).reduce("") { (acc, _) -> String in
                    return acc + "★"
                }
                let emptyTastyText = (cafe.tasty..<5).reduce("") { (acc, _) -> String in
                    return acc + "☆"
                }
                tastyStarLabel.text = tastyText + emptyTastyText
                if #available(iOS 11.0, *) {
                    tastyStarLabel.textColor = cafe.tasty == 5 ? UIColor(named: "Yellow") : UIColor(named: "Gray 1")
                    tastyStarLabel.textColor = cafe.tasty == 1 ? UIColor(named: "Red") : tastyStarLabel.textColor
                } else {
                    // Fallback on earlier versions
                    tastyStarLabel.textColor = cafe.tasty == 5 ? UIColor(hexString: "F1C84B") : UIColor(hexString: "333333")
                    tastyStarLabel.textColor = cafe.tasty == 1 ? UIColor(hexString: "EB5757") : tastyStarLabel.textColor
                }

                // cheap
                let cheapText = (0..<cafe.cheap).reduce("") { (acc, _) -> String in
                    return acc + "★"
                }
                let emptyCheapText = (cafe.cheap..<5).reduce("") { (acc, _) -> String in
                    return acc + "☆"
                }
                cheapStarLabel.text = cheapText + emptyCheapText
                if #available(iOS 11.0, *) {
                    cheapStarLabel.textColor = cafe.cheap == 5 ? UIColor(named: "Yellow") : UIColor(named: "Gray 1")
                    cheapStarLabel.textColor = cafe.cheap == 1 ? UIColor(named: "Red") : cheapStarLabel.textColor
                } else {
                    // Fallback on earlier versions
                    cheapStarLabel.textColor = cafe.cheap == 5 ? UIColor(hexString: "F1C84B") : UIColor(hexString: "333333")
                    cheapStarLabel.textColor = cafe.cheap == 1 ? UIColor(hexString: "EB5757") : cheapStarLabel.textColor
                }

                // music
                let musicText = (0..<cafe.music).reduce("") { (acc, _) -> String in
                    return acc + "★"
                }
                let emptyMusicText = (cafe.music..<5).reduce("") { (acc, _) -> String in
                    return acc + "☆"
                }
                musicStarLabel.text = musicText + emptyMusicText
                if #available(iOS 11.0, *) {
                    musicStarLabel.textColor = cafe.music == 5 ? UIColor(named: "Yellow") : UIColor(named: "Gray 1")
                    musicStarLabel.textColor = cafe.music == 1 ? UIColor(named: "Red") : musicStarLabel.textColor
                } else {
                    // Fallback on earlier versions
                    musicStarLabel.textColor = cafe.music == 5 ? UIColor(hexString: "F1C84B") : UIColor(hexString: "333333")
                    musicStarLabel.textColor = cafe.music == 1 ? UIColor(hexString: "EB5757") : musicStarLabel.textColor
                }



                let isCollected = UserDefaults.standard.bool(forKey: cafe.id)
                collectButton.isSelected = isCollected ? true : false
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
        if #available(iOS 11.0, *) {
            cardView.backgroundColor = UIColor(named: "Green 2")
            cardView.shadowColor = UIColor(named: "Green 1")

            wifiLabel.textColor = UIColor(named: "Gray 1")
            seatLabel.textColor = UIColor(named: "Gray 1")
            tastyLabel.textColor = UIColor(named: "Gray 1")
            cheapLabel.textColor = UIColor(named: "Gray 1")
            quiteLabel.textColor = UIColor(named: "Gray 1")
            musicLabel.textColor = UIColor(named: "Gray 1")
        } else {
            // Fallback on earlier versions
            cardView.backgroundColor = UIColor(hexString: "00B156")
            cardView.shadowColor = UIColor(hexString: "00984B")

            wifiLabel.textColor = UIColor(hexString: "333333")
            seatLabel.textColor = UIColor(hexString: "333333")
            tastyLabel.textColor = UIColor(hexString: "333333")
            cheapLabel.textColor = UIColor(hexString: "333333")
            quiteLabel.textColor = UIColor(hexString: "333333")
            musicLabel.textColor = UIColor(hexString: "333333")
        }
        cardView.cornerRadius = 10
        cardView.shadowOffset = CGSize(width: 0, height: 4)
        cardView.shadowRadius = 4
        cardView.shadowOpacity = 0.7
        cardView.layer.masksToBounds = false

        collectButton.setImage(UIImage(named: "youhui")?.withRenderingMode(.alwaysTemplate), for: .normal)
        collectButton.setImage(UIImage(named: "xinxi")?.withRenderingMode(.alwaysTemplate), for: .selected)
        collectButton.tintColor = .white


    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

}
