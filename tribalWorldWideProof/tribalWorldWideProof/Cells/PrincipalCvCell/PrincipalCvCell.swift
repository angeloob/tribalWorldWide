//
//  PrincipalCvCell.swift
//  tribalWorldWideProof
//
//  Created by Angel Olvera on 17/06/21.
//

import UIKit
import SDWebImage

class PrincipalCvCell: UICollectionViewCell {

    static let identifier = "PrincipalCvCell"
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var imageProfile: UIImageView!
    @IBOutlet weak var usernameL: UILabel!
    @IBOutlet weak var likesL: UILabel!
    
    var unslplashPhoto: UnsplashPhoto!{
        didSet{
            let photoUrl = unslplashPhoto.urls["full"]
            guard let imageUrl = photoUrl, let url = URL(string: imageUrl) else {return}
            imageView.sd_setImage(with: url, completed: nil)
            let profilePhotoUrl = unslplashPhoto.user.profile_image["medium"]
            guard let imageUrlProfile = profilePhotoUrl, let urlProfile = URL(string: imageUrlProfile) else {return}
            imageProfile.sd_setImage(with: urlProfile, completed: nil)
            let userN = unslplashPhoto.user.username
            let like = unslplashPhoto.likes
//            guard let username = userN, let likes = like else { return }
            usernameL.text = userN
            likesL.text = String(like)
            
        }
    }
    
//    var userProfile: User!{
//        didSet{
//            let profilePhotoUrl = userProfile.profile_image["medium"]
//            guard let imageUrl = profilePhotoUrl, let url = URL(string: imageUrl) else {return}
//            imageProfile.sd_setImage(with: url, completed: nil)
//        }
//    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
        imageProfile.image = nil
    }
    
    private func setupView(){
        imageView.contentMode = .scaleAspectFill
        imageProfile.contentMode = .scaleAspectFit
    }

}
