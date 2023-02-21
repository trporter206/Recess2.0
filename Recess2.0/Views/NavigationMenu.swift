//
//  NavigationMenu.swift
//  Recess2.0
//
//  Created by Torri Ray Porter Jr on 2023-02-19.
//

import SwiftUI

struct NavigationMenu: View {
    @StateObject var dataManager = DataManager()
    var body: some View {
        TabView {
            Dashboard()
                .tabItem { Label ("Dashboard", systemImage: "globe")}
            ClubList()
                .tabItem { Label ("Explore", systemImage: "list.bullet")}
        }
        .environmentObject(dataManager)
    }
}

struct NavigationMenu_Previews: PreviewProvider {
    static var previews: some View {
        NavigationMenu(dataManager: DataManager())
    }
}
