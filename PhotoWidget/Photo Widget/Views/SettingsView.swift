//
//  SettingsView.swift
//  Photo Widget
//
//  Created by S3soft on 24/09/2020.
//

import SwiftUI

struct SettingsView: View {
    
    @EnvironmentObject var photosViewModel: PhotosViewModel
    
    @State var angle: Angle = Angle(degrees: 0)
    @State var modalHowTo = false
    
    @State var isRandom = Helper.getRandom()
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("")) {
                    HStack {
                        Text("Refresh")
                        Spacer()
                        TimerView()
                    }
                    
                    Toggle(isOn: $isRandom) {
                        Text("Show Random Order")
                    }
                    .onChange(of: isRandom) { value in
                        Helper.setRandom(tag: value)
                    }
                }
                
                Section(header: Text("")) {
                    // MARK: HOW TO
                    HStack {
                        Button(action: {
                            modalHowTo.toggle()
                        }) {
                            Text("How to add Widget?")
                                .padding(.vertical, 10)
                                .frame(minWidth: 0, maxWidth: .infinity)
                                .background(Color.clear)
                        }
                        .buttonStyle(PlainButtonStyle())
                        .sheet(isPresented: $modalHowTo) {
                            OnboardingView()
                        }
                    }
                    
                    // MARK: MAIL
                    HStack {
                        Button(action: {
                            openMail()
                        }) {
                            Text("Contact")
                                .frame(minWidth: 0, maxWidth: .infinity)
                                .padding(.vertical, 10)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                }
            }
            .navigationBarTitle("Settings")
        }
    }
}

func openMail() {
    if let url = URL(string: "mailto:\(mail_address)") {
        UIApplication.shared.open(url)
    }
}

