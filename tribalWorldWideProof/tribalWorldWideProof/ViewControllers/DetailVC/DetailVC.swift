//
//  DetailVC.swift
//  tribalWorldWideProof
//
//  Created by Angel Olvera on 18/06/21.
//

import UIKit
import SDWebImage
import Firebase

class DetailVC: UIViewController {
    
    @IBOutlet weak var usernameL: UILabel!
    @IBOutlet weak var likesL: UILabel!
    @IBOutlet weak var descriptionL: UILabel!
    @IBOutlet weak var dateL: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var addFavoritesButton: UIButton!
    
    var username: String?
    var likes: String?
    var descriptionImage: String?
    var date: String?
    var urlImage: URL?
    var urlProfile: URL?
    var dateImage: String?
    var unsplashInfo: UnsplashPhoto?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    @IBAction func addFavoritesButtonTapped(_ sender: Any) {
        let networking = NetworkService()
        networking.uploadFireBase(array: unsplashInfo!)
    }
    
    private func setupView(){
        title = "Detalles de la imagen"
        usernameL.text = username
        likesL.text = likes
        descriptionL.text = descriptionImage
        imageView.sd_setImage(with: urlImage, completed: nil)
        profileImage.sd_setImage(with: urlProfile, completed: nil)
        dateL.text = getFormattedDate(isoDate: dateImage!, format: "dd/MMM/yyyy")
    }
    
    public static func newInstance(data: UnsplashPhoto)-> DetailVC {
        let vc = DetailVC()
        let photoUrl = data.urls["full"]!
        let profileUrl = data.user.profile_image["medium"]
        vc.username = data.user.username
        vc.likes = String(data.likes)
        vc.descriptionImage = data.description
        vc.urlImage = URL(string: photoUrl)
        vc.urlProfile = URL(string: profileUrl!)
        vc.dateImage = data.created_at
        vc.unsplashInfo = data
        return vc
    }
}
