//
//  HTTPClient.swift
//  YoGrowcerCustomer
//
//  Created by IOS Developer on 25/04/18.
//  Copyright © 2018 iOS Developer. All rights reserved.
//

import Foundation
extension Dictionary {
    var queryString: String {
        var output: String = ""
        for (key,value) in self {
            output +=  "\(key)=\(value)&"
        }
        output = String(output.dropLast())
        return output
    }
}

extension URLSessionConfiguration {
    class func configuration() -> URLSessionConfiguration {
        let config = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = 20
        return config
    }
}

enum RequestMethod: String {
    case get = "GET"
    case put = "PUT"
    case post = "POST"
    case delete = "DELETE"
    
}

var _baseUrl: String {
    if let name = Bundle.main.infoDictionary?["serverUrl"] as? String {
        return name;
    }
    return "Unknown"
}

var _apikey: String {
    if let name = Bundle.main.infoDictionary?["ApiKey"] as? String {
        return name;
    }
    return "Unknown"
}

extension URLRequest {
    
    struct Constant {
        static var baseUrl: URL {
            return URL(string: _baseUrl)!
        }
        static let baseUrlString = "http://www.omdbapi.com/?s=Batman"
        static let apikey = "eeefc96f"
        //static let googleClientKey =

    }
    /*
    static func requestWithURL(urlString: String,
                              method: RequestMethod,
                              queryParameters: [String: String]? = nil,
                              bodyParameters: [String: String]? = nil,
                              headers: [String: String]? = nil) -> URLRequest {
        
        var url =  URL(string: Constant.baseUrlString + urlString)!
        print("\(url)")
        // add constant parameter here if any
        // append query parameters to url
        if let queryParameters = queryParameters {
            var components = URLComponents(url: url, resolvingAgainstBaseURL: true)
            components?.queryItems = queryParameters.map { key, value -> URLQueryItem in
                return URLQueryItem(name: key, value: value)
            }
            precondition(components?.url != nil , "Url is nil Fatal Error:")
            url = components!.url!
          }
        
        //make request with given method
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        
        //add param with HTTP body if there
        print(bodyParameters ?? "NIL bodyParameters")
        if let bodyParameters = bodyParameters {
             //request.addValue("application/json", forHTTPHeaderField: "Content-Type")
             //request.addValue("application/json", forHTTPHeaderField: "Accept")
            do {
                print(bodyParameters.queryString)
                request.httpBody = bodyParameters.queryString.data(using: .utf8)
            } catch {
                print(error.localizedDescription)
            }
         }
        
        //add Headers if any
        if let headers = headers {
            for (field, value) in headers {
                request.addValue(value, forHTTPHeaderField: field)
            }
        }
       print(request.httpBody ?? "NIL bodyParameters")
       return request
    }
 */
}

extension URLSession {
     func performTask(urlRequest: URLRequest, callBack: @escaping (_ response: [String: Any]?, _ error: Error?) -> Void) {
           dataTask(with: urlRequest) { (data, response, error) in
            guard let data = data, error == nil else {
                print("error: \(String(describing: error?.localizedDescription))")
                callBack(nil,error!)
                return
            }
            print(response)
            //convert data into JSON Dict
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableLeaves) as? [String: Any]
                callBack(json,nil)
            } catch {
                print("error:\(error.localizedDescription)")
                callBack(nil,error)
            }
        }.resume()
    }
    
}



