//
//  CategoriesDetailsVC.swift
//  LazaApp
//
//  Created by Ahmed on 20/03/2023.
//

import UIKit

class CategoriesDetailsVC: UIViewController{
 

    @IBOutlet weak var numberOfItems: UILabel!
    @IBOutlet weak var categoryName: UILabel!
    @IBOutlet weak var categoriesProductsCollectionView: UICollectionView!
    
    
    static let ID = String(describing: CategoriesDetailsVC.self)
    var numOfItems = 0
    var categoryTitle = ""
    var categoryProuductsArray : [categoryDetails] = []
    var categoriesApi = CategoriesApi()
    var wishlistApi = WishlistApi()
    var id : Int?
    var indicatorView : UIActivityIndicatorView?
    override func viewDidLoad() {
        super.viewDidLoad()
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        uiSetUp()
        getCateguriesDetailsData(id: id!)
        wishlistApi.delegate = self
    }
    
    
    func getCateguriesDetailsData(id:Int){
        
        categoriesApi.getCategoriesDetails(id: id) { data in
            self.categoryProuductsArray = data
            self.categoriesProductsCollectionView.reloadData()
            self.numberOfItems.text = "\(self.categoryProuductsArray.count ) Items"
            self.view.isUserInteractionEnabled = true
            self.indicatorView!.stopAnimating()
        }
    }
    
    
    func uiSetUp() {
        self.view.isUserInteractionEnabled = false
        indicatorView = self.activityIndicator(style: .large,
                                                       center: self.view.center)
        self.view.addSubview(indicatorView!)
         
        indicatorView!.startAnimating()
        categoryName.text = categoryTitle
        categoriesProductsCollectionView.delegate = self
        categoriesProductsCollectionView.dataSource = self
         
        setupCell(collectionView: categoriesProductsCollectionView, ID: allProductsCollectioViewCell.ID)
    }
    
    @IBAction func backBtn(_ sender: Any) {
        dismiss(animated: true)
    }
    
    
    @IBAction func sortBtn(_ sender: Any) {
        
    }
    
    @IBAction func cartBtn(_ sender: Any) {
        tabBarNavigation(pageindex: 2)
    }
    
}



extension CategoriesDetailsVC : UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout , WishlistApiDelegate , CellSubclassProductDelegate {
   
    
    func buttonTapped(cell: allProductsCollectioViewCell) {
        guard let indexPath = self.categoriesProductsCollectionView.indexPath(for: cell) else { return }
        
        wishlistApi.addproductToFavoriets(id: categoryProuductsArray[indexPath.row].id!)
        
        print("Button tapped on row \(indexPath.row)")
    }
    
     
    func isDone(message: String) {
        showALert(message: message)
    }
    
    func isFail(message: String) {
        showALert(message: message)
    }
      
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categoryProuductsArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: allProductsCollectioViewCell.ID, for: indexPath) as! allProductsCollectioViewCell
        if categoryProuductsArray.isEmpty {
            cell.favBtn.setImage(UIImage(systemName:  "heart"), for: .normal)
            cell.favBtn.tintColor = .lightGray
        }else{
            if categoryProuductsArray[indexPath.row].in_favorites! {
                cell.favBtn.setImage(UIImage(systemName:  "heart.fill"), for: .normal)
                cell.favBtn.tintColor = .red
            }else{
                cell.favBtn.setImage(UIImage(systemName:  "heart"), for: .normal)
                cell.favBtn.tintColor = .lightGray
            }
        }
        cell.productImage.kf.setImage(with: URL(string: categoryProuductsArray[indexPath.row].image!),placeholder: UIImage(named: "Logo")?.withTintColor(UIColor(named: "BackGrpundColor")!))
        cell.productName.text = categoryProuductsArray[indexPath.row].name
        cell.productPrice.text = "\(categoryProuductsArray[indexPath.row].price!)"
        cell.delegate = self
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: collectionView
            .bounds.width / 2 - 15, height: 260 )
    }
      
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
         
        let vc = storyboard?.instantiateViewController(withIdentifier: ProductDetailVC.ID) as! ProductDetailVC
        vc.id = categoryProuductsArray[indexPath.row].id
        vc.productinCart = categoryProuductsArray[indexPath.row].in_cart
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
}
