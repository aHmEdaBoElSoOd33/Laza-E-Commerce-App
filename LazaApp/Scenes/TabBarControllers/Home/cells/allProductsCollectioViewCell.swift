//
//  allProductsCollectioViewCell.swift
//  LazaApp
//
//  Created by Ahmed on 18/03/2023.
//

import UIKit

protocol CellSubclassProductDelegate {
    func buttonTapped(cell: allProductsCollectioViewCell)
}

class allProductsCollectioViewCell: UICollectionViewCell {

    //MARK: - IBOutlets
    
    @IBOutlet weak var favBtn: UIButton!
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var productName: UILabel!
    
    //MARK: - Variables
    
    static let ID = String(describing: allProductsCollectioViewCell.self)
    var faveBtnSelected : Bool?
    var delegate : CellSubclassProductDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        self.delegate = nil
    }
    
//MARK: - IBActions
    
    @IBAction func addToWishListBtn(_ sender: Any) {
    
        delegate?.buttonTapped(cell: self)
        
    }
    
    
    
    
}
