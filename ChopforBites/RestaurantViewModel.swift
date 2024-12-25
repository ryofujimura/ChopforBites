//
//  RestaurantViewModel.swift
//  ChopforBites
//
//  Created by ryo fujimura on 2024/10/24.
//

import Foundation

class RestaurantViewModel: ObservableObject {
    @Published var restaurants: [Restaurant] = []

    private let apiKey = "<YOUR_YELP_API_KEY>"
    
    func searchRestaurants(query: String) {
        guard let url = URL(string: "https://api.yelp.com/v3/businesses/search?term=\(query)&location=New+York&limit=3") else {
            print("Invalid URL")
            return
        }

        var request = URLRequest(url: url)
        request.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")

        URLSession.shared.dataTask(with: request) { data, _, error in
            if let data = data {
                do {
                    let result = try JSONDecoder().decode(YelpSearchResponse.self, from: data)
                    DispatchQueue.main.async {
                        self.restaurants = result.businesses
                    }
                } catch {
                    print("Decoding error: \(error)")
                }
            }
        }.resume()
    }
}

struct YelpSearchResponse: Decodable {
    let businesses: [Restaurant]
}
