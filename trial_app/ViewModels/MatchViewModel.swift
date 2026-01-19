import Foundation
import Combine

class MatchViewModel: ObservableObject {

    @Published var matches: [Match] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?

    func loadMatches() {
        isLoading = true

        FootballAPIService.shared.fetchLiveMatches { result in
            DispatchQueue.main.async(execute: {
                self.isLoading = false

                switch result {
                case .success(let matches):
                    self.matches = matches
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                }
            })
        }
    }
}
    