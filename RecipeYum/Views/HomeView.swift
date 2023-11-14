//
//  HomeView.swift
//  RecipeYum
//
//  Created by Isaac Rudy on 2023-10-06.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var viewModel = ImageListViewModel()
    @State private var searchText = ""
    @State private var favorites: Set<UUID> = []

    private var gridView: some View {
        let columns = [
            GridItem(.flexible()),
            GridItem(.flexible())
        ]

        return LazyVGrid(columns: columns) {
            ForEach(viewModel.images) { image in
                NavigationLink(destination: ImageDetailPage(imageModel: image)) {
                    ImageView(imageURL: image.imageURL, title: image.label, isFavorite: favoriteBinding(for: image.id))
                        .cornerRadius(10)
                        .padding(8)
                }
            }
        }
    }

    var body: some View {
        NavigationView {
            ScrollView {
                gridView
            }
            .navigationTitle("Today's Meals")
            .searchable(text: $searchText, prompt: "Search food...")
            .onChange(of: searchText) { newValue in
                if newValue.isEmpty {
                    viewModel.fetchRandomImages()
                } else {
                    viewModel.fetchRecipes(for: newValue)
                }
            }
            .onAppear {
                if searchText.isEmpty {
                    viewModel.fetchRandomImages()
                }
            }
        }
    }

    private func favoriteBinding(for id: UUID) -> Binding<Bool> {
        Binding<Bool>(
            get: { self.favorites.contains(id) },
            set: { isFavorite in
                if isFavorite {
                    self.favorites.insert(id)
                } else {
                    self.favorites.remove(id)
                }
            }
        )
    }
}




#Preview {
    HomeView()
}
