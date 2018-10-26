//
//  BatmanManager.swift
//  OMDBClientApplication
//
//  Created by Mac mini on 10/8/18.
//  Copyright © 2018 Mac mini. All rights reserved.
//

import Foundation
typealias Callback = (SearchCoordinator?,Error?) -> Void

class BatmanManager: NSObject {
    
    static let shared = BatmanManager()
    
    var currentPage: Int {
        if let searchCoordinator = searchCoordinator {
            return searchCoordinator.search.count/10
        } else {
            return 0
        }
    }
    
    var searchCoordinator: SearchCoordinator!
    
    func getdata(callback: @escaping Callback) {
        
        let urlString = URLRequest.Constant.baseUrlString + "&page=\(currentPage+1)&apikey=\(URLRequest.Constant.apikey)"
        print("******\(urlString)********")
        let url = URL(string: urlString)!
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        
        URLSession.shared.performTask(urlRequest: urlRequest) { (json, error) in
            print(json)
            guard let json = json else {
                callback(nil,error)
                return
            }
            if let coordinator: SearchCoordinator = decode(json: json) {
                // handle if there searches pre exist
                
                if let  _ = self.searchCoordinator {
                    self.searchCoordinator.search.append(contentsOf: coordinator.search)
                    callback(self.searchCoordinator, nil)
                } else if self.currentPage == 0 {
                    self.searchCoordinator = coordinator
                    callback(self.searchCoordinator, nil)
                }
                
            }
        }
     }
    
    func reset() {
        searchCoordinator = nil
    }
    
    
}
