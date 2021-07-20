//
//  StocksViewModel.swift
//  Stocks
//
//  Created by Harrinandhaan Sathish Kumaar Nirmala on 7/16/21.
//


import Foundation
import Combine

class ModelData: ObservableObject {
    @Published var stocks: [StockData]?
    @Published var tickers: [String] = ["AAPL", "FB", "GOOG"]
    // Support for saving user settings
    let defaults = UserDefaults.standard
    
    init() {
        // Assign tickers to be previously saved tickers if any
        tickers = defaults.array(forKey: "Saved Array") as? [String] ?? tickers
        self.load()
    }
    
    //New Stock API call. Note: replace API key with own account
    func load(){
        let apiKey = "aa453a582c4440d217ef1f3af2f4ac15"
        var stockArray: [StockData] = []
        
        if(tickers.count != 0) {
            
            // Goes through each ticker to get the respective stock
            for i in tickers.indices {
                parseStock(tickerIndex: i, apiKey: apiKey) { (parsedStock) in
                    stockArray.append(parsedStock)
                    self.stocks = stockArray
                }
            }
        }
        // Empty ticker list
        else {
            self.stocks = nil
        }
    }
    
    /// Makes an API call for a ticker and gets stock information
    /// Parameters:
    ///   tickerIndex: Index of the ticker to use from the tickers array
    ///   apiKey: API key to make calls with
    ///   completed: Return stock value of async results
    func parseStock(tickerIndex: Int, apiKey: String, completed: @escaping (StockData) -> Void) {
        guard let url = URL(string: "https://financialmodelingprep.com/api/v3/quote/\(tickers[tickerIndex])?apikey=\(apiKey)")
        else {
            fatalError("Invalid URL.")
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            do {
                if error == nil && data != nil {
                    let decoder = JSONDecoder()
                    let stocksData = try decoder.decode([StockData].self, from: data!)
                    DispatchQueue.main.async {
                        if(stocksData.count > 0) {
                            completed(stocksData[0])
                        }
                    }
                }
            }
            catch {
                print("Couldn't parse JSON as Stocks:\n\(error)")
            }
        }
        .resume()
    }
    
    // Old Stock API call, now locked under premium accounts
    func oldLoad(){
        let apiKey = "bc50df22b34886a6947966c591119b42"
        var tickerList: String = ""
        
        // Converts all the tickers in the array to a formatted string to pass to the URL
        for i in tickers.indices {
            tickerList += "\(tickers[i])"
            if(i < tickers.count - 1) {
                tickerList += ","
            }
        }
        
        // Checks for empty ticker list
        if tickerList != "" {
            guard let url = URL(string: "https://financialmodelingprep.com/api/v3/quote/\(tickerList)?apikey=\(apiKey)")
            else {
                fatalError("Invalid URL.")
            }
            
            URLSession.shared.dataTask(with: url) { data, response, error in
                do {
                    if error == nil && data != nil {
                        let decoder = JSONDecoder()
                        let stocksData = try decoder.decode([StockData].self, from: data!)
                        DispatchQueue.main.async {
                            self.stocks = stocksData
                        }
                    }
                }
                catch {
                    fatalError("Couldn't parse JSON as Stocks:\n\(error)")
                }
            }
            .resume()
        }
        
        // Empty ticker list
        else {
            self.stocks = nil
        }
    }
    
}






