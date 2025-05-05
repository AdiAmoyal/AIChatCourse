//
//  SettingsView.swift
//  AIChatCourse
//
//  Created by Adi Amoyal on 05/05/2025.
//

import SwiftUI

struct SettingsView: View {
    
    @Environment(\.dismiss) private var dissmis
    @Environment(AppState.self) private var appState
    
    var body: some View {
        NavigationStack {
            List {
                Button {
                    onSignOutPressed()
                } label: {
                    Text("Sign out")
                }
            }
            .navigationTitle("Settings")
        }
    }
    
    func onSignOutPressed() {
        // Do some logic to sign user out of app
        dissmis()
        
        Task {
            try? await Task.sleep(for: .seconds(1))
            appState.updateViewState(showTabBarView: false)
        }
    }
}

#Preview {
    SettingsView()
        .environment(AppState())
}
