//
//  addressCollectionViewCell.swift
//  LazaApp
//
//  Created by Ahmed on 19/03/2023.
//

import UIKit

protocol CellSubclassAddressDelegate {
    func buttonTapped(cell: addressCollectionViewCell)
}


class addressCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var countryLbl: UILabel! 
    @IBOutlet weak var AddressNameLbl: UILabel!
    
    
    static let ID = String(describing: addressCollectionViewCell.self)
    var delegate : CellSubclassAddressDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.delegate = nil
    }

    @IBAction func addressChekerBtn(_ sender: UIButton) {
        let selection = sender.isSelected
        
        if selection {
            sender.isSelected = false
        }else{
            sender.isSelected = true
        }
        
    }
    
    
    @IBAction func showLocationOnMaps(_ sender: Any) {
        print("hello")
        delegate?.buttonTapped(cell: self)
        
    }
    
    
}
