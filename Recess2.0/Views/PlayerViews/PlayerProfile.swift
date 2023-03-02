//
//  PlayerProfile.swift
//  Recess2.0
//
//  Created by Torri Ray Porter Jr on 2023-02-22.
//

import SwiftUI

struct PlayerProfile: View {
    @EnvironmentObject var dM: DataManager
    @Binding var player: User
    @State var joinedClubs = Array<Club>()
    
    var body: some View {
        VStack {
            DetailHeader(title: player.getName(),
                         footer: player.getAbout(),
                         note: "Tier: \(player.getTier())",
                         truestring: player.getCity(),
                         falsestring: "",
                         ifBool: true)
            Text("Clubs Joined (\(player.getNumJoinedClubs()))")
            ForEach(joinedClubs, id: \.self) { club in
                ClubListItem(club: binding(for: club))
            }
            Spacer()
        }.onAppear {
            Task {
                joinedClubs = await player.getJoinedClubs()
            }
        }
    }
}

struct PlayerProfile_Previews: PreviewProvider {
    static var previews: some View {
        PlayerProfile(player: .constant(DataManager().currentUser))
    }
}

extension PlayerProfile {
    func binding(for club: Club) -> Binding<Club> {
        guard let index = dM.clubs.firstIndex(of: club) else {
            fatalError("Club not found")
        }
        return $dM.clubs[index]
    }
}
