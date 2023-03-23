//
//  addressCollectionViewCell.swift
//  LazaApp
//
//  Created by Ahmed on 19/03/2023.
//

import UIKit

class addressCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var countryLbl: UILabel!
    
    @IBOutlet weak var AddressNameLbl: UILabel!
    static let ID = String(describing: addressCollectionViewCell.self)
     
    override func awakeFromNib() {
        super.awakeFromNib()
         
    }

    @IBAction func addressChekerBtn(_ sender: UIButton) {
        let selection = sender.isSelected
        
        if selection {
            sender.isSelected = false
        }else{
            sender.isSelected = true
        }
        
    }
}
