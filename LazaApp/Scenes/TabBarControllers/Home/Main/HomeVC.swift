//
//  HomeVC.swift
//  LazaApp
//
//  Created by Ahmed on 18/03/2023.
//

import UIKit
import FBSDKLoginKit
import FBSDKCoreKit
import FirebaseAuth
import FirebaseCore
import GoogleSignIn
import Kingfisher

class HomeVC: UIViewController {
    
    
    //MARK: - IBOutlets
    
    @IBOutlet weak var blurView: UIVisualEffectView!
    @IBOutlet weak var numberOfOrders: UILabel!
    @IBOutlet weak var blureViewsideMenuConstrain: NSLayoutConstraint!
    @IBOutlet weak var sidemenuCoistrain: NSLayoutConstraint!
    @IBOutlet weak var searchTxtField: UITextField!
    @IBOutlet weak var categoriesCollectionView: UICollectionView!
    @IBOutlet weak var newArraivalCollectionView: UICollectionView!
    @IBOutlet weak var userProfileImage: UIImageView!
    @IBOutlet weak var userProflleName: UILabel!
    
    //MARK: - Variables
    
    
    //var image : UIImage?
    static let ID = String(describing: HomeVC.self)
    let profileApi = HomeApi()
    let categoriesApi = CategoriesApi()
    let newArrivalApi = HomeApi()
    let wishlistApi = WishlistApi()
    var categoriesArray : [Datum] = []
    var newArrivalArray : [Product] = []
    lazy var indicatorView : UIActivityIndicatorView = { self.activityIndicator(style: .large,center: self.view.center)
    }()
    lazy var newArrivalIndicatorView : UIActivityIndicatorView = { self.activityIndicator(style: .large,center: self.view.center)
    }()
    var cartApi = CartApi()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //        if let user = Auth.auth().currentUser {
        //            userProflleName.text = user.displayName
        //            userProfileImage.kf.setImage(with: user.photoURL)
        //        } else {
        //            print("User is logged out")
        //        }
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        newArrivalArray.removeAll()
        categoriesArray.removeAll()
        
        newArraivalCollectionView.reloadData()
        categoriesCollectionView.reloadData()
        setupUI()
        fetchNewArraivalDataFromApi()
        fetchCategorisDataFromApi()
        profileApi.delegate = self
        wishlistApi.delegate = self
        profileApi.getUserProfileData()
    }
    
    
    //MARK: - Functions
    
    func fetchNewArraivalDataFromApi(){
        
        newArrivalApi.getHomeData { data,error  in
            
            self.view.isUserInteractionEnabled = true
            self.newArrivalIndicatorView.stopAnimating()
            
            if let data = data {
                self.newArrivalArray = data
                self.newArraivalCollectionView.reloadData()
                self.getNumberOfOrdersSideMenu()
                
            }else if let error = error {
                
                self.showALert(message: error.localizedDescription )
            }
        }
    }
    
    
    func fetchCategorisDataFromApi(){
        
        self.indicatorView.stopAnimating()
        
        categoriesApi.getCategories { data,error  in
            if let data = data {
                self.categoriesArray = data
                print(self.categoriesArray.first?.name)
                self.categoriesCollectionView.reloadData()
            }else if let error = error{
                self.showALert(message: error.localizedDescription)
            }
            
            
        }
    }
    
    
    func setUpUIwithData(with userdata: DataClass){
        userProflleName.text = userdata.name
        userProfileImage.kf.setImage(with: URL(string: userdata.image!))
    }
    
    func getNumberOfOrdersSideMenu(){
        cartApi.getCartProducts { data, subdata in
            
            if data!.count <= 1{
                self.numberOfOrders.text = "\((data?.count)!) Order"
            }else{
                self.numberOfOrders.text = "\((data?.count)!) Orders"
            }
        }
    }
    
    func setupUI(){
        self.view.isUserInteractionEnabled = false
        self.view.addSubview(indicatorView)
        self.view.addSubview(newArrivalIndicatorView)
        indicatorView.startAnimating()
        newArrivalIndicatorView.startAnimating()
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.tapHandler))
        blurView.addGestureRecognizer(tap)
        categoriesCollectionView.delegate = self
        categoriesCollectionView.dataSource = self
        newArraivalCollectionView.delegate = self
        newArraivalCollectionView.dataSource = self
        setupCell(collectionView: categoriesCollectionView, ID: categoriesCollectionVieCell.ID)
        setupCell(collectionView: newArraivalCollectionView, ID: allProductsCollectioViewCell.ID)
        
        
    }
    
    @objc func tapHandler(){
        //print("tap fireeeeeee")
        tabBarController?.tabBar.isHidden = false
        UIView.animate(withDuration: 0.2 ){
            self.blureViewsideMenuConstrain.constant = 0
            self.view.layoutIfNeeded()
        }
        UIView.animate(withDuration: 0.4 ){
            self.sidemenuCoistrain.constant = 0
            self.view.layoutIfNeeded()
        }
    }
    
    //MARK: - IBActions
    
    @IBAction func viewAllCategoriesBtn(_ sender: Any) {
        
        let vc = storyboard?.instantiateViewController(identifier: AllCategoriesVC.ID) as! AllCategoriesVC
        
        vc.modalPresentationStyle = .fullScreen
        vc.modalTransitionStyle = .crossDissolve
        
        present(vc, animated: true)
    }
    
    
    @IBAction func viewAllProducts(_ sender: Any) {
        
    }
    
    
    
    @IBAction func sideMenuBtn(_ sender: Any) {
        tabBarController?.tabBar.isHidden = true
        
        UIView.animate(withDuration: 0.2 ){
            
            self.blureViewsideMenuConstrain.constant = self.view.frame.width
            self.view.layoutIfNeeded()
        }
        
        UIView.animate(withDuration: 0.4 ){
            self.sidemenuCoistrain.constant = self.view.frame.width / 1.25
            self.view.layoutIfNeeded()
            
        }
    }
    
    @IBAction func hideSidemenuBtn(_ sender: Any) {
        tabBarController?.tabBar.isHidden = false
        UIView.animate(withDuration: 0.2 ){
            self.blureViewsideMenuConstrain.constant = 0
            self.view.layoutIfNeeded()
        }
        
        UIView.animate(withDuration: 0.4 ){
            
            self.sidemenuCoistrain.constant = 0
            self.view.layoutIfNeeded()
            
        }
    }
    
    
    @IBAction func cartBtn(_ sender: Any) {
        tabBarNavigation(pageindex: 2)
    }
    
    
    @IBAction func speechBtn(_ sender: Any) {
        
    }
    
    //MARK: - Side Menu
    
    @IBAction func accountInfoBtn(_ sender: Any) {
    }
    
    @IBAction func passwordSettingsBtn(_ sender: Any) {
        
    }
    @IBAction func ordersBtn(_ sender: Any) {
        
    }
    
    @IBAction func myCardsBtn(_ sender: Any) {
        
    }
    @IBAction func wishListBtn(_ sender: Any) {
        
    }
    @IBAction func settengsBtn(_ sender: Any) {
        
    }
    @IBAction func logoutBtn(_ sender: Any) {
        //        let loginManager = LoginManager()
        //           loginManager.logOut()
        //           do {
        //               try Auth.auth().signOut()
        //
        //               print("User Loged Out")
        //
        //           } catch let signOutError as NSError {
        //               print("Error signing out: %@", signOutError)
        //           }
        //
        //        self.dismiss(animated: false)
        
        UserDefaults.standard.set(nil, forKey: "userToken")
        profileApi.LogoutfromDataBase()
    }
}





extension HomeVC : UICollectionViewDelegate , UICollectionViewDelegateFlowLayout , UICollectionViewDataSource , HomeApiDelegate , CellSubclassProductDelegate , WishlistApiDelegate {
    func isDone(message: String) {
        showALert(message: message)
    }
    
    func isFail(message: String) {
        showALert(message: message)
    }
    
    func buttonTapped(cell: allProductsCollectioViewCell) {
        guard let indexPath = self.newArraivalCollectionView.indexPath(for: cell) else { return }
        
        wishlistApi.addproductToFavoriets(id: newArrivalArray[indexPath.row].id!)
        
        
        if cell.favBtn.tintColor == .lightGray {
            cell.favBtn.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            cell.favBtn.tintColor = .red
        }else{
            cell.favBtn.setImage(UIImage(systemName: "heart"), for: .normal)
            cell.favBtn.tintColor = .lightGray
            
        }
        
        
        print("Button tapped on row \(indexPath.row)")
        
    }
    
    
    func logoutIsDone(massage: String) {
        showAlertLogOut(massege: massage)
    }
    func logoutIsFail(massage: String) {
        showAlertLogOut(massege: massage)
    }
    func profireDataIsDone(Data: DataClass) {
        setUpUIwithData(with: Data)
    }
    func profileDataIsFail(masssage: String) {
        showALert(message: masssage)
    }
    
    
    //MARK: - CollectionView
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case categoriesCollectionView:
            return categoriesArray.count
        default:
            return newArrivalArray.count
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        switch collectionView{
        case categoriesCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: categoriesCollectionVieCell.ID, for: indexPath) as! categoriesCollectionVieCell
            cell.categoryName.text = categoriesArray[indexPath.row].name
            cell.categoryImage.kf.setImage(with: URL(string: categoriesArray[indexPath.row].image!), placeholder:  UIImage(named: "Logo")?.withTintColor(UIColor(named: "BackGrpundColor")!))
            return cell
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: allProductsCollectioViewCell.ID, for: indexPath) as! allProductsCollectioViewCell
            cell.delegate = self
            cell.favBtn.tintColor = .lightGray
             
            if newArrivalArray[indexPath.row].in_favorites! {
                cell.favBtn.setImage(UIImage(systemName:  "heart.fill"), for: .normal)
                cell.favBtn.tintColor = .red
            }else{
                cell.favBtn.setImage(UIImage(systemName:  "heart"), for: .normal)
                cell.favBtn.tintColor = .lightGray
            }
            
            cell.productPrice.text = "\(newArrivalArray[indexPath.row].price!)"
            cell.productName.text = newArrivalArray[indexPath.row].name
            cell.productImage.kf.setImage(with: URL(string: newArrivalArray[indexPath.row].image!),placeholder: UIImage(named: "Logo")?.withTintColor(UIColor(named: "BackGrpundColor")!))
            return cell
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch collectionView {
        case categoriesCollectionView:
            return CGSize(width: categoriesCollectionView.bounds.width / 3, height: categoriesCollectionView.bounds.height )
        default:
            return CGSize(width: newArraivalCollectionView.bounds.width / 2 - 15, height: 260 )
        }
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch collectionView {
        case categoriesCollectionView:
            let vc = storyboard?.instantiateViewController(identifier: CategoriesDetailsVC.ID) as! CategoriesDetailsVC
            vc.categoryTitle = categoriesArray[indexPath.row].name!
            vc.id = categoriesArray[indexPath.row].id
            vc.modalTransitionStyle = .crossDissolve
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true)
        default:
            let vc = storyboard?.instantiateViewController(withIdentifier: ProductDetailVC.ID) as! ProductDetailVC
            vc.id = newArrivalArray[indexPath.row].id
            vc.productinCart = newArrivalArray[indexPath.row].in_cart
            vc.modalTransitionStyle = .crossDissolve
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true)
        }
    }
    
    
}
