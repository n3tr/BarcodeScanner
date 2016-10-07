//
//  PrepareRegistrationData.swift
//  BarcodeScanner
//
//  Created by Jirat Ki. on 10/6/2559 BE.
//  Copyright © 2559 n3tr. All rights reserved.
//

import Foundation


enum IDCardType: String {
    case IDCard = "บัตรประชน"
    case Passport = "หนังสือเดินทาง"
}


class PrepareRegistrationData: NSObject {
    
    var code: String?
    var codeImage: UIImage?
    var cardImage: UIImage?
    var phoneNumber: String?
    var idNo: String?
    var cardType: IDCardType = .IDCard
    
}