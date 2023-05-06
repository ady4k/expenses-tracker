//
//  ApiRequests.swift
//  Expenses Tracker
//
//  Created by Adrian Vîslă on 03.05.2023.
//

/* LIST of possible "queryParams":
 
 GET:
 * "" - get all transactions
 * "{id}" - get the transaction with the ID
 * "last/{n}" - get the last N transactions
 * "cat/{category}" - get a specific category of transactions
 * "tran/{transaction}" - get a specific type of transactions (expense or income)
 
 DELETE:
 * "{id}"
 
 POST (add new), PUT (edit):
 * "" - transactions are edited from the request's body, send object as JSON
 
 */


import Foundation

class Transactions {
    let mainUrlString = "http://192.168.1.104:5000/api/ios"
    
    public func getURLForTransactions(_ additionalQueryParams: String = "") -> URL? {
        let urlString = mainUrlString + additionalQueryParams
        
        guard let urlComponents = URLComponents(string: urlString) else {
            return nil
        }
        
        return urlComponents.url
    }
    
    public func fetchTransactions(queryParams: String = "", completion: @escaping (Result<Data, Error>) -> Void) {
        guard let url = getURLForTransactions(queryParams) else {
            return
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        
        let dataTask = URLSession.shared.dataTask(with: urlRequest) { responseData, urlResponse, error in
            if let error = error {
                print("Request failed, error: \(error.localizedDescription)")
                completion(.failure(error))
                return
            }
            
            guard let httpUrlResponse = urlResponse as? HTTPURLResponse,
                  let data = responseData else {
                print ("No data received or response is not a HTTP response")
                let error = NSError(domain: "Invalid Response", code: 0, userInfo: nil)
                completion(.failure(error))
                return
            }
            
            print("Response Code: \(httpUrlResponse.statusCode)")
            completion(.success(data))
        }
        dataTask.resume()
    }
    
    public func postTransaction(_ transaction: Transaction) {
        guard let url = getURLForTransactions() else {
            return
        }
        let jsonObject = try? JSONEncoder().encode(transaction)
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.httpBody = jsonObject
        
        let dataTask = URLSession.shared.dataTask(with: urlRequest) { responseData, urlResponse, error in
            if let error = error {
                print("Request failed, error: \(error)")
                return
            }
            
            guard let httpUrlResponse = urlResponse as? HTTPURLResponse,
                  let data = responseData else {
                print ("No data received or response is not a HTTP response")
                let error = NSError(domain: "Invalid Response", code: 0, userInfo: nil)
                return
            }
            
            print("Response Code: \(httpUrlResponse.statusCode)")
            if let dataString = String(data: data, encoding: .utf8) {
                print("Response data: \(dataString)")
            }
        }
        dataTask.resume()

    }
    
    // TODO: - function for PUT transactions
    // TODO: - function for DELETE transactions
}
