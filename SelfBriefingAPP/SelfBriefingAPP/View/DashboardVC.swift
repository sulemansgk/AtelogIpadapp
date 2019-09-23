//
//  File.swift
//  
//
//  Created by AliSons  on 15/08/2019.
//
import UIKit
import SwiftyJSON
import Alamofire
import Foundation
class DashboardVC: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource{


    @IBOutlet weak var Act: UIActivityIndicatorView!
    @IBOutlet weak var DateTime: UILabel!
   
    var date = Date();
   // var test = Testing();
    var data1 = [[String: AnyObject]]()
     var PassingData = [[String: AnyObject]]()
    @IBOutlet weak var DismissedButton: UIButton!
     var passingDataName = ""
    var passingDataID = "";

    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        let transform = CGAffineTransform(scaleX: 2.5, y: 2.5)
        Act.transform = transform
        Act.startAnimating()
        Act.isHidden = false
     
        if let Uname = UserInfo?.Apikey(){
           print(Uname);
        }
       
        
        super.viewDidLoad()

        collectionView.dataSource = self;
        collectionView.delegate = self;
        self.DATA()
        //Mark :- Layout Designing here for UICollection view Cell
        var Layout = self.collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        Layout.sectionInset = UIEdgeInsets(top: 10,left: 15,bottom: 30,right: 15);
        Layout.minimumInteritemSpacing = 10
    }

    func DATA(){
        let credentialData = "\(API_USERNAME):\(API_PASSWORD)".data(using: String.Encoding.utf8)!
        let base64Credentials = credentialData.base64EncodedString(options: [])
        let headers = ["Authorization": "Basic \(base64Credentials)",
            "X-API-KEY": UserInfo?.Apikey() ?? "",
            "Content-Type": "application/x-www-form-urlencoded",]
        
        let  Url = URL(string: API_URL2+INSTRUCTION_API)
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
                    self.collectionView?.reloadData()
                    self.Act.stopAnimating()
                    self.Act.isHidden = true
                }
            }
        }
    }

    
func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    
       return data1.count
        
    }
    
func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CollectionViewCell
    let iP = data1[indexPath.row]
  
        cell.Name.text = iP["name"] as? String
  
    
    
    //mark:- Cell layout Design
    cell.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    cell.layer.borderWidth = 2
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)  as! CollectionViewCell
        cell.Name.backgroundColor = #colorLiteral(red: 0.1055288091, green: 0.1288690567, blue: 0.4892658591, alpha: 0.9410851884)
        cell.Name.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    }
    
    // change background color back when user releases touch
    func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)  as! CollectionViewCell
        cell.Name.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
        cell.Name.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       
        PassingData = [data1[indexPath.item]]
        performSegue(withIdentifier: "InstuctionVC", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    
     var VC = segue.destination as! InstructionDocC
        VC.PassedData = PassingData;
    }
    
    
    
    @IBAction func Logout(_ sender: Any) {

        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func SpecialEntries(_ sender: Any) {
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "SpecialVC") as! SpecialVC
        
                self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
