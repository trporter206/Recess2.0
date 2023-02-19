//
//  Dashboard.swift
//  Recess2.0
//
//  Created by Torri Ray Porter Jr on 2023-02-19.
//

import SwiftUI

struct Dashboard: View {
    @ObservedObject var dataManager: DataManager
    var body: some View {
        NavigationView {
            VStack {
                Text("Hello, \(dataManager.currentUser.getName())").padding()
                Text("Your scheduled activities (\(dataManager.currentUser.getScheduledMeetUps().count))").padding([.top])
                NavigationLink(destination: CreateMeetUpForm(dataManager: dataManager), label: {
                    Text("Create Activity").padding([.bottom])
                })
                ForEach(dataManager.currentUser.getScheduledMeetUps(), id: \.self) { meetup in
                    NavigationLink(destination: MeetUpDetail(dataManager: dataManager, meetUp: meetup), label: {
                        Text(meetup.getSport()).padding([.bottom]).foregroundColor(.black)
                    })
                }
            }
        }
    }
}

struct Dashboard_Previews: PreviewProvider {
    static var previews: some View {
        Dashboard(dataManager: DataManager())
    }
}
