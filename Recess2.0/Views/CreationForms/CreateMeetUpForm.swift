//
//  CreateMeetUpForm.swift
//  Recess2.0
//
//  Created by Torri Ray Porter Jr on 2023-02-19.
//

import SwiftUI

struct CreateMeetUpForm: View {
    @EnvironmentObject var dM: DataManager
    @State private var newMeetUpData = MeetUp.Data()
    @State private var showingAlert = false
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack {
            Text("Create New Activity")
                .padding()
            TextField("Sport", text: $newMeetUpData.sport )
                .padding()
            TextField("Brief Description", text: $newMeetUpData.about)
                .padding()
            TextField("Date", text: $newMeetUpData.date)
                .padding()
            Toggle("Bring your own gear?", isOn: $newMeetUpData.gearNeeded)
                .toggleStyle(.switch)
                .padding()
            Button(action: {
                let mu = MeetUp(host: dM.currentUser,
                                sport: newMeetUpData.sport,
                                about: newMeetUpData.about,
                                date: newMeetUpData.date,
                                gearNeeded: newMeetUpData.gearNeeded)
                dM.meetUps.append(mu)
                dM.currentUser.addMeetUp(mu: mu)
                dM.currentUser.addToMeetUpHosted()
                showingAlert = true
                self.presentationMode.wrappedValue.dismiss()
            }, label: {
                Text("Create Activity")
            })
            .alert("Activity Created", isPresented: $showingAlert) {
                Button("OK", role: .cancel){}
            }
        }
        .padding()
    }
}

struct CreateMeetUpForm_Previews: PreviewProvider {
    static var previews: some View {
        CreateMeetUpForm().environmentObject(DataManager())
    }
}
