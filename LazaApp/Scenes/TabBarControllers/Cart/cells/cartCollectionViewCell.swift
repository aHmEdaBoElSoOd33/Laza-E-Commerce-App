//
//  cartCollectionViewCell.swift
//  LazaApp
//
//  Created by Ahmed on 19/03/2023.
//

import UIKit

class cartCollectionViewCell: UICollectionViewCell {

    static let ID = String(describing: cartCollectionViewCell.self)
     
    @IBOutlet weak var countOfProducts: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
    
    @IBAction func deleteFromCartBtn(_ sender: Any) {
    }
    
    
    
    
    @IBAction func productCountVtns(_ sender: Any) {
    }
    
    
    
}
