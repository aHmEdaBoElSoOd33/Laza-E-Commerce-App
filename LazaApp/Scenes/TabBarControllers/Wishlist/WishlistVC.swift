//
//  WishlistVC.swift
//  LazaApp
//
//  Created by Ahmed on 18/03/2023.
//

import UIKit

class WishlistVC: UIViewController {

    //MARK: - IBOutlets
    
    
    @IBOutlet weak var numberOfItemsLbl: UILabel!
    @IBOutlet weak var wishlistCillectionview: UICollectionView!
    
    
    //MARK: - Variables
    
    static let ID = String(describing: WishlistVC.self)
    var wishlistApi = WishlistApi()
    var wishlistArray : [WishlistData] = []
    var indicatorView : UIActivityIndicatorView?
    var hideFavebtn = true
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) { 
        uiSetup()
        getAllWishlistDataFromApi()
        wishlistApi.delegate = self
    }
    
     //MARK: - Functions
    
    func getAllWishlistDataFromApi(){
        wishlistApi.getFavoriteProducts { data in
            self.wishlistArray = data
            self.numberOfItemsLbl.text = "\(self.wishlistArray.count) Items"
            self.wishlistCillectionview.reloadData()
            self.indicatorView?.stopAnimating()
            self.view.isUserInteractionEnabled = true
        }
    }
    
    
    
    func uiSetup(){
        indicatorView = self.activityIndicator(style: .large,
                                                       center: self.view.center)
        self.view.addSubview(indicatorView!)
        
        wishlistCillectionview.dataSource = self
        wishlistCillectionview.delegate = self
        setupCell(collectionView: wishlistCillectionview, ID: allProductsCollectioViewCell.ID)
      
        self.view.isUserInteractionEnabled = false
        self.indicatorView!.startAnimating()
        
    }
    
    
    
     
     
    
    //MARK: - IBActions
    
    @IBAction func editBtn(_ sender: UIButton) {
        
        if hideFavebtn == true{
            hideFavebtn = false
            wishlistCillectionview.reloadData()
            sender.setTitle("Cancel", for: .normal)
            sender.setImage(.none, for: .normal)
        }else{
            hideFavebtn = true
            wishlistCillectionview.reloadData()
            sender.setTitle("Edit", for: .normal)
            sender.setImage(UIImage(named: "Edit"), for: .normal)
        }
    }
    
    
    @IBAction func cartBtn(_ sender: Any) {
        tabBarNavigation(pageindex: 2)
    }
    
    @IBAction func backBtn(_ sender: Any) {
        tabBarNavigation(pageindex: 0) 
    }
    
}



extension WishlistVC : UICollectionViewDelegate , UICollectionViewDataSource,UICollectionViewDelegateFlowLayout , CellSubclassProductDelegate , WishlistApiDelegate {
    func isDone(message: String) {
        showALert(message: message)
        //uiSetup()
        getAllWishlistDataFromApi()
    }
    
    func isFail(message: String) {
        showALert(message: message)
        getAllWishlistDataFromApi()
    }
    
   
    
    func buttonTapped(cell: allProductsCollectioViewCell) {
        guard let indexPath = self.wishlistCillectionview.indexPath(for: cell) else { return }
        
        wishlistApi.addproductToFavoriets(id: (wishlistArray[indexPath.row].product?.id)!)
        print("Button tapped on row \(indexPath.row)")
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return wishlistArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: allProductsCollectioViewCell.ID, for: indexPath) as! allProductsCollectioViewCell
        cell.favBtn.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        cell.favBtn.tintColor = .red
        cell.favBtn.isHidden = hideFavebtn
        cell.productImage.kf.setImage(with: URL(string: (wishlistArray[indexPath.row].product?.image)!),placeholder: UIImage(named: "Logo")?.withTintColor(UIColor(named: "BackGrpundColor")!))
        cell.productName.text = wishlistArray[indexPath.row].product?.name
        cell.productPrice.text = "\((wishlistArray[indexPath.row].product?.price)!)"
        cell.delegate = self
        return cell
    }
    
    
     
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width / 2 - 15, height: 260)
    } 
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: ProductDetailVC.ID) as! ProductDetailVC
        vc.id = wishlistArray[indexPath.row].product?.id
        vc.productinCart = false
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
            var numOfSections: Int = 0
            if wishlistArray.count != 0
            {
                //collectionView.separatorStyle = .singleLine
                numOfSections            = 1
                collectionView.backgroundView = nil
            }
            else
            {
                
                let noDataLabel: UILabel  = UILabel(frame: CGRect(x: 0, y: 0, width: collectionView.bounds.size.width, height: collectionView.bounds.size.height))
                noDataLabel.text = "No items in wishlist yet"
                noDataLabel.font = .boldSystemFont(ofSize: 25)
                noDataLabel.textColor     = UIColor.lightGray
                noDataLabel.textAlignment = .center
                collectionView.backgroundView  = noDataLabel
                //collectionView.separatorStyle  = .none
            }
            return numOfSections
    }
    
}
