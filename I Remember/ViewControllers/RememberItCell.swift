//
//  RememberItCell.swift
//  I Remember
//
//  Created by Stewart Lynch on 2020-09-13.
//  Copyright © 2020 CreaTECH Solutions. All rights reserved.
//

import UIKit

class RememberItCell: UICollectionViewCell {

    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var detail1: UILabel!
    @IBOutlet weak var detail2: UILabel!
    @IBOutlet weak var bgView: UIView!
    
    var item:RememberItem? {
        didSet {
            bgView.layer.shadowColor = UIColor.black.cgColor
            bgView.layer.cornerRadius = 14
            bgView.layer.borderColor = UIColor.lightGray.cgColor
            bgView.layer.borderWidth = 0.5
            bgView.layer.shadowOpacity = 0.2
            bgView.layer.shadowOffset = CGSize.zero
            bgView.layer.shadowRadius = 5
            let shadowPath = CGRect(x: bgView.bounds.minX + 5, y: bgView.bounds.minY + 5, width: bgView.bounds.width - 10, height: bgView.bounds.height)
            bgView.layer.shadowPath = UIBezierPath(rect: shadowPath).cgPath
            bgView.backgroundColor = item!.isPrimary ? UIColor.lightGray : UIColor(named: "background")
            title.text = item?.title
            icon.image = UIImage(named: item?.icon ?? "key")
            detail1.text = item?.detail1
            detail2.text = item?.detail2
        }
    }
}
