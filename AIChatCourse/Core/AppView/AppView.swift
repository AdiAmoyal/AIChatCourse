//
//  AppView.swift
//  AIChatCourse
//
//  Created by Adi Amoyal on 05/05/2025.
//

import SwiftUI

// tabbar - signed in
// onboarding - signed out

struct AppView: View {
    
    @Environment(\.authService) private var authService
    @State var appState: AppState = AppState()
    
    var body: some View {
        AppViewBuilder(
            showTabBar: appState.showTabBar,
            tabbarView: {
                TabBarView()
            },
            onboardingView: {
                WelcomeView()
            }
        )
        .environment(appState)
        .task {
            await checkUserStatus()
        }
        .onChange(of: appState.showTabBar) { _, showTabBar in
            if !showTabBar {
                Task {
                    await checkUserStatus()
                }
            }
        }
    }
    
    private func checkUserStatus() async {
        if let user = authService.getAuthenticatedUser() {
            // User is authenticated
            print("User already authenticated: \(user.uid)")
        } else {
            // User is not authenticated
            do {
                let result = try await authService.sighInAnonymously()
                
                // log in to app
                print("Sign in anonympus success: \(result.user.uid)")
            } catch let error {
                print(error)
            }
        }
    }
}

#Preview("AppView - TabBar") {
    AppView(appState: AppState(showTabBar: true))
}

#Preview("AppView - Onboarding") {
    AppView(appState: AppState(showTabBar: false))
}
