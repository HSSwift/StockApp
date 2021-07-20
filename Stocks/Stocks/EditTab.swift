//
//  StockEditTab.swift
//  StockTrackingApp
//
//  Created by CodeWithChris on 2021-01-15.
//

import SwiftUI

struct EditTab: View {
    @EnvironmentObject var modelData: ModelData
    @State var stockName: String = ""
    @Binding var isShown: Bool
    
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "plus")
                    .padding(5)
                // Text field to get user input on stocks to add, saved to stockName
                TextField("Add stocks by ticker", text: $stockName)
                
                // Adds the user inputted ticker to modelData.tickers on button press
                //   does not check for duplicates or if the ticker is valid
                Button(action: {
                    let newStock = stockName.uppercased()
                    stockName = ""
                    modelData.tickers.append(newStock)
                    // Saves the updated ticker list in user default settings
                    modelData.defaults.set(modelData.tickers, forKey: "Saved Array")
                    modelData.load()
                }) {
                    Text("Confirm")
                }
            }
            
            ScrollView{
                //Checks if stock data exists
                if modelData.stocks != nil {
                    //Loops through each stock and shows the StockEdit view
                    ForEach(modelData.stocks!) { stock in
                        StockEdit(stock: stock)
                            .padding(10)
                        Divider()
                    }
                }
            }
        }
    }
}



