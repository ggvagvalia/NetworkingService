//
//  File.swift
//
//
//  Created by gvantsa gvagvalia on 5/2/24.
//

import Foundation


public class Service {
    
    public static let shared = Service()
    
    public func fetchCatData<T: Codable>(urlString: String, completion: @escaping (T?) -> Void) {
        
        guard let urlObject = URL(string: urlString) else {
            print("no url")
            completion(nil)
            return
        }
        
        URLSession.shared.dataTask(with: urlObject) { data, response, error in
            
            if error != nil {
                print("errorrrr")
                return
            }
            
            guard let data = data else {
                print("no data")
                return
            }
            
            do {
                let decodedData = try JSONDecoder().decode(T.self, from: data)
                DispatchQueue.main.async {
                    completion(decodedData)
                }
            } catch {
                completion(nil)
                print("error decoding json \(error.localizedDescription)")
            }
            
        }.resume()
    }
}
