//
//  BitcoinPriceChecker.swift
//  sample-ios-bitcoinprice
//
//  Created by Danilo Gomes on 28/08/2017.
//  Copyright © 2017 Danilo Gomes. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

/**
 Model for server response.
 */
class BitcoinPriceResponse  {
    
    var success = false
    var price : Float?
    var symbol : String?
    
    func parseJson(value : Any?){
        let json = JSON(value!)
        
        let data =  json["EUR"]
        self.symbol = "EUR"
        self.price = data["last"].float
        self.success = self.price != nil
    }
}


class BitcoinPriceChecker {

    let SERVER_URL = "https://blockchain.info/ticker"
    
    func retrievePrice(responseCallback : @escaping (_ success : BitcoinPriceResponse) -> Void) {
        
        Alamofire.request(SERVER_URL).responseJSON { response in
            
            if let json = response.result.value {
                
                let resp = BitcoinPriceResponse()
                resp.parseJson(value: json)
                responseCallback(resp)
            }
        }
    }
}
