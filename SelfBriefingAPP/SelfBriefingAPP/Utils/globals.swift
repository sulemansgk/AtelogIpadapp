//
//  File.swift
//  SelfBriefingAPP
//
//  Created by AliSons  on 20/08/2019.
//  Copyright © 2019 AliSons . All rights reserved.
//
var UserInfo : UserInformation?
let credentialData = "\(API_USERNAME):\(API_PASSWORD)".data(using: String.Encoding.utf8)!
let base64Credentials = credentialData.base64EncodedString(options: [])
