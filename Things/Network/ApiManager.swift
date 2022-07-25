//
//  ApiManager.swift
//  Things
//
//  Created by Teja on 23/07/22.
//

import Foundation


struct APIManager {
    static func fetch<T: Decodable>(url: String, completion: @escaping (Result<T,NetworkRequestError>) -> Void) {
        guard
            Reachability.isConnectedToNetwork()
        else {
            completion(.failure(NetworkRequestError.internetNotAvailable))
            return
        }
        guard let url = URL(string: url) else { return }
        let session = URLSession.shared
        session.dataTask(with: url) { data, response, error in
            if let _ = error {
                completion(.failure(NetworkRequestError.serverError))
                return
            }
            
            if let response = response as? HTTPURLResponse,
               !(200...299).contains(response.statusCode), response.statusCode != 400{
                completion(.failure(self.httpError(response.statusCode)))
                return
            }
            guard
                let data = data
            else {
                completion(.failure(NetworkRequestError.notFound))
                return
            }
            let dataString = String(data: data, encoding: String.Encoding(rawValue: String.Encoding.utf8.rawValue)) ?? ""
            NSLog(dataString)
            do {
                let result = try JSONDecoder().decode(T.self, from: data)
                completion(.success(result))
            }catch {
                completion(.failure(handleError(error)))
            }
        }.resume()
    }
    
    
    static func httpError(_ statusCode: Int) -> NetworkRequestError {
        switch statusCode {
        case 400: return .badRequest
        case 401: return .unauthorized
        case 403: return .forbidden
        case 404: return .notFound
        case 402, 405...499: return .error4xx(statusCode)
        case 500: return .serverError
        case 501...599: return .error5xx(statusCode)
        default: return .unknownError
        }
    }
    
    
    static func handleError(_ error: Error) -> NetworkRequestError {
        switch error {
        case is Swift.DecodingError:
            return .decodingError
        case let urlError as URLError:
            return .urlSessionFailed(urlError)
        case let error as NetworkRequestError:
            return error
        default:
            return .unknownError
        }
    }
}



enum NetworkRequestError: LocalizedError, Equatable {
    case internetNotAvailable
    case badRequest
    case unauthorized
    case forbidden
    case notFound
    case error4xx(_ code: Int)
    case serverError
    case error5xx(_ code: Int)
    case decodingError
    case urlSessionFailed(_ error: URLError)
    case unknownError
    var localizedString: String{
        switch self {
        case .internetNotAvailable:
            return "No Internet Connection. Please check your internet connection."
        case .badRequest:
            return "Failed to encode request parameters"
        case .unauthorized:
            return "Authenticatioon failed"
        case .forbidden:
            return "URL forbidden"
        case .notFound:
            return "Data not Found"
        case .error4xx(let statusCode):
            return "Error with the request, unexpected status code: \(statusCode)"
        case .serverError:
            return "Sorry, couldn't reach our server."
        case .error5xx(let statusCode):
            return "Service Unavailable, unexpected status code: \(statusCode)"
        case .decodingError:
            return "Something went wrong. Please try again after sometime."
        case .urlSessionFailed(let session):
            return "\(session)"
        case .unknownError:
            return ""
        }
    }
}
