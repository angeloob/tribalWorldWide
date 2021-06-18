//
//  FavoriteSection.swift
//  tribalWorldWideProof
//
//  Created by Angel Olvera on 17/06/21.
//

import UIKit

class FavoriteSection: UIViewController {

    @IBOutlet weak var collectionV: UICollectionView!{
        didSet{
            collectionV.register(UINib(nibName: FavoritesCell.identifier, bundle: nil), forCellWithReuseIdentifier: FavoritesCell.identifier)
            collectionV.delegate = self
            collectionV.dataSource = self
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearchBar()
    }
    
    private func setupSearchBar(){
        title = "Favoritos"
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.placeholder = "Ingresa el nombre de usuario o de la foto"
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.delegate = self
        navigationItem.searchController = searchController
    }
}

extension FavoriteSection: UICollectionViewDelegate, UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FavoritesCell.identifier, for: indexPath) as! FavoritesCell
        return cell
    }
    
    
}

extension FavoriteSection: UISearchBarDelegate{
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        debugPrint(searchText)
    }
}
