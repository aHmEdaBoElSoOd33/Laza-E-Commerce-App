//
//  categoriesCollectionVieCell.swift
//  LazaApp
//
//  Created by Ahmed on 18/03/2023.
//

import UIKit

class categoriesCollectionVieCell: UICollectionViewCell {
   
    //MARK: - IBOutlets
    
    
    @IBOutlet weak var categoryImage: UIImageView!
    @IBOutlet weak var categoryName: UILabel!
    
    
    //MARK: - Variables
    static let ID = String(describing: categoriesCollectionVieCell.self)
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

}
