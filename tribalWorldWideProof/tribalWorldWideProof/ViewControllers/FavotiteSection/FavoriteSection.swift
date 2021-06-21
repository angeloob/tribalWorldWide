//
//  FavoriteSection.swift
//  tribalWorldWideProof
//
//  Created by Angel Olvera on 17/06/21.
//

import UIKit
import Firebase

class FavoriteSection: UIViewController {

    @IBOutlet weak var collectionV: UICollectionView!{
        didSet{
//            collectionV.register(UINib(nibName: FavoritesCell.identifier, bundle: nil), forCellWithReuseIdentifier: FavoritesCell.identifier)
            collectionV.register(UINib(nibName: PrincipalCvCell.identifier, bundle: nil), forCellWithReuseIdentifier: PrincipalCvCell.identifier)
            collectionV.delegate = self
            collectionV.dataSource = self
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearchBar()
        downloadData()
        setupView()
    }
    
    private func setupView(){
        let cellSize = CGSize(width: self.view.frame.size.width/2.2 , height:400)
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = cellSize
        layout.sectionInset = UIEdgeInsets(top: 1, left: 1, bottom: 1, right: 1)
        layout.minimumLineSpacing = 1.0
        layout.minimumInteritemSpacing = 1.0
        collectionV.setCollectionViewLayout(layout, animated: true)
        collectionV.reloadData()
    }
    
    private func setupSearchBar(){
        title = "Favoritos"
        searchController.searchBar.placeholder = "Ingresa el nombre de usuario o de la foto"
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.delegate = self
        navigationItem.searchController = searchController
    }
    
    var ref: DatabaseReference!
    var dataFirebase = [dataDownloadedFromFirebase]()
    var filtroPost = [dataDownloadedFromFirebase]()
    let searchController = UISearchController(searchResultsController: nil)
    
    func downloadData() {
        ref = Database.database().reference()
        ref.child("data").observe(DataEventType.value) { (snapshot) in
            self.dataFirebase.removeAll()
            for item in snapshot.children.allObjects as! [DataSnapshot]{
                let valores = item.value as? [String : AnyObject]
                print("valores", valores!)
                let username = valores!["username"] as? String ?? ""
                let name = valores!["name"] as? String ?? ""
                let descriptionImage = valores!["desctiptionImagen"] as? String ?? ""
                let likes = valores!["likes"] as? Int ?? 0
                let photoUrl = valores!["photoUrl"] as? String ?? ""
                let profileUrl = valores!["profileUrl"] as? String ?? ""
                let date = valores!["date"] as? String ?? ""
                let dataDownloaded = dataDownloadedFromFirebase(username: username, name: name, descriptionImage: descriptionImage, likes: likes, photoUrl: photoUrl, profileUrl: profileUrl, date: date)
                self.dataFirebase.append(dataDownloaded)
            }
            DispatchQueue.main.async {
                self.collectionV.reloadData()
            }
        }
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        filtroContenido(buscador: self.searchController.searchBar.text!)
    }

    func filtroContenido(buscador: String){
        self.filtroPost = dataFirebase.filter{ data in
            let searched = data.username! + " " + data.date!
            print("filtrado de datos ", searched)
            return((searched.lowercased().contains(buscador.lowercased())))
        }
        DispatchQueue.main.async {
            self.collectionV.reloadData()
        }
    }
}

extension FavoriteSection: UICollectionViewDelegate, UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if searchController.isActive && searchController.searchBar.text != "" {
            return filtroPost.count
        }
        else {
            return dataFirebase.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PrincipalCvCell.identifier, for: indexPath) as! PrincipalCvCell
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FavoritesCell.identifier, for: indexPath) as! FavoritesCell
        let dataD: dataDownloadedFromFirebase
        if searchController.isActive && searchController.searchBar.text != "" {
            dataD = filtroPost[indexPath.row]
            cell.favoritePhoto = dataD
        }
        else {
            dataD = dataFirebase[indexPath.row]
            cell.favoritePhoto = dataD
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PrincipalCvCell.identifier, for: indexPath) as! PrincipalCvCell
        let dataD: dataDownloadedFromFirebase
        if searchController.isActive && searchController.searchBar.text != "" {
            dataD = filtroPost[indexPath.row]
            debugPrint(indexPath.item)
            let vc = DetailVC.newFavoritesInstance(data: dataD)
            navigationController?.pushViewController(vc, animated: true)
        }
        else {
            dataD = dataFirebase[indexPath.row]
            debugPrint(indexPath.item)
            let vc = DetailVC.newFavoritesInstance(data: dataD)
            navigationController?.pushViewController(vc, animated: true)
        }
//        let unsplashPhoto = photos[indexPath.item]
//        debugPrint(indexPath.item)
//        let vc = DetailVC.newInstance(data: unsplashPhoto)
//        navigationController?.pushViewController(vc, animated: true)
    }
}

extension FavoriteSection: UISearchBarDelegate, UISearchResultsUpdating{
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        debugPrint(searchText)
        filtroContenido(buscador: searchText)
    }
}
