//
//  cartCollectionViewCell.swift
//  LazaApp
//
//  Created by Ahmed on 19/03/2023.
//

import UIKit

protocol CellSubclassCartDelegate {
    func buttonTapped(cell: cartCollectionViewCell)
}


class cartCollectionViewCell: UICollectionViewCell {

   
     //MARK: - IBOutlets
    @IBOutlet weak var countOfProducts: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productImage: UIImageView!
    
    
    //MARK: - Variables
    
    static let ID = String(describing: cartCollectionViewCell.self)
    var delegate : CellSubclassCartDelegate?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.delegate = nil
    }

    
    
    @IBAction func deleteFromCartBtn(_ sender: Any) {
        delegate?.buttonTapped(cell: self)
    }
    
    
    
    
    @IBAction func productCountVtns(_ sender: Any) {
    }
    
    
    
}
