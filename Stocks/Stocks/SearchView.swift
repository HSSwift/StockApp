// SearchView.swift

import SwiftUI

struct SearchView: View {
    
    @State private var searchTerm: String = ""
    @EnvironmentObject var modelData: ModelData
    
    @ObservedObject var searchManager = SearchManager()
    @Binding var isShown: Bool
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.8)
            VStack {
                HStack {
                    SearchTextView(searchTerm: $searchTerm)
                    Button(action: {
                        searchManager.searchStocks(keyword: searchTerm)
                    }) {
                        Image(systemName: "arrowtriangle.right.circle.fill")
                            .font(.title)
                            .foregroundColor(.white)
                    }
                }
                Spacer()
                
                ScrollView {
                    ForEach(searchManager.searches) { item in
                        HStack {
                            VStack(alignment: .leading) {
                                Text(item.symbol)
                                    .font(.title)
                                    .bold()
                                
                                Text(item.type)
                                    .font(.body)
                            }
                            Spacer()
                            Text(item.name)
                            Spacer()
                            Button(action: {
                                let newStock = item.symbol.uppercased()
                                searchTerm = ""
                                modelData.tickers.append(newStock)
                                // Saves the updated ticker list in user default settings
                                modelData.defaults.set(modelData.tickers, forKey: "Saved Array")
                                modelData.load()
                            }) {
                                Image(systemName: "plus.circle.fill")
                                    .font(.title)
                            }
                        }.foregroundColor(.white)
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.white)
                            .frame(height: 1)
                    }
                }
            }
            .padding(.top, 50)
            .padding(.horizontal, 16)
            
        }.edgesIgnoringSafeArea(.all)
    }
}


