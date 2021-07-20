//
//  MainTab.swift
//  StockTrackingApp
//
//  Created by CodeWithChris on 2021-01-15.
//

import SwiftUI

struct MainTab: View {
    @EnvironmentObject var modelData: ModelData
    
    var body: some View {
        ScrollView{
            // Check is stocks data exists
            if modelData.stocks != nil {
                // Loop through each stock and show the StockRow view for the stock
                ForEach(modelData.stocks!) { stock in
                    StockRow(stock: stock)
                        .padding(10)
                    Divider()
                }
            }
            // If no stocks exist
            else {
                
                VStack {
                    Image("edit")
                    Text("Click on the edit button to add stocks")
                    
                }
            }
        }
    }
}

struct MainTab_Previews: PreviewProvider {
    static var previews: some View {
        MainTab()
            .environmentObject(ModelData())
    }
}
