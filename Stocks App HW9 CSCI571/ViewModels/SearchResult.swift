//
//  SearchResult.swift
//  Stocks App HW9 CSCI571
//
//  Created by Narasimha Rao Gundavarapu on 11/29/20.
//

import Foundation

import SwiftyJSON
import Alamofire

public class Debouncer {
    private let delay: TimeInterval
    private var workItem: DispatchWorkItem?

    public init(delay: TimeInterval) {
        self.delay = delay
    }

    /// Trigger the action after some delay
    public func run(action: @escaping () -> Void) {
        workItem?.cancel()
        workItem = DispatchWorkItem(block: action)
        DispatchQueue.main.asyncAfter(deadline: .now() + delay, execute: workItem!)
    }
}



class SearchResult: ObservableObject {
    
    @Published var results = [SearchResultItem]()
    
    func fetchData (url: String, callback: @escaping (_ json:JSON) -> Void) {
        //fetch json and decode and update array property
        
        if let url = URL(string: (url)) {
            print("requesting: \(url)")
            AF.request(url).validate().responseJSON{(response) in
                if let data  = response.data {
                    let json = JSON(data)
                    callback(json)
                    print(json)
                    return
                }
            }
        }
        
    }
    

    
    func processValues(json: JSON) {
        for (index, subJson):(String, JSON) in json {
            print(json[index], subJson)
        }
    }
}
