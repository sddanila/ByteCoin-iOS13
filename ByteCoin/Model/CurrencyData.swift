//
//  currencyData.swift
//  ByteCoin
//
//  Created by Danila Barton-Szabo on 2020-06-28.
//  Copyright © 2020 The App Brewery. All rights reserved.
//

import Foundation

struct CurrencyData : Codable {
    let asset_id_base : String
    let asset_id_quote: String
    let rate: String
    
//    Example Data from API:
    //    "time": "2020-06-28T20:33:34.2151905Z",
    //    "asset_id_base": "BTC",
    //    "asset_id_quote": "USD",
    //    "rate": 9128.187026240766
}
