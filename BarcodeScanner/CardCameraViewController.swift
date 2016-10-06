//
//  CardCameraViewController.swift
//  BarcodeScanner
//
//  Created by Jirat Ki. on 10/6/2559 BE.
//  Copyright © 2559 n3tr. All rights reserved.
//

import UIKit

class CardCameraViewController: UIViewController {
    
    @IBOutlet weak var captureButton: UIButton!
    @IBOutlet weak var previewView: UIView!
    @IBOutlet weak var frameView: UIView!
    var scanner: MTBBarcodeScanner!
    var prepardData: PrepareRegistrationData
    
    init(prepardData: PrepareRegistrationData) {
        self.prepardData = prepardData
        super.init(nibName: String(CardCameraViewController.self), bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        scanner = MTBBarcodeScanner(metadataObjectTypes: [AVMetadataObjectTypeCode128Code], previewView: self.previewView)
        scanner.allowTapToFocus = true
        
        frameView.alpha = 0
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        MTBBarcodeScanner.requestCameraPermissionWithSuccess { (success) in
            if (!success) {
                return
            }
            
            self.startCamera()
        }
    }
    
    override func viewDidDisappear(animated: Bool) {
        scanner.stopScanning()
        super.viewDidDisappear(animated)
    }
    
    func startCamera() {
        scanner.startScanningWithResultBlock({ (codes) in
            // ignore
            }, error: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func captureButtonClicked(sender: AnyObject) {
        scanner.captureStillImage { (image, error) in
            if ((error) != nil) {
                print(error)
                return
            }
            
            self.processImage(image)
        }
    }

    func processImage(image: UIImage) {
        let cropped = getImageFromView(image)
        prepardData.cardImage = cropped
        let summary = PrepaidSummaryViewController(prepaidData: prepardData)
        self.navigationController?.pushViewController(summary, animated: true)
    }
    
    func cropImage(image: UIImage) -> UIImage {
        return getImageFromView(image)
    }
    
    private func getImageFromView(image: UIImage) -> UIImage {
        
        let voiRatio: CGFloat = 1.6
        
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
