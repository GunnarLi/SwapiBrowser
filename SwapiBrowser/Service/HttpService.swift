//
//  HttpService.swift
//  SwapiBrowser
//
//  Created by Admin on 28.07.23.
//

import Foundation

/// simple class to fire async http requests.
/// TODO: add better error handlinig
class HttpService {
    
    /// Load the data by http and decodes the response to the given type
    /// - Parameters:
    ///   - urlString: the url to load from
    ///   - type: the type which is expected
    /// - Returns: an instance of type or null
    func requestType<T: Decodable>(urlString: String, type: T.Type) async -> T? {
        let data = await request(from: urlString)
        
        guard let swObject: T = data?.decode() else {return nil}
        return swObject
    }
    
    /// Loads the resource at the given url string
    /// - Parameter urlString: the url as String
    /// - Returns: the response as data or nil
    func request(from urlString: String) async -> Data? {

        guard let url = URL(string: urlString) else {return nil}
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        print("Info: Start request")
        print("**************************************************************************")
        print("*********** Requested Url : \(url) ******************")
        print("**************************************************************************")

        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            // any data problem ?
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode != 201 else {return nil}
            
//            print("*** Received response at \(urlString): String = \"\(String(data: data, encoding: String.Encoding.utf8) ?? "")\"")
            return data
        } catch {
            return nil
        }
    }
}

/// useful extension to Data
extension Data {

    /// Decode the current data instance to the associated generic type
    /// - Returns: the decoded object or nil
    public func decode<T: Decodable>() -> T? {
        do {
            let decoder = JSONDecoder()
            let decodable = try decoder.decode(T.self, from: self)
            return decodable
            
        }  catch DecodingError.dataCorrupted(let context) {
            print("Error: Decode failed - dataCorrupted! Context: \(context.debugDescription)")
            return nil
            
        } catch DecodingError.keyNotFound(let key, let context) {
            print("Error: Decode failed - key not found! Key: \(key) - Context: \(context.debugDescription)")
            return nil
            
        } catch DecodingError.typeMismatch(let type, let context) {
            let typeString = "\(type)"
            print("Error: Decode failed - type mismatch! Type: \(typeString) - Context: \(context.debugDescription)")
            return nil
            
        } catch let error as NSError  {
            print("Error: Decode failed - generic error! Error: \(error)")
            return nil
        }
    }
}
