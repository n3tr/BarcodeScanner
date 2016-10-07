//
//  ScannerViewController.swift
//  BarcodeScanner
//
//  Created by Jirat Ki. on 10/5/2559 BE.
//  Copyright © 2559 n3tr. All rights reserved.
//

import UIKit

class ScannerViewController: UIViewController {
    
    var viewOfInterests = UIView()
    var overlayTop = UIView()
    var overlayBottom = UIView()
    var scannerView = UIView()
    
    var isProcessing = false
    
    var scanner: MTBBarcodeScanner?
    
    init() {
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        view = UIView()
        view.backgroundColor = UIColor.blackColor()
        
        view.addSubview(scannerView)
        scannerView.frame = self.view.frame
        scannerView.addSubview(viewOfInterests)
        scannerView.addSubview(overlayTop)
        scannerView.addSubview(overlayBottom)
        
        overlayTop.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.6)
        overlayBottom.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.6)
    }
    
    // Adjust Layout
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        let viewWidth = self.view.bounds.width
        let viewHeight = self.view.bounds.height
        let voiRatio: CGFloat = 4
        let voiWidth = viewWidth
        let voiHeight = voiWidth / voiRatio
        
        let overlayHeight = (viewHeight - voiHeight) / 2
        
        var y: CGFloat = 0.0
        
        scannerView.frame = self.view.frame
        
        overlayTop.frame = CGRectMake(0, y, viewWidth, overlayHeight)
        y = y + overlayHeight
        
        viewOfInterests.frame = CGRectMake(0, y, voiWidth, voiHeight)
        y = y + voiHeight
        
        overlayBottom.frame = CGRectMake(0, y, viewWidth, overlayHeight)
        
        guard let scanner = self.scanner else { return }
        
        if (scanner.isScanning()) {
            self.scanner?.scanRect = CGRectInset(self.viewOfInterests.frame, 0, 10.0)
        }
        
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        self.navigationController?.setNavigationBarHidden(true, animated: false)
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.startScan()
        
    }
    
    override func viewDidDisappear(animated: Bool) {
        self.scanner?.stopScanning()
        super.viewDidDisappear(animated)
    }

}


// MARK: - Scanner
extension ScannerViewController {
    func startScan() {
        self.isProcessing = false
        
        scanner = MTBBarcodeScanner(previewView: self.scannerView)
        
        scanner?.didStartScanningBlock = {
           self.scanner?.scanRect = CGRectInset(self.viewOfInterests.frame, 0, 10.0)
        }
        MTBBarcodeScanner.requestCameraPermissionWithSuccess { (success) in
            if (success) {
                
                self.scanner?.startScanningWithResultBlock({ (codes) in
                    if (self.isProcessing) {
                        return
                    }
                    self.isProcessing = true
                    self.captureImageForCode(codes[0].stringValue)
                    }, error: nil)
            }
        }
    }
    
    func captureImageForCode(code: String) {
        self.scanner?.captureStillImage({ (image, error) in
            if ((error) != nil) {
                print(error)
                return
            }
            
            self.processCodeAndImage(code, image: image)
        })
    }
    
    func processCodeAndImage(code: String, image: UIImage) {
        let codeImage = getImageFromView(image)
        let prepaidData = PrepareRegistrationData()
        prepaidData.code = code
        prepaidData.codeImage = codeImage
        
        let cardCameraVC = CardCameraViewController(prepardData: prepaidData)
        
        self.navigationController?.pushViewController(cardCameraVC, animated: true)
    }
    
    private func getImageFromView(image: UIImage) -> UIImage {
        
        let voiRatio: CGFloat = 4
        
        let imageWidth = image.size.width
        let imageHeight = image.size.height
        
        let croppedHeight = imageWidth / voiRatio
        
        let oUpImage = image.fixOrientation()
        let cropped = cropImage(oUpImage, rect: CGRectMake(0, (imageHeight - croppedHeight) / 2 , imageWidth, croppedHeight))
        
        return cropped
    }
    
    private func cropImage(image: UIImage, rect: CGRect) -> UIImage {
        let imageRef = CGImageCreateWithImageInRect(image.CGImage, rect)
        let cropped = UIImage(CGImage: imageRef!)
        return cropped
    }
}
