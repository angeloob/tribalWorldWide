//
//  PrincipalCvCell.swift
//  tribalWorldWideProof
//
//  Created by Angel Olvera on 17/06/21.
//

import UIKit

class PrincipalCvCell: UICollectionViewCell {

    static let identifier = "PrincipalCvCell"
    
    @IBOutlet weak var imageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
    }
    
    private func setupView(){
        imageView.contentMode = .scaleAspectFill
    }

}
