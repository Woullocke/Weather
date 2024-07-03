import Foundation
import CoreLocation


class SunriseSunsetManager {
    func getSunriseSunset(latitude: Double, longitude: Double, completion: @escaping (Result<SunriseSunsetResponse, Error>) -> Void) {
        let baseURL = "https://api.sunrisesunset.io/json"
        let urlString = "\(baseURL)?lat=\(latitude)&lng=\(longitude)"
        
        guard let url = URL(string: urlString) else {
            completion(.failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil)))
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "No data", code: 0, userInfo: nil)))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let response = try decoder.decode(SunriseSunsetResponse.self, from: data)
                completion(.success(response))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
    
    func getSunriseSunsetAsync(latitude: Double, longitude: Double) async throws -> SunriseSunsetResponse {
        try await withCheckedThrowingContinuation { continuation in
            getSunriseSunset(latitude: latitude, longitude: longitude) { result in
                switch result {
                case .success(let response):
                    continuation.resume(returning: response)
                case .failure(let error):
                    continuation.resume(throwing: error)
                }
            }
        }
    }
}

struct SunriseSunsetResponse: Decodable {
    var results: Results
    var status: String
}

struct Results: Decodable {
    var sunrise: String
    var sunset: String
    var solarNoon: String
}
