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
    
    @Environment(AuthManager.self) private var authManager
    @Environment(UserManager.self) private var userManager
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
        if let user = authManager.auth {
            // User is authenticated
            print("User already authenticated: \(user.uid)")
            
            do {
                try await userManager.logIn(auth: user, isNewUser: false)
            } catch {
                print("Failed to login to auth for existing user \(error)")
                try? await Task.sleep(for: .seconds(5))
                await checkUserStatus()
            }
        } else {
            // User is not authenticated
            do {
                let result = try await authManager.sighInAnonymously()
                // log in to app
                try await userManager.logIn(auth: result.user, isNewUser: result.isNewUser)

                print("Sign in anonympus success: \(result.user.uid)")
            } catch let error {
                print("Failed to sign in anonymously and log in \(error)")
                try? await Task.sleep(for: .seconds(5))
                await checkUserStatus()
            }
        }
    }
}

#Preview("AppView - TabBar") {
    AppView(appState: AppState(showTabBar: true))
        .environment(AuthManager(service: MockAuthService(user: .mock())))
        .environment(UserManager(service: MockUserService(user: .mock)))
}

#Preview("AppView - Onboarding") {
    AppView(appState: AppState(showTabBar: false))
        .environment(AuthManager(service: MockAuthService(user: nil)))
        .environment(UserManager(service: MockUserService(user: nil)))
}
