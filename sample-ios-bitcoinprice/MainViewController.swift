//
//  MainViewController.swift
//  sample-ios-bitcoinprice
//
//  Created by Danilo Gomes on 28/08/2017.
//  Copyright © 2017 Danilo Gomes. All rights reserved.
//

import UIKit
import SVProgressHUD

class MainViewController: UIViewController {
    
    let priceChecker = BitcoinPriceChecker()
    var dataLoaded = false

    // MARK: UI Elements
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var updateDateLabel: UILabel!
    
    
    // MARK: Events
    @IBAction func didClickOnRefreshButton(_ sender: Any) {
        requestValues()
    }
    
    // MARK: ViewController Lifecycle
    func showBitcoinValueOnScreen(_ response : BitcoinPriceResponse) {
        self.priceLabel.text = "\(response.symbol!) \(response.price!)"
        self.updateDateLabel.text = self.getCurrentTimestamp()
    }
    
    func showFallbackValues() {
        self.priceLabel.text = "N/A"
        self.updateDateLabel.text = self.getCurrentTimestamp()
    }
    
    /**
     Retrieves bitcoin values and presents data on screen.
     */
    func requestValues () {
        
        SVProgressHUD.show(withStatus: "Retrieving updated values")
        
        priceChecker.retrievePrice { (response) in
            SVProgressHUD.dismiss()
            
            if(response.success){
                self.showBitcoinValueOnScreen(response)
            } else {
                self.showFallbackValues()
            }
        }
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if !dataLoaded {
            dataLoaded = true
            requestValues()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.showFallbackValues()
    }
    
    // MARK: Aux
    
    /**
     Formats date on full timestamp format.
     */
    func getCurrentTimestamp () -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MMM/yyyy HH:mm:ss"
        
        return dateFormatter.string(from: Date())
    }
    
}
