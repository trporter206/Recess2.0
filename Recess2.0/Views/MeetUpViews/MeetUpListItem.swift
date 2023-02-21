//
//  MeetUpListItem.swift
//  Recess2.0
//
//  Created by Torri Ray Porter Jr on 2023-02-20.
//

import SwiftUI

struct MeetUpListItem: View {
    @EnvironmentObject var dm: DataManager
    @Binding var meetUp: MeetUp
    
    var body: some View {
        NavigationLink(destination: MeetUpDetail(meetUp: meetUp), label: {
            VStack (alignment: .leading) {
                Text(meetUp.getSport())
                    .font(.title3)
                    .foregroundColor(.black)
                Text("Players: \(meetUp.getPlayers().count)")
                    .font(.subheadline)
                    .foregroundColor(.black)
            }
            .padding()
        })
        .padding()
        .border(.black, width: 2)
    }
}

struct MeetUpListItem_Previews: PreviewProvider {
    static var previews: some View {
        MeetUpListItem(meetUp: .constant(DataManager().meetUps[0])).environmentObject(DataManager())
    }
}
