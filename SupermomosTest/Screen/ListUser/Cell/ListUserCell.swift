//
//  ListUserCell.swift
//  SupermomosTest
//
//  Created by Mac on 08/08/2021.
//

import UIKit

class ListUserCell: UITableViewCell {
    
    static let rowHeight: CGFloat = 52

    @IBOutlet weak var imgAvatar: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblUrl: UILabel!
        
    override func awakeFromNib() {
        super.awakeFromNib()
        
        selectionStyle = .none
    }

    func setupView(_ user: UserModel) {
        lblName.text = user.login
        lblUrl.text = user.htmlUrl
        
        if let avatarData = user.avatarData {
            imgAvatar.image = UIImage(data: avatarData)
        } else {
            imgAvatar.setImage(from: user.avatarUrl) { image,_,_,_  in
                let user = user
                user.avatarData = image?.pngData()
                RealmManager.shared.addUsersObject(object: [UserObject(userModel: user)])
            }
        }
    }
}
