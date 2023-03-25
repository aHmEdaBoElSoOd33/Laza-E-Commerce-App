//
//  WalletsVC.swift
//  LazaApp
//
//  Created by Ahmed on 18/03/2023.
//

import UIKit

class ProfileVC: UIViewController{

 
    //MARK: - IBOutlets
    
    @IBOutlet weak var profileImageFrame: UIView! 
    @IBOutlet weak var phoneTxtField: UITextField!
    @IBOutlet weak var userNameTxtField: UITextField!
    @IBOutlet weak var emailTxtField: UITextField!
    @IBOutlet weak var userProfileImage: UIImageView!
    
    
    //MARK: - Variables
    
    static let ID = String(describing: ProfileVC.self)
    let profileApi = HomeApi()
    var indicatorView : UIActivityIndicatorView?
    
    
    override func viewDidLoad() {
        super.viewDidLoad() 
    }
    
    override func viewWillAppear(_ animated: Bool) {
        uiSetUp()
    }
    
    
    
    
    //MARK: - Functions
    
    
    func uiSetUp(){
        indicatorView = self.activityIndicator(style: .large , center: self.view.center)
        self.view.addSubview(indicatorView!)
        indicatorView?.startAnimating()
        self.view.isUserInteractionEnabled = false
        profileImageFrame.layer.borderColor = UIColor(named: "BackGrpundColor")?.cgColor
        profileImageFrame.layer.borderWidth = 4
        profileImageFrame.layer.cornerRadius = profileImageFrame.bounds.height / 2
        userProfileImage.layer.cornerRadius = userProfileImage.bounds.height / 2
        profileApi.delegate = self
        profileApi.getUserProfileData() 
    }
    
    
    //MARK: - IBActions
    
    @IBAction func logOutBtn(_ sender: Any) {
        
        UserDefaults.standard.set(nil, forKey: "userToken")
        profileApi.LogoutfromDataBase()
        
    }
    
    
}



extension ProfileVC : HomeApiDelegate {
    func profireDataIsDone(Data: DataClass) {
        userProfileImage.kf.setImage(with: URL(string: Data.image!))
        userNameTxtField.text = Data.name
        emailTxtField.text = Data.email
        phoneTxtField.text = Data.phone
        indicatorView?.stopAnimating()
        self.view.isUserInteractionEnabled = true
    }
    
    func profileDataIsFail(masssage: String) {
        showALert(message: masssage)
    }
    
    func logoutIsDone(massage: String) {
        showAlertLogOut(massege: massage)
    }
    
    func logoutIsFail(massage: String) {
        showALert(message: massage)
    }
    
}
