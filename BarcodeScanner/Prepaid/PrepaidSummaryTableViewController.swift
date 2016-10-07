//
//  PrepaidSummaryTableViewController.swift
//  BarcodeScanner
//
//  Created by Jirat Ki. on 10/7/2559 BE.
//  Copyright © 2559 n3tr. All rights reserved.
//

import UIKit

class PrepaidSummaryTableViewController: UITableViewController {
        
    @IBOutlet var headerCell: UITableViewCell!
    @IBOutlet var barcodeImageCell: UITableViewCell!
    @IBOutlet var cardImageCell: UITableViewCell!
    @IBOutlet var detailCell: UITableViewCell!
    
    @IBOutlet weak var barcodeImageView: UIImageView!
    @IBOutlet weak var cardImageView: UIImageView!
    
    var cellArray: [UITableViewCell] = []
    var cellHeight: [CGFloat] = []
    
    var prepaidData: PrepareRegistrationData
    
    init(prepaidData: PrepareRegistrationData) {
        self.prepaidData = prepaidData
        super.init(nibName: String(PrepaidSummaryTableViewController.self), bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cellArray += [headerCell, barcodeImageCell, cardImageCell, detailCell]
        cellHeight += [44.0, calculateBarcodeHeight(), calculateCardHeight(), 162.0]
        
        setupView()
    }
    
    func calculateBarcodeHeight() -> CGFloat {
        return self.view.frame.width / 4;
    }
    
    func calculateCardHeight() -> CGFloat {
        return self.view.frame.width / 1.6
    }
    
    func setupView() {
        barcodeImageView.image = prepaidData.codeImage
        cardImageView.image = prepaidData.cardImage
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellArray.count
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return cellHeight[indexPath.row]
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        return cellArray[indexPath.row]
    }
    
}
