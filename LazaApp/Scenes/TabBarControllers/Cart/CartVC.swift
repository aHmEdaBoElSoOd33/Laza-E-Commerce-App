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
    var addressArray : [AddressDetailsData] = []
    var indicatorView : UIActivityIndicatorView?
    var addressApi  = AddressApi()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        uiSetUp()
        getCartDataFromApi()
        getAddressDatFromApi()
        cartApi.delegate = self
    }
    
    //MARK: - Functions
    
    func uiSetUp(){
        indicatorView = self.activityIndicator(style: .large,
                                               center: self.view.center)
        self.view.addSubview(indicatorView!)
        cartCollectionView.delegate = self
        cartCollectionView.dataSource = self
        addressCollectionView.dataSource = self
        addressCollectionView.delegate = self
        setupCell(collectionView: cartCollectionView, ID: cartCollectionViewCell.ID)
        setupCell(collectionView: addressCollectionView, ID: addressCollectionViewCell.ID)
        
        self.view.isUserInteractionEnabled = false
        self.indicatorView!.startAnimating()
    }
    
    
    func getCartDataFromApi(){
        cartApi.getCartProducts { data,subdata  in
            self.cartArray = data!
            self.subtotalCostLbl.text = "\((subdata?.sub_total)!)$"
            self.shippingCostLbl.text = "10$"
            self.totalCostLbl.text = "\((subdata?.total)! + 10)$"
            self.cartCollectionView.reloadData()
            self.view.isUserInteractionEnabled = true
            self.indicatorView!.stopAnimating()
        }
    }
    
    
    func getAddressDatFromApi(){
        addressApi.getAddressData { data in
            self.addressArray = data
            self.addressCollectionView.reloadData()
        }
    }
    
    //MARK: - IBActions
    
    @IBAction func backBtn(_ sender: Any) {
        tabBarNavigation(pageindex: 0)
    }
    
    
    @IBAction func addAddressBtn(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: AddressVC.ID) as! AddressVC
        vc.state = "add"
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
    
}




extension CartVC : UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout , CellSubclassCartDelegate, CartApiDelegate{
    func isDone(message: String) {
        showALert(message: message)
        uiSetUp()
        getCartDataFromApi()
    }
    
    func isFail(message: String) {
        showALert(message: message)
        uiSetUp()
        getCartDataFromApi()
    }
    
    func buttonTapped(cell: cartCollectionViewCell) {
        guard let indexPath = self.cartCollectionView.indexPath(for: cell) else { return }
        
        cartApi.addOrRemoveproductFromCart(id: (cartArray[indexPath.row].product?.id)!)
        
        print("Tapped")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView{
        case cartCollectionView:
            return cartArray.count
        default:
            return addressArray.count
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
            
            cell.delegate = self
            cell.productName.text = cartArray[indexPath.row].product?.name
            cell.productImage.kf.setImage(with: URL(string: (cartArray[indexPath.row].product?.image)!))
            cell.productPrice.text = "\((cartArray[indexPath.row].product?.price!)!)"
            return cell
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: addressCollectionViewCell.ID, for: indexPath) as! addressCollectionViewCell
            
            cell.AddressNameLbl.text = addressArray[indexPath.row].name! + "," + addressArray[indexPath.row].city!
            cell.countryLbl.text = addressArray[indexPath.row].region
            return cell
        }
        
        
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch collectionView{
        case cartCollectionView:
            return CGSize(width: collectionView.bounds.width - 10, height: collectionView.bounds.height / 2 - 10 )
        
        case addressCollectionView:
            return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
        default:
            return .zero
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
        case addressCollectionView:
            let vc = storyboard?.instantiateViewController(withIdentifier: AddressVC.ID) as! AddressVC
            vc.state = "update"
            vc.modalTransitionStyle = .crossDissolve
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true)
        default:
            break
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        var numOfSections: Int = 0
        
        switch collectionView{
        case cartCollectionView:
            if cartArray.count != 0
            {
                //collectionView.separatorStyle = .singleLine
                numOfSections            = 1
                collectionView.backgroundView = nil
            }
            else
            {
                
                let noDataLabel: UILabel  = UILabel(frame: CGRect(x: 0, y: 0, width: collectionView.bounds.size.width, height: collectionView.bounds.size.height))
                noDataLabel.text = "No items in cart yet"
                noDataLabel.font = .boldSystemFont(ofSize: 20)
                noDataLabel.textColor     = UIColor.lightGray
                noDataLabel.textAlignment = .center
                collectionView.backgroundView  = noDataLabel
                //collectionView.separatorStyle  = .none
            }
            return numOfSections
        default:
            return 1
        }
        
    }
    
}
