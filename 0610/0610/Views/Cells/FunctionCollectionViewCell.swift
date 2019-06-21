//
//  FunctionCollectionViewCell.swift
//  0610
//
//  Created by Chris on 2019/6/17.
//  Copyright © 2019 user. All rights reserved.
//

import UIKit
import Kingfisher

class FunctionCollectionViewCell: UICollectionViewCell {

    var imageStr: String? {
        didSet {
            if let imageStr = imageStr, let url = URL(string: imageStr) {
                let processor = DownsamplingImageProcessor(size: iconImageView.frame.size)

                iconImageView.kf.indicatorType = .activity
                iconImageView.kf.setImage(
                    with: url,
                    placeholder: nil,
                    options: [
                        .processor(processor),
                        .scaleFactor(UIScreen.main.scale),
                        .transition(.fade(1)),
                        .cacheOriginalImage
                    ])
                {
                    result in
                    switch result {
                    case .success(let value):
                        log.info("Task done for: \(value.source.url?.absoluteString ?? "")")
                    case .failure(let error):
                        log.error("Job failed: \(error.localizedDescription)")
                    }
                }
            } else {
                iconImageView.image = nil
            }
        }
    }

    var titleStr: String? {
        didSet {
            if let titleStr = titleStr {
                titleLabel.text = titleStr
            }
        }
    }

    @IBOutlet weak var iconImageView: UIImageView!

    @IBOutlet weak var titleLabel: UILabel!

    @IBOutlet weak var contentBackgoundView: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
