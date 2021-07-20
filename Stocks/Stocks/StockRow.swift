//
//  ContentView.swift
//  Stocks
//
//  Created by Harrinandhaan Sathish Kumaar Nirmala on 7/16/21.
//

import SwiftUI

struct StockRow: View {
    var stock: StockData
    
    var body: some View {
        HStack {
            //Show stock symbol
            Text(stock.companyName)
                .font(.title2)
            Spacer()
            
            VStack {
                // Show stock price
                Text("Price")
                Text("\(String(format: "%.2f", (stock.price)))")
            }
            Divider()
            
            VStack {
                // Show stock change
                Text("Change")
                Text("\(String(format: "%.2f", (stock.changes)))")
            }
        }
    }
}

struct StockRow_Previews: PreviewProvider {
    static var stocks = ModelData().stocks
    
    static var previews: some View {
        StockRow(stock: stocks![0])
    }
}
