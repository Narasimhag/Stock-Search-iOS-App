//
//  StockListItem.swift
//  Stocks App HW9 CSCI571
//
//  Created by Narasimha Rao Gundavarapu on 11/16/20.
//

import Foundation




struct StockListItem: Identifiable, Decodable {

    var id = UUID()
    var ticker: String
    var stockName: String
    var price: Float     
    var quantity: Int
    var change: Float
    
//    init(ticker: String, stockName: String, price: Float, quantity: Int, change: Float){
//        self.ticker = ticker
//        self.stockName = stockName
//        self.price = price
//        self.quantity = quantity
//        self.change = change
//    }
    
}


