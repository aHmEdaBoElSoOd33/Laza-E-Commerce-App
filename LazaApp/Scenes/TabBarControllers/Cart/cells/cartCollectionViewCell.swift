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
    @IBOutlet weak var increaseQuantityBtn: UIButton!
    @IBOutlet weak var deleteBtn: UIButton!
    @IBOutlet weak var decreaseQuantityBtn: UIButton!
    @IBOutlet weak var countOfProducts: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productImage: UIImageView! 
    
    //MARK: - Variables
    
    static let ID = String(describing: cartCollectionViewCell.self)
    var delegate : CellSubclassCartDelegate?
    var price = 1
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.delegate = nil
    }

    
    
    @IBAction func deleteFromCartBtn(_ sender: Any) {
        delegate?.buttonTapped(cell: self)
    }
    
    
    
    
    @IBAction func productCountVtns(_ sender: UIButton) {
        
        switch sender.tag {
        case 4:
                countOfProducts.text =  String(Int(countOfProducts.text!)!+1)
        default:
                if Int(countOfProducts.text!)! <= 1{
                    countOfProducts.text = "\(1)"
                }else{
                    countOfProducts.text = String(Int(countOfProducts.text!)! - 1)
                }
        }
        
        
        
        
        
        
        
    }
    
    
    
}
