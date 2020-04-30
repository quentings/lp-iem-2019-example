//
//  NetworkingManager.swift
//  CollectionView
//
//  Created by Quentin Genevois on 29/04/2020.
//  Copyright © 2020 Quentin Genevois. All rights reserved.
//

import Foundation

enum NetworkingError: Error {
    case mimeType
    case statusCode(Int)
    case invalidResponse
    case emptyData
}

protocol NetworkingManagerProtocol: class {
    func fetchSerieCharacters(completion: @escaping (Result<PaginatedElements<SerieCharacter>, Error>) -> Void)
    func fetchLocations(completion: @escaping (Result<PaginatedElements<Location>, Error>) -> Void)
}

final class NetworkingManager: NetworkingManagerProtocol {
    private enum APIEndPoint: String {
        private static let baseURL = URL(string: "https://rickandmortyapi.com/api/")!

        case location = "location"
        case serieCharacters = "character"

        var url: URL {
            return APIEndPoint.baseURL.appendingPathComponent(self.rawValue)
        }
    }

    private enum HTTPMethod: String {
        case get = "GET"
    }

    static let shared: NetworkingManagerProtocol = NetworkingManager()

    fileprivate static let iso8601Formatter: ISO8601DateFormatter = {
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        return formatter
    }()

    private let session = URLSession.shared

    private init() { }

    private func request<T: Decodable>(endPoint: APIEndPoint,
                                       httpMethod: HTTPMethod = .get,
                                       responseType: T.Type,
                                       completion: @escaping (Result<T, Error>) -> Void) {
        func handlerError(_ error: Error) {
            DispatchQueue.main.async {
                completion(.failure(error))
            }
        }


        var request = URLRequest(url: endPoint.url)
        request.httpMethod = httpMethod.rawValue

        let dataTask = session.dataTask(with: request) { (data, response, error) in
            if let error = error {
                handlerError(error)
                return
            }

            guard let httpResponse = response as? HTTPURLResponse else {
                handlerError(NetworkingError.invalidResponse)
                return
            }

            guard (200...299).contains(httpResponse.statusCode) else {
                handlerError(NetworkingError.statusCode(httpResponse.statusCode))
                return
            }

            guard let data = data else {
                handlerError(NetworkingError.emptyData)
                return
            }

            guard
                let mimeType = httpResponse.mimeType,
                mimeType == "application/json" else {
                    handlerError(NetworkingError.mimeType)
                    return
            }

            do {
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .custom { (decoder) -> Date in
                    // We create a custom formatter to decode date
                    let dateString = try decoder.singleValueContainer().decode(String.self)
                    return NetworkingManager.iso8601Formatter.date(from: dateString)!
                }

                let result =  try decoder.decode(responseType, from: data)

                DispatchQueue.main.async {
                    completion(.success(result))
                }

            } catch {
                handlerError(error)
            }
        }

        dataTask.resume()
    }

    func fetchLocations(completion: @escaping (Result<PaginatedElements<Location>, Error>) -> Void) {
        request(endPoint: APIEndPoint.location,
                responseType: PaginatedElements<Location>.self,
                completion: completion)
    }

    func fetchSerieCharacters(completion: @escaping (Result<PaginatedElements<SerieCharacter>, Error>) -> Void) {
        request(endPoint: APIEndPoint.serieCharacters,
                responseType: PaginatedElements<SerieCharacter>.self,
                completion: completion)
    }
}
