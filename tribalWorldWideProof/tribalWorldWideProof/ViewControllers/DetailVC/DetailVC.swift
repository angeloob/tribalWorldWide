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
    var urlSringPhoto: String?
    var unsplashInfo: UnsplashPhoto?
    var dataFirebase: dataDownloadedFromFirebase?
    var isFavoriteButtonSelected: Bool?
    var isFavoriteVc: Bool?
    var ref: DatabaseReference!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    @IBAction func addFavoritesButtonTapped(_ sender: Any) {
        isFavoriteButtonSelected = !isFavoriteButtonSelected!
        let networking = NetworkService()
        if isFavoriteButtonSelected!{
            if isFavoriteVc!{
                networking.uploadFireBase(data: dataFirebase!)
            }else{
                networking.uploadFireBase(data: unsplashInfo!)
            }
            self.genericAlert(title: "Guardado Correctamente", description: "La imagen se guardó correctamente en favoritos")
            addFavoritesButton.setImage(UIImage(systemName: "star.fill"), for: .normal)
        }else{
            if isFavoriteVc!{
                networking.removeFirebase(data: dataFirebase!)
            }else{
                networking.removeFirebase(data: unsplashInfo!)
            }
            self.genericAlert(title: "Borrado exitoso", description: "La imagen fue eliminada de favoritos exitosamente")
            addFavoritesButton.setImage(UIImage(systemName: "star"), for: .normal)
        }
    }
    
    @IBAction func profileDetailsButtonTapped(_ sender: Any) {
        let vc = ProfileDetailsVC()
        vc.username = username
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func setupView(){
        title = "Detalles de la imagen"
        usernameL.text = username
        likesL.text = likes
        descriptionL.text = descriptionImage
        imageView.sd_setImage(with: urlImage, completed: nil)
        profileImage.sd_setImage(with: urlProfile, completed: nil)
        dateL.text = getFormattedDate(isoDate: dateImage!, format: "dd/MMM/yyyy")
        if isFavoriteVc!{
            isFavoriteButtonSelected = true
            addFavoritesButton.setImage(UIImage(systemName: "star.fill"), for: .normal)
        }else{
            isFavoriteButtonSelected = false
            addFavoritesButton.setImage(UIImage(systemName: "star"), for: .normal)
        }
    }
    
    public static func newInstance(data: UnsplashPhoto)-> DetailVC {
        let vc = DetailVC()
        let photoUrl = data.urls["full"]!
        let profileUrl = data.user.profile_image["medium"]
        vc.urlSringPhoto = photoUrl
        vc.username = data.user.username
        vc.likes = String(data.likes)
        vc.descriptionImage = data.description
        vc.urlImage = URL(string: photoUrl)
        vc.urlProfile = URL(string: profileUrl!)
        vc.dateImage = data.created_at
        vc.unsplashInfo = data
        vc.isFavoriteVc = false
        return vc
    }
    
    public static func newFavoritesInstance(data: dataDownloadedFromFirebase)-> DetailVC {
        let vc = DetailVC()
        let photoUrl = data.photoUrl
        let profileUrl = data.profileUrl
        vc.urlSringPhoto = photoUrl
        vc.username = data.username
        vc.likes = "\(data.likes ?? 0)"
        vc.descriptionImage = data.descriptionImage
        vc.urlImage = URL(string: photoUrl!)
        vc.urlProfile = URL(string: profileUrl!)
        vc.dateImage = data.date
        vc.dataFirebase = data
        vc.isFavoriteVc = true
        return vc
    }
}
