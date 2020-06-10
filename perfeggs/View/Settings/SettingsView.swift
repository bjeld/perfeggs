//
//  SettingsView.swift
//  perfeggs
//
//  Created by Martin Bjeld on 23/04/2020.
//  Copyright © 2020 Martin Bjeld. All rights reserved.
//

import SwiftUI

struct SettingsView: View {
    
    @EnvironmentObject var settingsStore:SettingsStore
    @Binding var isPresented: Bool
    
    var body: some View {
        NavigationView {
            VStack {
                Form {
                    Section(header: Text("Egg boil timer settings")) {
                        Picker(
                            selection: $settingsStore.eggBoilMode,
                            label: Text("Timer")
                        ) {
                            ForEach(SettingsStore.EggBoilMode.allCases, id: \.self) {
                                Text($0.rawValue).tag($0)
                            }
                        }
                    }
                    
                    Section(header: Text("Egg storage settings")) {
                        Picker(
                            selection: $settingsStore.eggStorageMode,
                            label: Text("Storage")
                        ) {
                            ForEach(SettingsStore.EggStorageMode.allCases, id: \.self) {
                                Text($0.rawValue).tag($0)
                            }
                        }
                        
                    }
                    
                    Section(header: Text("About")){
                        
                        HStack {
                            Text("Name")
                            Spacer()
                            Text("Perfeggs")
                        }
                        HStack {
                            Text("Version")
                            Spacer()
                            Text("0.1.1")
                        }
                        
                    }
                }.environment(\.horizontalSizeClass, .regular)
            }.navigationBarTitle("Settings")
                .navigationBarItems(leading: Button(action: {
                    self.isPresented = false
                }, label: {
                    Text("Close")
                }))
            
            
        }.navigationViewStyle(StackNavigationViewStyle())
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(isPresented: .constant(true))
    }
}
