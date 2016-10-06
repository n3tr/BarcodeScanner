//
//  PrepaidSummaryViewController.swift
//  BarcodeScanner
//
//  Created by Jirat Ki. on 10/6/2559 BE.
//  Copyright © 2559 n3tr. All rights reserved.
//

import UIKit

class PrepaidSummaryViewController: UIViewController {

    @IBOutlet weak var codeImageView: UIImageView!
    @IBOutlet weak var idCardImageView: UIImageView!
    @IBOutlet var contentView: UIView!
    
    var prepaidData: PrepareRegistrationData
    
    init(prepaidData: PrepareRegistrationData){
        self.prepaidData = prepaidData
        super.init(nibName: "PrepaidSummaryViewController", bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        codeImageView.image = prepaidData.codeImage
        idCardImageView.image = prepaidData.cardImage
        // Do any additional setup after loading the view.
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        contentView.frame = view.frame
        view.addSubview(contentView)
        view.setNeedsUpdateConstraints()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
