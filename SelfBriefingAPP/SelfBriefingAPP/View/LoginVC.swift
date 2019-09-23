//
//  ViewController.swift
//  
//
//  Created by AliSons  on 15/08/2019.
//

import UIKit
import Alamofire
import SwiftyJSON
class LoginVC: UIViewController {
        
    @IBOutlet weak var CredentialsError: UITextField!
    @IBOutlet weak var UserName: UITextField!
 
    var trd : LoginUserData?
    @IBAction func SettingUsernameVal(_ sender: Any) {
        self.ToggleError(Toggle: true)
        UserName.text = ""
    }
    
    @IBOutlet weak var SiginActivity: UIActivityIndicatorView!
    @IBOutlet weak var Signing: UIButton!
    
    @IBOutlet weak var Password: UITextField!
    
    @IBAction func SettingPasswordVal(_ sender: Any) {
           self.ToggleError(Toggle: true)
            Password.text = ""
    }
    
    
    @IBAction func SignIn(_ sender: Any) {
        
        //MARK:- Signin Process Initiating
        SiginActivity.isHidden = false
        SiginActivity.startAnimating()
        Autenciation(Usernames: UserName?.text ?? "nil", Passwords: Password?.text ?? "nil")
       
    }
    
    @IBOutlet weak var DismissedButton: UIButton!
    
    
    override func viewDidLoad() {
            super.viewDidLoad()
        
            SiginActivity.isHidden = true ;
            self.ToggleError(Toggle: true)
        }
    
    
    
        override func viewWillAppear(_ animated: Bool) {
            // Sets the status bar to hidden when the view has finished appearing
            
            let statusBar: UIView = UIApplication.shared.value(forKey: "statusBar") as! UIView
            statusBar.isHidden = true
        }
        
        override func viewWillDisappear(_ animated: Bool) {
            // Sets the status bar to visible when the view is about to disappear
            let statusBar: UIView = UIApplication.shared.value(forKey: "statusBar") as! UIView
            statusBar.isHidden = false
        }
        @IBAction func DismissedButton(_ sender: Any) {
            self.dismiss(animated: false, completion: nil)
        }
    
    func Autenciation(Usernames:String, Passwords:String) -> String {
        
        
        let credentialData = "\(API_USERNAME):\(API_PASSWORD)".data(using: String.Encoding.utf8)!
        let base64Credentials = credentialData.base64EncodedString(options: [])
        let headers = ["Authorization": "Basic \(base64Credentials)",
            "X-API-KEY": X_API_KEY ,
            "Content-Type": "application/x-www-form-urlencoded",]
        let parameters = [
            "agentname": Usernames as String,
            "agentpassword": Passwords as String
        ]
        
        Alamofire.request(API_URL2+LOGIN_API,
                          method: .post,
                          parameters: parameters,
                          encoding: URLEncoding.default,
                          headers:headers)
            .validate()
            .responseJSON { response in
                if response.result.value != nil{
                    
                let jsondata = JSON(response.result.value!)
                UserInfo = UserInformation(json: jsondata)
                 self.ToggleError(Toggle: true)
                 self.performSegue(withIdentifier: "LoggedIn", sender: nil)
                    
                }else{
                    self.ToggleError(Toggle: false)
                }
          
                self.SiginActivity.isHidden = true
                self.SiginActivity.stopAnimating()
        }
        

        return Usernames;
    }
    func ToggleError(Toggle : Bool){
        if Toggle {
             CredentialsError.layer.isHidden = true
        }else{
             CredentialsError.layer.isHidden = false
        }
    }
}

