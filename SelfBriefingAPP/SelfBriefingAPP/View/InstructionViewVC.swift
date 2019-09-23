//
//  InstructionViewVC.swift
//  SelfBriefingAPP
//
//  Created by AliSons  on 17/08/2019.
//  Copyright © 2019 AliSons . All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import PDFReader
import SVProgressHUD
class InstructionViewVC: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource {
    
    @IBOutlet weak var Viewer: UICollectionView!
    @IBOutlet weak var Details: UILabel!
    @IBOutlet weak var IssuedTo: UILabel!
    var PdfDoc: PDFDocument?
    @IBOutlet weak var FilesAttached: UILabel!
    @IBOutlet weak var PublishDate: UILabel!
    //var Files:JSON?;
    @IBOutlet weak var ExpiryDate: UILabel!
    var FilesArray: [String] = [];
    @IBOutlet weak var DocTitle: UILabel!
    @IBOutlet weak var InstructionType: UILabel!
    @IBOutlet weak var DocumentNumber: UILabel!
    @IBOutlet weak var DocTitleLabel: UILabel!
    var DocumentTitle = ""
    var DocumentID = ""
    var InstructionData = [[String: AnyObject]]()
    
    
override func viewDidLoad() {
        super.viewDidLoad()

    
        DocTitleLabel.text = DocumentTitle;
        Details.text = InstructionData[0]["details"] as? String
        DocTitle.text = InstructionData[0]["title"] as? String
        IssuedTo.text = InstructionData[0]["issue_to"] as? String
        DocumentNumber.text = InstructionData[0]["document_number"] as? String
        InstructionType.text = InstructionData[0]["instruction_type"] as? String
        ExpiryDate.text = InstructionData[0]["expiry_date"] as? String
        FilesArray = cvertofilearray(Files: InstructionData[0]["files"] as! String)
    
        // Do any additional setup after loading the view.
        Viewer.dataSource = self;
        Viewer.delegate = self;

}
    
@IBAction func Marked(_ sender: Any) {
    if printed() == "success"{
        print("ds");
    }

    
_ = navigationController?.popViewController(animated: true)
}
    

@IBAction func Logout(_ sender: Any) {
     self.dismiss(animated: true, completion:nil)
}
    
    
func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

    return FilesArray.count
    
}
    
    
func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "pdfCell", for: indexPath) as! pdfCell
    let pdf_name = FilesArray[indexPath.row]
    cell.pdfname.text = pdf_name
    return cell

    }
    
    
    
func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    SettingPdf(Indx:indexPath.item)

    }
    
    
// MARK: - (4) setting files and error handling as well

func SettingPdf(Indx : Int){

        SVProgressHUD.show(withStatus: "Loading");
        DispatchQueue.global(qos: .background).async {
            
            //uses function at Mark(1)
            self.fetchingPDF(Index:Indx)
            DispatchQueue.main.async(execute: {() -> Void in
                if self.PdfDoc != nil{
                    //When File is legit then pushes the pdfviewer
                    SVProgressHUD.dismiss();
                    let readerController = PDFViewController.createNew(with: self.PdfDoc!)
                    self.navigationController?.pushViewController(readerController, animated: true)
                }else
                {
                    //if the file has error then show error
                    SVProgressHUD.dismiss();
                    SVProgressHUD.showError(withStatus: "Error Downloading PDF")
                }
            })
        }
    }
    
    
// MARK: - (1) Fetching PDF from the server
//fetching PDF from the server
func fetchingPDF(Index : Int ){
    let remotePDFDocumentURL = URL(string: FileServerPath+"anime.pdf")!
    PdfDoc = PDFDocument(url: remotePDFDocumentURL)
    
    }
    

//Mark: - (2) takes the string in the file and converts to FileArray
func cvertofilearray(Files : String ) -> [String]{
    
    //setting Variable to perform functions
    var files = Files
    let file2Array: [String]? ;
    
    //Mark :- (3) changing the scope of the of given file to change it into an array
    files = Files.replacingOccurrences(of: "[", with: "", options: NSString.CompareOptions.literal, range: nil)
    files = Files.replacingOccurrences(of: "]", with: "", options: NSString.CompareOptions.literal, range: nil)
    files = Files.replacingOccurrences(of: "\"", with: "", options: NSString.CompareOptions.literal, range: nil)
    file2Array = files.components(separatedBy: ",")
    return file2Array!

    }
    
    
//Mark: - (5) setting the values for the instructions as marked
func printed() -> String{
    
    let UrlExt = String(InstructionData[0]["id"]! as! Int);
    let  Url = URL(string: API_URL2+MARKEDASREAD_API+UrlExt)
    
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
            print(response);
            if ((response.result.value) != nil) {
                let jsondata = JSON(response.result.value!)
            }
    }
    return "success";
    
}
}
