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
    
    func setData(/*isCollection: Bool,*/ imagePhoto: imagePhoto){
//        if isCollection{
            opaqueView.isHidden = false
            
//        }else{
            opaqueView.isHidden = true
            let photoUrl = imagePhoto.urls["full"]
            guard let imageUrl = photoUrl, let url = URL(string: imageUrl) else {return}
//            imageView.sd_setImage(with: url, completed: nil)
            imageView.contentMode = .scaleAspectFit
            load(url: url)
//            imageProfile.contentMode = .scaleAspectFit
//        }
    }
    
    func setDataOfCollections(/*isCollection: Bool,*/ imagePhoto: collectionPhoto){
//        if isCollection{
            opaqueView.isHidden = false
            
//        }else{
            opaqueView.isHidden = true
            let photoUrl = imagePhoto.urls["full"]
            guard let imageUrl = photoUrl, let url = URL(string: imageUrl) else {return}
//            imageView.sd_setImage(with: url, completed: nil)
            imageView.contentMode = .scaleAspectFit
            load(url: url)
//            imageProfile.contentMode = .scaleAspectFit
//        }
    }
    
    func load(url: URL) {
            DispatchQueue.global().async { [weak self] in
                if let data = try? Data(contentsOf: url) {
                    if let image = UIImage(data: data) {
                        DispatchQueue.main.async {
                            self?.imageView.image = image
                        }
                    }
                }
            }
        }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
//        imageProfile.image = nil
    }

}
