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
    @State var joinedClubs = Array<Club>()
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack {
            Text("Create New Activity")
                .padding()
            if dM.currentUser.getNumJoinedClubs() > 0 {
                Toggle("Club meet up?", isOn: $newMeetUpData.clubMeet)
                    .toggleStyle(.switch)
                    .padding()
                if newMeetUpData.clubMeet {
                    Text("Host Club")
                    Picker("Host Club", selection: $newMeetUpData.hostClub) {
                        ForEach(joinedClubs, id: \.self) { club in
                            Text(club.getName()).tag(club as Club?)
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
                }
            }
            TextField("Sport", text: $newMeetUpData.sport )
                .padding()
            TextField("Brief Description", text: $newMeetUpData.about)
                .padding()
            DatePicker("Time", selection: $newMeetUpData.date, in: Date.now...Date.now.addingTimeInterval(1209600))
                .padding()
            Toggle("Bring your own gear?", isOn: $newMeetUpData.gearNeeded)
                .toggleStyle(.switch)
                .padding()
            Button(action: {
                let mu = MeetUp(data: newMeetUpData, dataManager: dM)
                dM.meetUps.append(mu)
                dM.currentUser.addMeetUp(mu: mu)
                dM.currentUser.addToMeetUpHosted()
                if mu.getClubMeet() {
                    let club = binding(for: mu.getHostClub()!)
                    club.wrappedValue.addMeetUp(meetUp: mu)
                }
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
        .onAppear {
            Task {
                joinedClubs = await dM.currentUser.getJoinedClubs()
            }
        }
    }
}

struct CreateMeetUpForm_Previews: PreviewProvider {
    static var previews: some View {
        CreateMeetUpForm().environmentObject(DataManager())
    }
}

extension CreateMeetUpForm {
    func binding(for club: Club) -> Binding<Club> {
        guard let index = dM.clubs.firstIndex(of: club) else {
            fatalError("Club not found")
        }
        return $dM.clubs[index]
    }
}
