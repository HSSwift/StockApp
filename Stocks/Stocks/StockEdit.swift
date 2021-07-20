//
//  StockEdit.swift
//  StockTrackingApp
//
//  Created by CodeWithChris on 2021-01-15.
//

import SwiftUI

struct StockEdit: View {
    @EnvironmentObject var modelData: ModelData
    var stock: StockData
    
    var body: some View {
        HStack {
            //Show stock symbol
            Text(stock.symbol)
                .font(.title2)
            Spacer()
            
            // Remove stock button
            Button(action: {
                // Filters out all occurances of the stock symbol from the tickers array
                modelData.tickers = (modelData.tickers).filter(){$0 != stock.symbol}
                // Saves the updated ticker list in user default settings
                modelData.defaults.set(modelData.tickers, forKey: "Saved Array")
                modelData.load()
            }) {
                Text("Remove")
            }
        }
    }
}

struct StockEdit_Previews: PreviewProvider {
    static var stocks = ModelData().stocks
    
    static var previews: some View {
        StockEdit(stock: stocks![0])
            .environmentObject(ModelData())
    }
}

