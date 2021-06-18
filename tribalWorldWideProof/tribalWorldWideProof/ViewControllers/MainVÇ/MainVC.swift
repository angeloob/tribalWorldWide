//
//  MainVC.swift
//  tribalWorldWideProof
//
//  Created by Angel Olvera on 17/06/21.
//

import UIKit

class MainVC: UIViewController {

    @IBOutlet weak var collectioV: UICollectionView!{
        didSet{
            collectioV.register(UINib(nibName: PrincipalCvCell.identifier, bundle: nil), forCellWithReuseIdentifier: PrincipalCvCell.identifier)
            collectioV.delegate = self
            collectioV.dataSource = self
        }
    }
    
    var networService = NetworkService()
    var networkDataFetcher = NetworkDataFetcher()
    private var timer: Timer?
    private var photos = [UnsplashPhoto]()
    
    var unslplashPhoto: UnsplashPhoto!{
        didSet{
            let photoUrl = unslplashPhoto.urls["regular"]
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearchBar()
        setupView()
    }
    
    private func setupSearchBar(){
        title = "Bienvenido"
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.placeholder = "Ingresa el nombre de usuario o de la foto"
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.delegate = self
        navigationItem.searchController = searchController
    }
    
    private func setupView(){
        
    }

}


extension MainVC: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PrincipalCvCell.identifier, for: indexPath) as! PrincipalCvCell
        let unsplashPhoto = photos[indexPath.item]
        return cell
    }
    
    
}

extension MainVC: UISearchBarDelegate{
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        debugPrint(searchText)
        
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { (_) in
            self.networkDataFetcher.fetchImages(searchTerm: searchText) { [weak self] (searchResults) in
                guard let fetchedPhotos = searchResults else {return}
                self?.photos = fetchedPhotos.results
            }
        })
    }
    
}
