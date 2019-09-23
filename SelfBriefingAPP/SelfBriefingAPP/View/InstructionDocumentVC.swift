//
//  ViewController.swift
//  SelfBriefingAPP
//
//  Created by AliSons  on 16/08/2019.
//  Copyright © 2019 AliSons . All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire
class InstructionDocC: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource {
    @IBOutlet weak var DocumentName: UILabel!
    var DocumentID = 0
    
    var DocumentTitle = ""
    var PassedData = [[String: AnyObject]]()
    var data1 = [[String: AnyObject]]()
    var mine = [[String: AnyObject]]()
    var DocmentID = ""
    @IBOutlet weak var DocumentIntruction: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()

      
        DocumentName.text = PassedData[0]["name"] as? String
        DocumentIntruction.dataSource = self;
        DocumentIntruction.delegate = self;
     
        
        self.DATA()
        
    }
    
    @IBAction func Logout(_ sender: Any) {
    self.dismiss(animated: true, completion: nil)
    }
    func DATA(){
        
        let UrlExt = String(self.PassedData[0]["id"]! as! Int);
        let  Url = URL(string: API_URL2+INSTRUCTION_GETBYID_API+UrlExt)
        let credentialData = "\(API_USERNAME):\(API_PASSWORD)".data(using: String.Encoding.utf8)!
        let base64Credentials = credentialData.base64EncodedString(options: [])
        let headers = ["Authorization": "Basic \(base64Credentials)",
            "X-API-KEY": UserInfo?.Apikey() ?? "",
            "Content-Type": "application/x-www-form-urlencoded",]
        
        
        Alamofire.request( Url!,
                           method: .get,
                           encoding: URLEncoding.default,
                           headers:headers
                          ).validate().responseJSON { (response) in
            if ((response.result.value) != nil) {
                let jsondata = JSON(response.result.value!)
          
                if let da = jsondata["data"].arrayObject
                {
                    self.data1 = da as! [[String : AnyObject]]
                }
                if self.data1.count > 0 {
                   self.DocumentIntruction?.reloadData()
                }
            }
        }
        
        
        
        
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return data1.count
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = DocumentIntruction.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! InstructionFileCell
        let iP = data1[indexPath.row]
        cell.InstrucTitle.text = iP["title"] as? String
        cell.InstructionDesc.text = iP["details"] as? String
        cell.Datetime.text = iP["expiry_date"] as? String
        cell.Flag.backgroundColor = hexStringToUIColor(hex: iP["ColorCode"] as? String ?? "#d3d3d3")
      
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        mine = [data1[indexPath.item]]
        DocmentID = mine[0]["id"] as? String ?? ""
        DocumentTitle = mine[0]["title"] as? String ?? ""
      performSegue(withIdentifier: "InstructionView", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        var VC = segue.destination as! InstructionViewVC
        VC.DocumentTitle = DocumentTitle
        VC.DocumentID = DocmentID
        VC.InstructionData = mine 
    }

    func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}
