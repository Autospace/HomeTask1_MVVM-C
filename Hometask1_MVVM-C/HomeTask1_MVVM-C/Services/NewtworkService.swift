//
//  NewtworkService.swift
//  HomeTask1_MVVM-C
//
//  Created by Alex Mostovnikov on 22/11/20.
//

import Foundation

struct StatusCodeError: Error {
  let code: Int
}

struct ResponseError: Error {
    let message: String
}

class NetworkService {
    let urlSession: URLSession

    init(urlSession: URLSession = URLSession.shared) {
        self.urlSession = urlSession
    }

    func fetchStrings(completion: @escaping (_ result: Result<String, Error>) -> Void) {
        let url = URL(string: "https://www.random.org/strings/?num=10&len=8&digits=on&upperalpha=on&loweralpha=on&unique=on&format=plain&rnd=new")!
        let dataTask = urlSession.dataTask(with: url) { (data, urlResponse, error) in
            do {
                if let error = error {
                    throw error
                }

                if let httpResponse = urlResponse as? HTTPURLResponse {
                    if !(200..<300 ~= httpResponse.statusCode) {
                        completion(Result.failure(StatusCodeError(code: httpResponse.statusCode)))
                    } else if let data = data {
                        completion(Result.success(String(decoding: data, as: UTF8.self)))
                    } else {
                        completion(Result.failure(ResponseError(message: "Invalid data format")))
                    }
                } else {
                    completion(Result.failure(ResponseError(message: "Unexpected error")))
                }
            } catch {
                completion(Result.failure(error))
            }
        }
        dataTask.resume()
    }
}
