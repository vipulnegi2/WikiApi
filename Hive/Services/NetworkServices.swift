//
//  NetworkServices.swift
//  Hive
//
//  Created by Vipul Negi on 10/04/23.
//

import Foundation

protocol ResultsServiceProtocol {
    func getResults(searchStr: String, completion: @escaping (_ success: Bool, _ results: Result?, _ error: String?) -> ())
}

class ResultsService: ResultsServiceProtocol {
    func getResults(searchStr: String, completion: @escaping (Bool, Result?, String?) -> ()) {
        
        let params = ["action": "query",
                      "format": "json",
                      "generator": "search",
                      "gsrnamespace": "0",
                      "gsrsearch": searchStr,
                      "gsrlimit": "10",
                      "prop": "pageimages|extracts",
                      "pilimit": "max",
                      "exintro": "",
                      "explaintext": "",
                      "exsentences": "1",
                      "exlimit": "max"]
        
        let endPoint = "https://en.wikipedia.org/w/api.php?"
        
        HttpRequestHelper().GET(url: endPoint, params: params, httpHeader: .none) { success, data in
            if success {
                do {
                    guard let jsonData = data else {return}
                    let jsonObj = try JSONDecoder().decode(Result.self, from: jsonData)
                    completion(true, jsonObj, nil)
                } catch {
                    completion(false, nil, "Error: Trying to parse result to model")
                }
            } else {
                completion(false, nil, "Error: Response GET Request failed")
            }
        }
    }
}
