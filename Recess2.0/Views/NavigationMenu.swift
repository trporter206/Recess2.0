//
//  NavigationMenu.swift
//  Recess2.0
//
//  Created by Torri Ray Porter Jr on 2023-02-19.
//

import SwiftUI

struct NavigationMenu: View {
    @EnvironmentObject var dM: DataManager
    var body: some View {
        TabView {
            Dashboard()
                .tabItem { Label ("Dashboard", systemImage: "globe")}
            Explore()
                .tabItem { Label ("Explore", systemImage: "list.bullet")}
            UserProfile()
                .tabItem { Label ("Profile", systemImage: "person")}
        }
        .environmentObject(dM)
    }
}

struct NavigationMenu_Previews: PreviewProvider {
    static var previews: some View {
        NavigationMenu().environmentObject(DataManager())
    }
}
