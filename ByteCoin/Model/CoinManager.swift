//
//  CoinManager.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import Foundation

protocol CoinManagerDelegate {
    func didUpdateCurrency(_ coinManager: CoinManager, currency: CurrencyModel)
    func didFailWithError(error: Error)
}

struct CoinManager {
    let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC"
    let apiKey = "988F4926-F63A-4977-A67A-5891D7F8B75A"
    
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    
    var delegate: CoinManagerDelegate?

    func getCoinPrice(for currency: String){
        let urlString = "\(baseURL)&q=\(currency)?apiKey=\(apiKey)"
        performRequest(with: urlString)
    }
    
    func performRequest(with urlString: String) {
        //      #1 Create URL
        if let url = URL(string: urlString) {
            //      #2 Create URLSession
            let session = URLSession(configuration: .default)
            //      #3 Give the Session a task
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
//                if let safeData = data {
//                    if let currency = self.parseJSON(safeData) {
//                        self.delegate?.didUpdateCurrency(self, currency: currency)
//                    }
//                }
                let dataAsString = String(data: data!, encoding: .utf8)
                print(dataAsString)
            }
            //      #4 STart the task
            task.resume()
            
        }
    }
    
    func parseJSON(_ currencyData: Data) -> CurrencyModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(CurrencyData.self, from: currencyData)
            print(decodedData.rate)
            
            let currency = CurrencyModel(base: decodedData.asset_id_base, quote: decodedData.asset_id_quote, rate: decodedData.rate)
            
            return currency
        } catch  {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
}
