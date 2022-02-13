//
//  NetworkService.swift
//  MyCalendar
//
//  Created by Татьяна Мальчик on 11.02.2022.
//
import Foundation
import RealmSwift

class NetworkService {
    func requestGET(urlString: String, completion: @escaping (Result<TaskModelJSON, Error>) -> Void) {
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async {
                if let response = response {
                    print(response)
                }
                if error != nil {
                    print("Some erorr")
                    completion(.failure(error!))
                    return
                }
                guard let data = data else { return }
                do {
                    let dataTasks = try JSONDecoder().decode(TaskModelJSON.self, from: data)
                    completion(.success(dataTasks))
                } catch let jsonError {
                    print("Faild to decode JSON", jsonError)
                    completion(.failure(jsonError))
                }
            }
        }.resume()
    }
    
    func requestPOST(urlString: String, body: Data, completion: @escaping (Result<TaskModelJSON, Error>) -> Void) {
        guard let url = URL(string: urlString) else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = body
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let response = response {
                print(response)
            }
            if error != nil {
                print("Some erorr")
                completion(.failure(error!))
                return
            }
            guard let data = data else { return }
            do{
                let dataTasks = try JSONDecoder().decode(TaskModelJSON.self, from: data)
                completion(.success(dataTasks))
            } catch let jsonError {
                print("Faild to decode JSON", jsonError)
                completion(.failure(jsonError))
            }
        }.resume()
    }
}

