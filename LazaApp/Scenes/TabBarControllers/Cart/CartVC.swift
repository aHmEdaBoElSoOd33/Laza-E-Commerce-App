//
//  CartVC.swift
//  LazaApp
//
//  Created by Ahmed on 18/03/2023.
//

import UIKit

class CartVC: UIViewController {

    //MARK: - IBOutlets
    
    @IBOutlet weak var cartCollectionView: UICollectionView!
    @IBOutlet weak var addressCollectionView: UICollectionView!
    @IBOutlet weak var subtotalCostLbl: UILabel!
    @IBOutlet weak var totalCostLbl: UILabel!
    @IBOutlet weak var shippingCostLbl: UILabel!
  
    
    
    //MARK: - Variables
     
    static let ID = String(describing: CartVC.self)
    var cartApi = CartApi()
    var cartArray : [CartItem] = []
    var indicatorView : UIActivityIndicatorView?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
     
    override func viewWillAppear(_ animated: Bool) {
        
        uiSetUp()
         getCartDataFromApi()
    }
    
    //MARK: - Functions
    
    func uiSetUp(){
        indicatorView = self.activityIndicator(style: .large,
                                                       center: self.view.center)
        self.view.addSubview(indicatorView!) 
        cartCollectionView.delegate = self
        cartCollectionView.dataSource = self
        addressCollectionView.dataSource = self
        addressCollectionView.dataSource = self
        setupCell(collectionView: cartCollectionView, ID: cartCollectionViewCell.ID)
        setupCell(collectionView: addressCollectionView, ID: addressCollectionViewCell.ID)
        
          self.view.isUserInteractionEnabled = false
          self.indicatorView!.startAnimating()
    }
    
    
    func getCartDataFromApi(){
        cartApi.getFavoriteProducts { data in
            self.cartArray = data
            self.cartCollectionView.reloadData()
            self.view.isUserInteractionEnabled = true
            self.indicatorView!.stopAnimating()
        }
    }
    
    
    //MARK: - IBActions
 
    @IBAction func backBtn(_ sender: Any) {
        tabBarNavigation(pageindex: 0)
    }
    
    
    @IBAction func addAddressBtn(_ sender: Any) {
        
        
        
    }
    
    
}




extension CartVC : UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView{
        case cartCollectionView:
            return cartArray.count
        default:
            return 2
        }
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch collectionView{
        case cartCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cartCollectionViewCell.ID, for: indexPath) as! cartCollectionViewCell
            cell.layer.shadowColor = UIColor.black.cgColor
            cell.layer.shadowOpacity = 0.1
            cell.layer.shadowOffset = CGSize(width: 0, height: 5)
            cell.layer.shadowRadius = 5
            
            
            cell.productName.text = cartArray[indexPath.row].product?.name
            cell.productImage.kf.setImage(with: URL(string: (cartArray[indexPath.row].product?.image)!))
            cell.productPrice.text = "\((cartArray[indexPath.row].product?.price!)!)"
            cell.countOfProducts.text = "1"
            return cell
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: addressCollectionViewCell.ID, for: indexPath) as! addressCollectionViewCell
            return cell
        }
        
        
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch collectionView{
        case cartCollectionView:
            return CGSize(width: collectionView.bounds.width - 10, height: collectionView.bounds.height / 2 - 10 )
        default:
            return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch collectionView{
        case cartCollectionView:
            let vc = storyboard?.instantiateViewController(withIdentifier: ProductDetailVC.ID) as! ProductDetailVC
            vc.id = cartArray[indexPath.row].product?.id
            vc.productinCart = cartArray[indexPath.row].product?.in_cart
            vc.modalTransitionStyle = .crossDissolve
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true)
        default:
            break
        }
    }
}
