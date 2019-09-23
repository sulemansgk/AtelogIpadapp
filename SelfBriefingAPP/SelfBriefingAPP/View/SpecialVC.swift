//
//  SpecialVC.swift
//  SelfBriefingAPP
//
//  Created by AliSons  on 23/08/2019.
//  Copyright © 2019 AliSons . All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire
import Foundation
import SVProgressHUD
class SpecialVC: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource {


    @IBOutlet weak var Special_entriesCollection: UICollectionView!
    
    var SpecialEntries = [[String: AnyObject]]()
    var PassingData = [[String: AnyObject]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()


        // Do any additional setup after loading the view.
    Special_entriesCollection.dataSource = self
    Special_entriesCollection.delegate = self
        
        
        
    SVProgressHUD.show(withStatus: "Loading");
        DispatchQueue.global(qos: .background).async {
            self.FetchSepcialEntries();
            DispatchQueue.main.async(execute: {() -> Void in
                    SVProgressHUD.dismiss();
            })
        }
        
      
    }
    
    func FetchSepcialEntries(){
        let credentialData = "\(API_USERNAME):\(API_PASSWORD)".data(using: String.Encoding.utf8)!
        let base64Credentials = credentialData.base64EncodedString(options: [])
        let headers = ["Authorization": "Basic \(base64Credentials)",
            "X-API-KEY": UserInfo?.Apikey() ?? "",
            "Content-Type": "application/x-www-form-urlencoded",]
        
        let  Url = URL(string: API_URL2+SPECIALENTRIES_GETALL_API)
        Alamofire.request( Url!,
                           method: .get,
                           encoding: URLEncoding.default,
                           headers:headers
            ).validate().responseJSON { (response) in
                if ((response.result.value) != nil) {
                    let jsondata = JSON(response.result.value!)
                    
                    if let da = jsondata["data"].arrayObject
                    {
                        self.SpecialEntries = da as! [[String : AnyObject]]
                    }
                    if self.SpecialEntries.count > 0 {
                        self.Special_entriesCollection?.reloadData()
                
                    }
                }
        }
    }
    

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       return SpecialEntries.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SpecialEntries", for: indexPath) as! SpecialEntriesCellC
        let SpecialEntry = SpecialEntries[indexPath.row]
        print(SpecialEntry);
        cell.DateAndTime.text = SpecialEntry["datetime"] as? String ?? "Not Defined"
        cell.Description.text = SpecialEntry["description"] as? String ?? "Not Defined"
        cell.Title.text = SpecialEntry["subject"] as? String ?? "Not Defined"
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        PassingData = [SpecialEntries[indexPath.item]]
        performSegue(withIdentifier: "SpecialEntriesFormVC", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        var VC = segue.destination as! SpecialEntriesFormVC
        VC.PassedData = PassingData;
    }
    
    
    
    
}
