//
//  LoginUserData.swift
//  VintageLimo
//
//  Created by Admin on 27/04/2018.
//  Copyright © 2018 Admin. All rights reserved.
//

import UIKit
import SwiftyJSON

class LoginUserData: NSObject {
    
    
    
    var full_name : String?;
    var first_name : String?;
    var last_name : String?;
    var email : String?;
    var user_id : String?;
    var user_type : String?;
    var fcm_id : String?;
    var cognito_id : String?;
    var cognito_token : String?;
    var currentLocation : CurrentLocation?
    struct CurrentLocation {
        let lat : String?;
        let lng : String?;
        init(json:JSON) {
            self.lat = json["lng"].string ?? "N/A"
            self.lng = json["lng"].string ?? "N/A"
        }
    }
    
    
    init(json:JSON) {
        super.init()
        self.full_name = json["full_name"].string;
        self.first_name = json["first_name"].string;
        self.last_name = json["last_name"].string;
        self.email = json["email"].string;
        self.user_id = json["_id"].string;
        self.user_type = json["user_type"].string;
        self.fcm_id = json["fcm_id"].string;
        self.currentLocation = CurrentLocation(json: json["current_location"])
        self.cognito_id = json["cognito_id"].string;
        
    }
}
