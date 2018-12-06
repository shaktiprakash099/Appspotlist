//
//  ItemListsTableViewCell.swift
//  AppSpotLists
//
//  Created by GLB-253 on 12/5/18.
//  Copyright © 2018 IOSISFUN. All rights reserved.
//

import UIKit
import SDWebImage
class ItemListsTableViewCell: UITableViewCell {

    @IBOutlet weak var userImageView: CustomImageView!
    
    @IBOutlet weak var userEmailIdLable: UILabel!
    @IBOutlet weak var userNamelable: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func setupParameters(itemlist:ItemsDetailsLists){
        self.userNamelable.text = "\(itemlist.firstName )  \(itemlist.lastName)"
        self.userEmailIdLable.text = "\(itemlist.emailId)"
        if let imageUrl = URL(string: itemlist.imageUrl)  {
            self.userImageView.sd_setImage(with: imageUrl,placeholderImage: #imageLiteral(resourceName: "defaultavatar"))
            return
        }
        self.userImageView.image = #imageLiteral(resourceName: "defaultavatar")
    }

}
