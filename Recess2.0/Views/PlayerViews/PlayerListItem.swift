//
//  PlayerListItem.swift
//  Recess2.0
//
//  Created by Torri Ray Porter Jr on 2023-02-22.
//

import SwiftUI

struct PlayerListItem: View {
    @EnvironmentObject var dM: DataManager
    var player: User
    
    var body: some View {
        VStack {
            NavigationLink(destination: PlayerProfile(player: binding(for: player)), label: {
                Text(player.getName())
            })
        }
    }
}

struct PlayerListItem_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            PlayerListItem(player: DataManager().users[0])
        }
    }
}

extension PlayerListItem {
    func binding(for player: User) -> Binding<User> {
        guard let index = dM.users.firstIndex(of: player) else {
            fatalError("Meetup not found")
        }
        return $dM.users[index]
    }
}
