//
//  UserModel.swift
//  SelfBriefingAPP
//
//  Created by AliSons  on 19/08/2019.
//  Copyright © 2019 AliSons . All rights reserved.
//
import UIKit
import SwiftyJSON
import Alamofire
class UserInformation: NSObject {

    var agentcode : String?;
    var agentname : String?;
    var comments : String?;
    var agentrole : String?;
    var agentpassword : String?;
    var agentactive : String?;
    var agentenabled : String?;
    var exten : String?;
    var projectid : String?;
    var agentip : String?;
    var lastcall : String?;
    var firstname : String?;
    var lastname : String?;
    var dob : String?;
    var nationality : String?;
    var designation : String?;
    var company : String?;
    var phone1 : String?;
    var phone2 : String?;
    var mobile : String?;
    var email : String?;
    var address1 : String?;
    var address2 : String?;
    var last_access : String?;
    var cdate : String?;
    var image : String?;
    var agentunit : String?;
    var API_KEY : String?;
    var API_KEY_ID : String?;
    
    func fullName() -> String{
        return (self.firstname ?? "") + " " + (self.lastname ?? "")
    }
    func Apikey() -> String{
        return self.API_KEY ?? ""
    }
    
    init(json:JSON) {
        super.init()
        self.agentcode = json["data"]["agentcode"].string
        self.agentname = json["data"]["agentname"].string
        self.comments = json["data"]["comments"].string
        self.agentrole = json["data"]["agentrole"].string
        self.agentpassword = json["data"]["agentpassword"].string
        self.agentactive = json["data"]["agentactive"].string
        self.agentenabled = json["data"]["agentenabled"].string
        self.lastname = json["data"]["lastname"].string
        self.exten = json["data"]["exten"].string
        self.projectid = json["data"]["projectid"].string
        self.agentip = json["data"]["agentip"].string
        self.lastcall = json["data"]["lastcall"].string
        self.firstname = json["data"]["firstname"].string
        self.dob = json["data"]["dob"].string
        self.nationality = json["data"]["nationality"].string
        self.designation = json["data"]["designation"].string
        self.company = json["data"]["company"].string
        self.phone1 = json["data"]["phone1"].string
        self.phone2 = json["data"]["phone2"].string
        self.mobile = json["data"]["mobile"].string
        self.email = json["data"]["email"].string
        self.address1 = json["data"]["address1"].string
        self.address2 = json["data"]["address2"].string
        self.last_access = json["data"]["last_access"].string
        self.cdate = json["data"]["cdate"].string
        self.image = json["data"]["image"].string
        self.agentunit = json["data"]["agentunit"].string
        self.API_KEY = json["APIKEY"]["key"].string
        self.API_KEY_ID = json["APIKEY"]["id"].string
    }
}

    

