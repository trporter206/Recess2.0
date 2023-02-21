//
//  MeetUpList.swift
//  Recess2.0
//
//  Created by Torri Ray Porter Jr on 2023-02-20.
//

import SwiftUI

struct MeetUpList: View {
    @EnvironmentObject var dataManager: DataManager
    
    var body: some View {
        NavigationView {
            VStack {
                ForEach(dataManager.meetUps, id: \.self) { meetup in
                    NavigationLink(destination: MeetUpDetail(meetUp: meetup), label: {
                        Text(meetup.getSport())
                            .foregroundColor(.black)
                            .padding([.bottom])
                    })
                }
            }
        }
    }
}

struct MeetUpList_Previews: PreviewProvider {
    static var previews: some View {
        MeetUpList().environmentObject(DataManager())
    }
}
