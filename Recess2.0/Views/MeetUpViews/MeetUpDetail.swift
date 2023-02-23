//
//  MeetUpDetail.swift
//  Recess2.0
//
//  Created by Torri Ray Porter Jr on 2023-02-19.
//

import SwiftUI

struct MeetUpDetail: View {
    @EnvironmentObject var dM: DataManager
    @Binding var meetUp: MeetUp
    
    var body: some View {
        VStack {
            DetailHeader(title: "\(meetUp.getSport()) Meet Up",
                         footer: "Host: \(meetUp.getHost().getName())",
                         note: meetUp.getDate().formatted(),
                         truestring: "Gear Needed",
                         falsestring: "No Gear Needed",
                         ifBool: meetUp.getGearNeeded())
            Text(meetUp.getAbout()).padding()
            Text("Players Going (\(meetUp.getPlayers().count))")
            ForEach(meetUp.getPlayers()) { player in
                PlayerListItem(player: player)
            }
            Spacer()
            JoinMeetUpButton(meetUp: $meetUp)
        }
        .padding()
    }
}

struct MeetUpDetail_Previews: PreviewProvider {
    static var previews: some View {
        MeetUpDetail(meetUp: .constant(DataManager().meetUps[0])).environmentObject(DataManager())
    }
}

extension MeetUpDetail {
    func binding(for player: User) -> Binding<User> {
        guard let index = dM.users.firstIndex(of: player) else {
            fatalError("Meetup not found")
        }
        return $dM.users[index]
    }
}
