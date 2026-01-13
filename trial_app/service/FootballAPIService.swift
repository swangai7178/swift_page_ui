import Foundation

class FootballAPIService {

    static let shared = FootballAPIService()

    private let apiKey = "YOUR_API_KEY_HERE"

    func fetchLiveMatches(completion: @escaping (Result<[Match], Error>) -> Void) {

        let urlString = "https://api.example.com/live-matches"
        guard let url = URL(string: urlString) else { return }

        var request = URLRequest(url: url)
        request.setValue(apiKey, forHTTPHeaderField: "X-API-KEY")

        URLSession.shared.dataTask(with: request) { data, response, error in

            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else { return }

            do {
                let matches = try JSONDecoder().decode([Match].self, from: data)
                completion(.success(matches))
            } catch {
                completion(.failure(error))
            }

        }.resume()
    }
}
