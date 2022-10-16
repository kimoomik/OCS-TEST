//
//  NetworkManager.swift
//  OcsProgrames
//
//  Created by Abdelkarim MEDIANA on 06/10/2022.
//

import Foundation
import Combine

class NetworkManager {
    
    static let shared = NetworkManager()
    
    private init() {
        
    }
    
    private var cancellables = Set<AnyCancellable>()
    
    
    func getData<T: Decodable>(from: String, type: T.Type, path: String? = nil) -> Future<T, Error> {
        return Future<T, Error> { [weak self] promise in
            guard let self = self, let url = URL(string: self.geturl(ws: from,path: path)) else {
                return promise(.failure(NetworkError.invalidURL))
            }
            print("URL is \(url.absoluteString)")
            URLSession.shared.dataTaskPublisher(for: url)
                .tryMap { (data, response) -> Data in
                    guard let httpResponse = response as? HTTPURLResponse, 200...299 ~= httpResponse.statusCode else {
                        throw NetworkError.responseError
                    }
                    return data
                }
                .decode(type: T.self, decoder: JSONDecoder())
                .receive(on: RunLoop.main)
                .sink(receiveCompletion: { (completion) in
                    if case let .failure(error) = completion {
                        switch error {
                        case let decodingError as DecodingError:
                            promise(.failure(decodingError))
                        case let apiError as NetworkError:
                            promise(.failure(apiError))
                        default:
                            promise(.failure(NetworkError.unknown))
                        }
                    }
                }, receiveValue: { promise(.success($0)) })
                .store(in: &self.cancellables)
        }
    }
    
    func geturl(ws: String,path: String? = nil) -> String{
        GlobalConfiguration.setup()
        
        let dic = GlobalConfiguration.sharedInstance.webServices[ws] as! [String: Any]
        var url: String
        if let pathParam = path {
            url = String(format: dic[.wsUrl] as! String, pathParam)
        } else {
            url = dic[.wsUrl] as! String
        }
        
        return url
    }

}


enum NetworkError: Error {
    case invalidURL
    case responseError
    case unknown
}

extension NetworkError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return NSLocalizedString("URL Invalid", comment: "URL Invalid")
        case .responseError:
            return NSLocalizedString("Code statu inattendu", comment: "Reponse invalid")
        case .unknown:
            return NSLocalizedString("Erreur Inconnue", comment: "Erreur inconnue")
        }
    }
}
