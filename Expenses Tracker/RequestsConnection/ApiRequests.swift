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
    public func getURLForTransactions(_ additionalQueryParams: String = "") -> URL? {
        let mainUrlString = "http://192.168.1.104:5000/api/ios/"
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
    
    // TODO: - function for PUT transactions
    // TODO: - function for DELETE transactions
    // TODO: - function for POST transactions
}
