//
//  ProfileDetailsVC.swift
//  tribalWorldWideProof
//
//  Created by Angel Olvera on 19/06/21.
//

import UIKit
import SDWebImage

class ProfileDetailsVC: UIViewController {
    
    @IBOutlet weak var usernameL: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var detailsL: UILabel!
    @IBOutlet weak var numberOfPhotosL: UILabel!
    @IBOutlet weak var photosL: UILabel!
    @IBOutlet weak var numberOfCollectionsL: UILabel!
    @IBOutlet weak var collectionsL: UILabel!
    @IBOutlet weak var numberOfLikes: UILabel!
    @IBOutlet weak var likesL: UILabel!
    @IBOutlet weak var locationL: UILabel!
    @IBOutlet weak var collectionsTitleL: UILabel!
    @IBOutlet weak var photoCV: UICollectionView!{
        didSet{
            photoCV.register(UINib(nibName: ProfileCell.identifier, bundle: nil), forCellWithReuseIdentifier: ProfileCell.identifier)
            photoCV.delegate = self
            photoCV.dataSource = self
        }
    }
    @IBOutlet weak var collectionsCV: UICollectionView!{
        didSet{
            collectionsCV.register(UINib(nibName: ProfileCell.identifier, bundle: nil), forCellWithReuseIdentifier: ProfileCell.identifier)
            collectionsCV.delegate = self
            collectionsCV.dataSource = self
        }
    }
    
    var username: String? = ""
    var networService = NetworkService()
    var networkDataFetcher = NetworkDataFetcher()
    private var timer: Timer?
    private var photos = [userData]()
    private var imagePhotos = [imagePhoto]()
    private var collectionPhotos = [collectionPhoto]()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView(){
        profileImage.layer.cornerRadius = profileImage.frame.size.width / 2
        let cellSize = CGSize(width: view.frame.size.width/2.2 , height:400)
//        let layout = UICollectionViewFlowLayout()
//        layout.scrollDirection = .horizontal
//        layout.itemSize = cellSize
//        layout.sectionInset = UIEdgeInsets(top: 1, left: 1, bottom: 1, right: 1)
//        layout.minimumLineSpacing = 1.0
//        layout.minimumInteritemSpacing = 1.0
//        photoCV.setCollectionViewLayout(layout, animated: true)
//        collectionsCV.setCollectionViewLayout(layout, animated: true)
//        photoCV.reloadData()
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { (_) in
            self.networkDataFetcher.fetchImagesForProfile(username: self.username!, isForPhotos: false) { [weak self] (searchResults) in
                guard let fetchedPhotos = searchResults else {return}
                let urlProfile = URL(string: fetchedPhotos.profile_image["large"]!)
                self?.profileImage.sd_setImage(with: urlProfile, completed: nil)
                self!.usernameL.text = fetchedPhotos.name ?? ""
                self!.detailsL.text = fetchedPhotos.bio ?? ""
                self!.numberOfPhotosL.text = String(fetchedPhotos.total_photos)
                self!.numberOfLikes.text = String(fetchedPhotos.total_likes)
                self!.numberOfCollectionsL.text = String(fetchedPhotos.total_collections)
                self!.locationL.text = fetchedPhotos.location ?? "--"
            }
            self.networkDataFetcher.fetchImagesForPhotos(username: self.username!, isForPhotos: true){ [weak self] (searchResults) in
                guard let fetchedPhotos = searchResults else {return}
                self!.imagePhotos = fetchedPhotos
                self?.photoCV.reloadData()
            }
            self.networkDataFetcher.fetchImagesForCollection(username: self.username!){ [weak self] (searchResults) in
                guard let fetchedPhotos = searchResults else {return}
                self!.collectionPhotos = fetchedPhotos
                self?.collectionsCV.reloadData()
            }
        })
    }

}

extension ProfileDetailsVC: UICollectionViewDelegate, UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
            case photoCV:
                return imagePhotos.count
            case collectionsCV:
//                return imagePhotos.count
                if collectionPhotos.count == 0{
                    collectionsTitleL.isHidden = true
                }
                return collectionPhotos.count
            default:
                return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
            case photoCV:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProfileCell.identifier, for: indexPath) as! ProfileCell
                cell.setData(/*isCollection: false,*/ imagePhoto: imagePhotos[indexPath.item])
                return cell
            case collectionsCV:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProfileCell.identifier, for: indexPath) as! ProfileCell
//                cell.setData(/*isCollection: false,*/ imagePhoto: imagePhotos[indexPath.item])
                cell.setDataOfCollections(imagePhoto: collectionPhotos[indexPath.item])
                return cell
            default:
                return UICollectionViewCell()
        }
    }
    
    
}
