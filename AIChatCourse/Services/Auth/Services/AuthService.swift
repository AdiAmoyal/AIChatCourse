//
//  AuthService.swift
//  AIChatCourse
//
//  Created by Adi Amoyal on 11/05/2025.
//
import SwiftUI

extension EnvironmentValues {
    @Entry var authService: AuthService = MockAuthService()
}

protocol AuthService: Sendable {
    func getAuthenticatedUser() -> UserAuthInfo?
    func sighInAnonymously() async throws -> (user: UserAuthInfo, isNewUser: Bool)
    func signInApple() async throws -> (user: UserAuthInfo, isNewUser: Bool)
    func signOut() throws
    func deleteAccount() async throws
}
