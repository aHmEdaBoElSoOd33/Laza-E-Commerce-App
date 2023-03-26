//
//  OrderDetailsVC.swift
//  LazaApp
//
//  Created by Ahmed on 26/03/2023.
//

import UIKit

class OrderDetailsVC: UIViewController {
    
    //MARK: - IBOutlets
    
    @IBOutlet weak var productsCollectionView: UICollectionView!
    @IBOutlet weak var cityLbl: UILabel!
    @IBOutlet weak var totalcostLbl: UILabel!
    @IBOutlet weak var feeLbl: UILabel!
    @IBOutlet weak var costLbl: UILabel!
    @IBOutlet weak var regionLbl: UILabel!
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var paymentMethodLbl: UILabel!
    
    
    
    static let ID = String(describing: OrderDetailsVC.self)
    var id : Int?
    var orderApi = OrdersApi()
    var productArray : [OrderDetailsProductModelData] = []
    var indicatorView : UIActivityIndicatorView?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        uisetUp()
        getOrderDetailDataFromApi(id: id!)
    }
    
 //MARK: - Functions
    
    func uisetUp(){
        indicatorView = activityIndicator(style: .large ,  center: self.view.center)
        self.view.addSubview(indicatorView!)
        indicatorView?.startAnimating()
        view.isUserInteractionEnabled = false
        productsCollectionView.delegate = self
        productsCollectionView.dataSource = self
        setupCell(collectionView: productsCollectionView, ID: cartCollectionViewCell.ID)
        orderApi.cancelDelegate = self
    }
    
    
    func getOrderDetailDataFromApi(id:Int){
        
        orderApi.getOrderDetails(id: id) { allData , productData in
            self.productArray = productData
            self.productsCollectionView.reloadData()
            self.cityLbl.text = allData.address?.city
            self.regionLbl.text = allData.address?.region
            self.paymentMethodLbl.text = allData.payment_method
            self.dateLbl.text = allData.date
            self.costLbl.text = "\(Float(allData.cost!))"
            self.feeLbl.text = "\(Float(allData.vat!))"
            self.totalcostLbl.text = "\(Float(allData.total!))"
            self.indicatorView?.stopAnimating()
            self.view.isUserInteractionEnabled = true
        }
    }
    
    
    
    
    
    @IBAction func cancelOrder(_ sender: Any) {
        orderApi.cancelOrder(id: id!)
    }
    
    
    @IBAction func backBtn(_ sender: Any) {
        dismiss(animated: true)
    }
    
     
    
}


extension OrderDetailsVC : UICollectionViewDelegate , UICollectionViewDataSource, UICollectionViewDelegateFlowLayout , CancelOrderDelegate {
    func CancelOrderIsDone(message: String) {
        showALert(message: message)
    }
    
    func CancelOrderIsFail(message: String) {
        showALert(message: message)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return productArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cartCollectionViewCell.ID, for: indexPath) as! cartCollectionViewCell
        
        
        cell.layer.shadowColor = UIColor.black.cgColor
        cell.layer.shadowOpacity = 0.1
        cell.layer.shadowOffset = CGSize(width: 0, height: 5)
        cell.layer.shadowRadius = 5
        
        
        cell.increaseQuantityBtn.isHidden = true
        cell.decreaseQuantityBtn.isHidden = true
        cell.deleteBtn.isHidden = true
        
        cell.productImage.kf.setImage(with: URL(string: productArray[indexPath.row].image!))
        cell.productName.text = productArray[indexPath.row].name
        cell.productPrice.text = "\(productArray[indexPath.row].price!)"
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: collectionView.bounds.height)
    }
    
    
    
    
    
}
