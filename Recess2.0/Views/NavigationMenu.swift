//
//  NavigationMenu.swift
//  Recess2.0
//
//  Created by Torri Ray Porter Jr on 2023-02-19.
//

import SwiftUI

struct NavigationMenu: View {
    @ObservedObject var dataManager: DataManager
    var body: some View {
        TabView {
            Dashboard(dataManager: dataManager)
                .tabItem { Label ("Dashboard", systemImage: "globe")}
            ClubList(dataManager: dataManager)
                .tabItem { Label ("Community", systemImage: "list.bullet")}
        }
    }
}

struct NavigationMenu_Previews: PreviewProvider {
    static var previews: some View {
        NavigationMenu(dataManager: DataManager())
    }
}
