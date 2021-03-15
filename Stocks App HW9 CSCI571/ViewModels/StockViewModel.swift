//
//  StockViewModel.swift
//  Stocks App HW9 CSCI571
//
//  Created by Narasimha Rao Gundavarapu on 11/18/20.
//

import Foundation
import Alamofire
import SwiftyJSON


protocol JSONable {
    init?(parameter: JSON)
}

extension JSON {
    func to<T>(type: T?) -> Any? {
        if let baseObj = type as? JSONable.Type {
            if self.type == .array {
                var arrObject: [Any] = []
                for obj in self.arrayValue {
                    let object = baseObj.init(parameter: obj)
                    arrObject.append(object!)
                }
                return arrObject
            } else{
                let object = baseObj.init(parameter: self)
                return object!
            }
        }
        return nil
    }
}

class StockViewModel: ObservableObject {
    
    let searchURI = ""
    let detailsURI = ""
    
    
    @Published var cData : [StockListItem] = [StockListItem(ticker: "AAPL", stockName:"Apple Inc", price: 224, quantity: 4, change: 4.55),
                                              StockListItem(ticker: "SNAP", stockName:"SnapChat", price: 224, quantity: 4, change: 4.55),
                                              StockListItem(ticker: "GOOGL", stockName:"Alphabet", price: 224, quantity: 4, change: 4.55),
                                              StockListItem(ticker: "NVDA", stockName:"Nvdia Inc", price: 225, quantity: 4, change: 4.55),
                                              StockListItem(ticker: "AAPL", stockName:"Apple Inc", price: 224, quantity: 4, change: 4.55),
                                              StockListItem(ticker: "AAPL", stockName:"Apple Inc", price: 224, quantity: 4, change: 4.55),
                                              StockListItem(ticker: "AAPL", stockName:"Apple Inc", price: 224, quantity: 4, change: 4.55)];
   
   
    //init or func
    func fetchData (url: String, callback: @escaping (_ json:JSON) -> Void) {
        //fetch json and decode and update array property
        
        if let url = URL(string: (url)) {
            print("requesting: \(url)")
            AF.request(url).validate().responseJSON{(response) in
                if let data  = response.data {
                    let json = JSON(data)
                    callback(json)
//                    print(json)
                    return
                }
            }
        }
        
    }
    
    func populateSearch(data: JSON){
//         print(data)
    }
    
    init() {
//        fetchData(url: "https://dummynodejsnrg.azurewebsites.net/api/search/aap", callback: self.populateSearch)
//        AF.request("https://dummynodejsnrg.azurewebsites.net/api/summary/aapl").responseData{(data) in
//            let json = try! JSON(data: data.data!)
//            for i in json {
//                print(i.0)
//                print(i.1)
//            }
//
//        }
    }
    
    
//
}
