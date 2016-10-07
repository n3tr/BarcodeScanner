//
//  ViewController.swift
//  BarcodeScanner
//
//  Created by Jirat Ki. on 10/3/2559 BE.
//  Copyright © 2559 n3tr. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func showScannerView(sender: AnyObject) {
        // Main Flow : Show Scanner
//        let scanner = ScannerViewController()
//        self.navigationController?.pushViewController(scanner, animated: true)
        
        // ----------
        // For Dev
        // -----------
        let pData = PrepareRegistrationData()
        pData.cardImage = UIImage(named: "card")
        pData.codeImage = UIImage(named: "barcode")
        pData.phoneNumber = "0821113310"
        pData.idNo = ""
        pData.cardType = .IDCard
        
        
        // Shot Form
        let prepaidForm = PrepaidFormTableViewController(prepaidData: pData)
        self.navigationController?.pushViewController(prepaidForm, animated: true)
        
        // Show Summary
//        let prepaidSummary = PrepaidSummaryTableViewController(prepaidData: pData)
//        self.navigationController?.pushViewController(prepaidSummary, animated: true)
    }
}

