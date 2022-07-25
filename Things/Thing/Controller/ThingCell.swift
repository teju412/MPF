//
//  ThingCell.swift
//  Things
//
//  Created by Teja on 22/07/22.
//

import UIKit

class ThingCell: UITableViewCell {

    @IBOutlet weak var thingLbl: UILabel!
    @IBOutlet weak var tickImage: UIImageView!
    @IBOutlet weak var bgView: UIView!
    var isDisplayImage: Bool = false
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override func prepareForReuse() {
        self.tickImage.image = nil
        self.thingLbl.text = ""
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if isDisplayImage {
        tickImage.isHidden = !selected
        }
    }
    
}
