//
//  ProfileCell.swift
//  tribalWorldWideProof
//
//  Created by Angel Olvera on 19/06/21.
//

import UIKit
import SDWebImage

class ProfileCell: UICollectionViewCell {
    
    static let identifier = "ProfileCell"

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var opaqueView: UIView!
    @IBOutlet weak var titleL: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setData(imagePhoto: imagePhoto){
            opaqueView.isHidden = false
            opaqueView.isHidden = true
            let photoUrl = imagePhoto.urls["full"]
            guard let imageUrl = photoUrl, let url = URL(string: imageUrl) else {return}
            imageView.sd_setImage(with: url, completed: nil)
            imageView.contentMode = .scaleAspectFit
//        }
    }
    
    func setDataOfCollections(imagePhoto: collectionPhoto){
            opaqueView.isHidden = false
            opaqueView.isHidden = true
            let photoUrl = imagePhoto.urls["full"]
            guard let imageUrl = photoUrl, let url = URL(string: imageUrl) else {return}
            imageView.sd_setImage(with: url, completed: nil)
            imageView.contentMode = .scaleAspectFit
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
//        imageProfile.image = nil
    }

}
