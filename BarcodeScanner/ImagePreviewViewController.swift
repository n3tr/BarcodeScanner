//
//  ImagePreviewViewController.swift
//  BarcodeScanner
//
//  Created by Jirat Ki. on 10/6/2559 BE.
//  Copyright © 2559 n3tr. All rights reserved.
//

import UIKit

class ImagePreviewViewController: UIViewController {
    
    let image: UIImage
    
    @IBOutlet weak var imageView: UIImageView!
    init(image: UIImage) {
        self.image = image
        super.init(nibName: "ImagePreviewViewController", bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        
        self.imageView.image = image
        
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        let viewWidth = self.view.bounds.width
        let viewHeight = self.view.bounds.height
        let voiRatio: CGFloat = 2
        let voiWidth = viewWidth
        let voiHeight = voiWidth / voiRatio
        
        self.imageView.frame = self.view.bounds
        self.imageView.clipsToBounds = true
        self.imageView.center = self.view.center
        self.imageView.contentMode = .ScaleAspectFit
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
