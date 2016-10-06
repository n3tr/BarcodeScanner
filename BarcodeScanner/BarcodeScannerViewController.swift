//
//  BarcodeScannerViewController.swift
//  BarcodeScanner
//
//  Created by Jirat Ki. on 10/3/2559 BE.
//  Copyright © 2559 n3tr. All rights reserved.
//

import UIKit

class BarcodeScannerViewController: UIViewController {

    @IBOutlet weak var scanerFrame: UIView!
    @IBOutlet weak var previewImage: UIImageView!
    @IBOutlet weak var scannerView: UIView!
    var scanner: MTBBarcodeScanner?
    var processingBarcode = false
    override func viewDidLoad() {
        super.viewDidLoad()
        
        

        self.scanner = MTBBarcodeScanner(metadataObjectTypes: [AVMetadataObjectTypeQRCode], previewView: self.scannerView)
        
        
        MTBBarcodeScanner.requestCameraPermissionWithSuccess { (success) in
            if (success) {
                self.scanner?.startScanningWithResultBlock({ (codes) in
                    print(codes)
                    
                    if (self.processingBarcode) {
                        return
                    }
                    
                    self.processingBarcode = true
                    self.scanner?.captureStillImage({ (image, error) in
                        if (error != nil) {
                            self.processingBarcode = false
                        } else {
                            self.processingBarcode = false
                            self.previewImage.image = image
                        }
                    })
                    
                    }, error: nil)
                
                
            }
        }
        
    }
    
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.scanner?.scanRect = self.scanerFrame.frame
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
