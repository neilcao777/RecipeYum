//
//  ContentView.swift
//  RecipeYum
//
//  Created by Atsuki on 2023-10-02.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            HomeView().tabItem {
                Image(systemName: "house.circle.fill")
                Text("Home")
            }
            ListView().tabItem {
                Image(systemName: "frying.pan.fill")
                Text("My Recipes")
            }
            AccountView().tabItem {
                Image(systemName: "person.crop.circle.fill")
                Text("Account")
            }
        }
    }
}

#Preview {
    ContentView()
}
