//
//  MeetUpDetail.swift
//  Recess2.0
//
//  Created by Torri Ray Porter Jr on 2023-02-19.
//

import SwiftUI
import FirebaseCore
import FirebaseFirestore
import FirebaseFirestoreSwift

struct MeetUpDetail: View {
    @EnvironmentObject var dM: DataManager
    @Binding var meetUp: MeetUp
    @State var host = User(id: "temp", name: "temp", city: "temp")
    @State var players = Array<User>()
    
    var body: some View {
        VStack {
            DetailHeader(title: "\(meetUp.getSport()) Meet Up",
                         footer: "Host: \(host.getName())",
                         note: meetUp.getDate().formatted(),
                         truestring: "Gear Needed",
                         falsestring: "No Gear Needed",
                         ifBool: meetUp.getGearNeeded())
            Text(meetUp.getAbout()).padding()
            Text("Players Going (\(meetUp.getNumPlayers()))")
            ForEach(players) { player in
//                PlayerListItem(player: player)
                Text(player.getName())
            }
            Spacer()
            if host.getID() != dM.currentUser.getID() {
                JoinMeetUpButton(meetUp: $meetUp, players: $players)
            }
        }
        .padding()
        .onAppear {
            let meetUpRef = Firestore.firestore().collection("MeetUps")
            meetUpRef.document(meetUp.getID()).addSnapshotListener { documentSnapshot, error in
                do {
                    meetUp = try documentSnapshot!.data(as: MeetUp.self)
                } catch {
                    print(error)
                }
            }
            Task {
                players = await meetUp.getPlayers()
                host = await meetUp.getHost()
            }
        }
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
