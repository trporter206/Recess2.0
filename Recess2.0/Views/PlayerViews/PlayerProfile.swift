//
//  PlayerProfile.swift
//  Recess2.0
//
//  Created by Torri Ray Porter Jr on 2023-02-22.
//

import SwiftUI

struct PlayerProfile: View {
    @EnvironmentObject var dm: DataManager
    @Binding var player: User
    
    var body: some View {
        VStack {
            DetailHeader(title: player.getName(),
                         footer: player.getAbout(),
                         note: "Tier: \(player.getTier())",
                         truestring: player.getCity(),
                         falsestring: "",
                         ifBool: {player.id != nil}())
        }
    }
}

struct PlayerProfile_Previews: PreviewProvider {
    static var previews: some View {
        PlayerProfile(player: .constant(DataManager().currentUser))
    }
}
