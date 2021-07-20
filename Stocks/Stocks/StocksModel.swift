//
//  StocksModel.swift
//  Stocks
//
//  Created by Harrinandhaan Sathish Kumaar Nirmala on 7/16/21.
//

import SwiftUI


// MARK: - StockData
struct StockData: Codable, Identifiable {
    let id = UUID()
    let symbol: String
    let price, beta: Double
    let volAvg, mktCap: Int
    let lastDiv: Double
    let range: String
    let changes: Double
    let companyName, currency, cik, isin: String
    let cusip, exchange, exchangeShortName, industry: String
    let website: String
    let welcomeDescription, ceo, sector, country: String
    let fullTimeEmployees, phone, address, city: String
    let state, zip: String
    let dcfDiff, dcf: Double
    let image: String
    let ipoDate: String
    let defaultImage, isEtf, isActivelyTrading: Bool

    enum CodingKeys: String, CodingKey {
        case symbol, price, beta, volAvg, mktCap, lastDiv, range, changes, companyName, currency, cik, isin, cusip, exchange, exchangeShortName, industry, website
        case welcomeDescription = "description"
        case ceo, sector, country, fullTimeEmployees, phone, address, city, state, zip, dcfDiff, dcf, image, ipoDate, defaultImage, isEtf, isActivelyTrading
    }
}

typealias Welcome = [StockData]
