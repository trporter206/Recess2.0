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
            Text("\(meetUp.getSport()) Meet Up").font(.title)
            Text("Host: \(meetUp.getHost().getName())").font(.subheadline)
            HStack {
                Text(meetUp.getDate().formatted())
                Spacer()
                if meetUp.getGearNeeded() {
                    Text("Gear Needed")
                } else {
                    Text("No Gear Needed")
                }
            }
            .padding()
            Divider().padding([.leading, .trailing])
            Text(meetUp.getAbout()).padding()
            Text("Players Going (\(meetUp.getPlayers().count))")
            ForEach(meetUp.getPlayers()) { player in
                Text(player.getName())
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
