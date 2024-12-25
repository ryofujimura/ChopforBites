//
//  ContentView.swift
//  ChopforBites
//
//  Created by ryo fujimura on 2024/10/24.
//

import SwiftUI

struct ContentView: View {
    @State private var query = ""
    @ObservedObject var viewModel = RestaurantViewModel()
    
    var body: some View {
        VStack {
                TextField("Search for food...", text: $query)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()

                Button("Search") {
                    viewModel.searchRestaurants(query: query)
                }
                .padding()

                List(viewModel.restaurants) { restaurant in
                    Text(restaurant.name)
                }
            }
            .padding()
    }
}

#Preview {
    ContentView()
}
