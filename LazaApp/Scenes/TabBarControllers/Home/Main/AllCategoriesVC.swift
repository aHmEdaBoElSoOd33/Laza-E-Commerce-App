//
//  AllCategoriesVC.swift
//  LazaApp
//
//  Created by Ahmed on 20/03/2023.
//

import UIKit

class AllCategoriesVC: UIViewController {

    
    //MARK: -  IBOutlets
    
    @IBOutlet weak var categoriesCollectionView: UICollectionView!
    
    //MARK: - Variables
    
    static let ID = String(describing: AllCategoriesVC.self)
    var categoriesApi = CategoriesApi()
    var categriesArray : [Datum] = []
    var indicatorView : UIActivityIndicatorView?
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        uiSetUp()
        getCategoriesDataFromApi()
        
    }
    
    //MARK: - Functions
    
    func getCategoriesDataFromApi(){
         
        categoriesApi.getCategories { data,error  in
            self.indicatorView?.stopAnimating()
            self.view.isUserInteractionEnabled = true
           
            if let data = data{
                self.categriesArray = data
                self.categoriesCollectionView.reloadData()
           
            }else if let error = error {
                self.showALert(message: error.localizedDescription)
            }
            
            
        }
    }
    
    
    
    func uiSetUp(){
        self.view.isUserInteractionEnabled = false
        indicatorView = self.activityIndicator(style: .large,
                                                       center: self.view.center)
        self.view.addSubview(indicatorView!)
         
        indicatorView!.startAnimating()
        categoriesCollectionView.dataSource = self
        categoriesCollectionView.delegate = self
    }
    
    
    //MARK: - IBActions
    
    @IBAction func backBtn(_ sender: Any) {
        
        dismiss(animated:true)
        
    }
    
    
    
}


//MARK: -  Collection View SetUp
 
extension AllCategoriesVC : UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categriesArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ShowAllCateroriesCollectionViewCell.ID, for: indexPath) as! ShowAllCateroriesCollectionViewCell
        
        cell.categoryImage.kf.setImage(with: URL(string: categriesArray[indexPath.row].image!), placeholder:  UIImage(named: "Logo")?.withTintColor(UIColor(named: "BackGrpundColor")!))
        cell.categoryNameLbl.text = categriesArray[indexPath.row].name
        return cell
    }
     
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height / 6 - 5)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let vc = storyboard?.instantiateViewController(identifier: CategoriesDetailsVC.ID) as! CategoriesDetailsVC
        vc.categoryTitle = categriesArray[indexPath.row].name!
        vc.id = categriesArray[indexPath.row].id 
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
        
    }
     
    
}
