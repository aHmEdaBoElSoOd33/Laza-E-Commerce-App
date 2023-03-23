//
//  ProductDetailVC.swift
//  LazaApp
//
//  Created by Ahmed on 22/03/2023.
//

import UIKit
import Kingfisher
class ProductDetailVC: UIViewController {

    //MARK: - IBOutlets
    
    @IBOutlet weak var descriptionTitle: UILabel!
    
    @IBOutlet weak var priceTitle: UILabel!
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var productImagesCollectionView: UICollectionView!
    @IBOutlet weak var productDescription: UILabel!
   
    //MARK: - Variables
    
    static let ID = String(describing: ProductDetailVC.self)
    var id : Int?
    var productDetailsApi = ProductDetailsApi()
    var indicatorView : UIActivityIndicatorView?
    var productImagesArray : [String] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        print(id)
        uiSetIp()
        getProductDetailsFromApi(id: id!)
    }
    
    func uiSetIp(){
        priceTitle.isHidden = true
        descriptionTitle.isHidden = true 
        indicatorView = self.activityIndicator(style: .large,
                                                       center: self.view.center)
        self.view.addSubview(indicatorView!)
        indicatorView!.startAnimating()
        productImagesCollectionView.delegate = self
        productImagesCollectionView.dataSource = self
    }
    
    
    
    
    
    func getProductDetailsFromApi(id:Int){
        
        productDetailsApi.getProuductDetailsInfo(id: id) { data,error  in 
            
            if let data = data {
                self.productImage.kf.setImage(with: URL(string: (data.image!)),placeholder: UIImage(named: "Logo")?.withTintColor(UIColor(named: "BackGrpundColor")!))
                self.productName.text = data.name
                self.productPrice.text = "\(data.price!)"
                self.productDescription.text = data.description
                self.productImagesArray = (data.images!)
                self.productImagesCollectionView.reloadData()
                self.indicatorView?.stopAnimating()
                self.priceTitle.isHidden = false
                self.descriptionTitle.isHidden = false
            }else{
                self.showALert(message: error!)
                self.indicatorView?.stopAnimating()
            }
            
        }
    }
    
    //MARK: - IBActions

    @IBAction func cartBtn(_ sender: Any) {
        tabBarNavigation(pageindex: 2)
    }
    
    
    @IBAction func backBtn(_ sender: Any) {
        dismiss(animated: true)
    }
}



extension ProductDetailVC: UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return productImagesArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductDetailsCollectionViewCell.ID, for: indexPath) as! ProductDetailsCollectionViewCell
        
        cell.productImage.kf.setImage(with: URL(string: productImagesArray[indexPath.row]),placeholder: UIImage(named: "Logo")?.withTintColor(UIColor(named: "BackGrpundColor")!))
        cell.layer.borderWidth = 0.2
        cell.layer.borderColor = UIColor.black.cgColor
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 100)
    }
    
    
    
}
