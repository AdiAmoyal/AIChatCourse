//
//  ProfileView.swift
//  AIChatCourse
//
//  Created by Adi Amoyal on 05/05/2025.
//

import SwiftUI

struct ProfileView: View {
    
    @Environment(UserManager.self) private var userManager
    
    @State private var showSettingsView: Bool = false
    @State private var showCreateAvatarView: Bool = false
    @State private var currentUser: UserModel?
    @State private var myAvatars: [AvatarModel] = []
    @State private var isLoading: Bool = true
    
    @State private var path: [NavigationPathOption] = []
    
    var body: some View {
        NavigationStack(path: $path) {
            List {
                myInfoSection
                myAvatarsSection
            }
                .navigationTitle("Profile")
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        settignsButton
                    }
                }
                .navigationDestinationForCoreModule(path: $path)
        }
        .sheet(isPresented: $showSettingsView) {
            SettingsView()
        }
        .fullScreenCover(isPresented: $showCreateAvatarView) {
            CreateAvatarView()
        }
        .task {
            await loadData()
        }
    }
    
    private func loadData() async {
        self.currentUser = userManager.currentUser
        
        try? await Task.sleep(for: .seconds(5))
        isLoading = false
        myAvatars = AvatarModel.mocks
    }
    
    private var myInfoSection: some View {
        Section {
            ZStack {
                Circle()
                    .fill(currentUser?.profileColorCalculated ?? .accent)
            }
            .frame(width: 100, height: 100)
            .frame(maxWidth: .infinity)
            .removeListRowFormatting()
        }
    }
    
    private var myAvatarsSection: some View {
        Section {
            if myAvatars.isEmpty {
                Group {
                    if isLoading {
                        ProgressView()
                    } else {
                        Text("Click + to create an avatar")
                    }
                }
                .padding(50)
                .frame(maxWidth: .infinity)
                .font(.body)
                .foregroundStyle(.secondary)
                .removeListRowFormatting()
            } else {
                ForEach(myAvatars, id: \.self) { avatar in
                    CustomListCellView(
                        imageName: avatar.profileImageName,
                        title: avatar.name,
                        subtitle: nil
                    )
                    .anyButton(.highlight) {
                        onAvatarPressed(avatar: avatar)
                    }
                    .removeListRowFormatting()
                }
                .onDelete(perform: onDeleteAvatar)
            }
        } header: {
            HStack(spacing: 0) {
                Text("My Avatars")
                Spacer()
                Image(systemName: "plus.circle.fill")
                    .font(.title)
                    .foregroundStyle(.accent)
                    .anyButton {
                        onNewAvatarButtonPressed()
                    }
            }
        }
    }
    
    private var settignsButton: some View {
        Image(systemName: "gear")
            .font(.headline)
            .foregroundStyle(.accent)
            .anyButton {
                onSettingsButtonPressed()
            }
    }
    
    private func onSettingsButtonPressed() {
        showSettingsView = true
    }
    
    private func onNewAvatarButtonPressed() {
        showCreateAvatarView = true
    }
    
    private func onDeleteAvatar(indexSet: IndexSet) {
        guard let index = indexSet.first else { return }
        myAvatars.remove(at: index)
    }
    
    private func onAvatarPressed(avatar: AvatarModel) {
        path.append(.chat(avatarId: avatar.avatarId))
    }
}

#Preview {
    ProfileView()
        .environment(AppState())
        .environment(UserManager(services: MockUserServices(user: .mock)))
}
