//
//  RocketListCell.swift
//  spaceX
//
//  Created by Milan on 08/10/22.
//

import UIKit
import Kingfisher

class RocketListCell: UITableViewCell {

    @IBOutlet weak var btnStar: UIButton!
    @IBOutlet weak var imgRocket: UIImageView!
    @IBOutlet weak var lblrocket_id: UILabel!
    @IBOutlet weak var lblrocket_name: UILabel!
    @IBOutlet weak var lblrocket_type: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
    }
    
    func configCell(model: TestModelElement) {
        let url = URL(string: model.links?.missionPatchSmall ?? "")
        imgRocket.kf.setImage(with: url, placeholder: UIImage(named: "ic_rocket"))
        lblrocket_id.text =  "rocket ID = \(model.rocket?.rocketID ?? "")"
        lblrocket_name.text = "rocket Name = \(model.rocket?.rocketName ?? "")"
        lblrocket_type.text = "rocket Type = \(model.rocket?.rocketType ?? "")"
    }
}


//self.avatarButton.kf.setImage(with: URL(string: Config.URLs.gravatarImageURL.replace("{md5}", with: Utils.shared.md5Hash(AccountManager.shared.getUserEmail() ?? ""))), for: .normal, placeholder: UIImage(named: "generic_avatar"))
