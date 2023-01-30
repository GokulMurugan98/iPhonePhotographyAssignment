//
//  LessonsTableViewCell.swift
//  IPhonePhotography
//
//  Created by Gokul Murugan on 2023-01-30.
//
// MARK: Custom table view cell
import UIKit

class LessonsTableViewCell: UITableViewCell {

    @IBOutlet weak var lessonName: UILabel!
    @IBOutlet weak var thumbNail: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        thumbNail.layer.cornerRadius = 15.0
        thumbNail.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
