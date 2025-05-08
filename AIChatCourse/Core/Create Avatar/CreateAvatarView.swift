//
//  CreateAvatarView.swift
//  AIChatCourse
//
//  Created by Adi Amoyal on 08/05/2025.
//

import SwiftUI

struct CreateAvatarView: View {
    
    @Environment(\.dismiss) private var dismiss
    @State private var avatarName: String = ""
    @State private var characterOption: CharacterOption = .default
    @State private var characterAction: CharacterAction = .default
    @State private var characterLocation: CharacterLocation = .default
    
    @State private var isGenerating: Bool = false
    @State private var generatedImage: UIImage?
    
    @State private var isSaving: Bool = false

    var body: some View {
        NavigationStack {
            List {
                nameSection
                attributesSection
                imageSection
                saveSection
            }
            .navigationTitle("Create Avatar")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    backButton
                }
            }
        }
    }
    
    private var backButton: some View {
        Image(systemName: "xmark")
            .font(.title2)
            .fontWeight(.semibold)
            .anyButton {
                dismiss()
            }
    }
    
    private var nameSection: some View {
        Section(content: {
            TextField("Player 1", text: $avatarName)
        }, header: {
            Text("Name Your Avatar *")
        })
    }
    
    private var attributesSection: some View {
        Section {
            Picker(selection: $characterOption) {
                ForEach(CharacterOption.allCases, id: \.self) { option in
                    Text(option.rawValue.capitalized)
                }
            } label: {
                Text("is a...")
            }
            
            Picker(selection: $characterAction) {
                ForEach(CharacterAction.allCases, id: \.self) { option in
                    Text(option.rawValue.capitalized)
                }
            } label: {
                Text("that is...")
            }
            
            Picker(selection: $characterLocation) {
                ForEach(CharacterLocation.allCases, id: \.self) { option in
                    Text(option.rawValue.capitalized)
                }
            } label: {
                Text("in the...")
            }
        }
    }
    
    private var imageSection: some View {
        Section {
            HStack(alignment: .top, spacing: 8) {
                ZStack {
                    Text("Generate Image")
                        .underline()
                        .foregroundStyle(.accent)
                        .anyButton(.plain) {
                            onGenerateImagePressed()
                        }
                        .opacity(isGenerating ? 0 : 1)
                    
                    ProgressView()
                        .tint(.accentColor)
                        .opacity(isGenerating ? 1 : 0)
                }
                .disabled(isGenerating || avatarName.isEmpty)
                
                Circle()
                    .fill(.secondary.opacity(0.3))
                    .overlay {
                        ZStack {
                            if let generatedImage {
                                Image(uiImage: generatedImage)
                                    .resizable()
                                    .scaledToFill()
                            }
                        }
                    }
                    .clipShape(Circle())
                
            }
            .removeListRowFormatting()
        }
    }
    
    private var saveSection: some View {
        Section {
            AsyncCallToAcrionButton(
                isLoading: isSaving,
                title: "Save",
                action: onSaveImagePressed
            )
            .removeListRowFormatting()
            .padding(.top, 24)
            .opacity(generatedImage == nil ? 0.5 : 1.0)
        }
    }
    
    private func onBackButtonPressed() {
        dismiss()
    }
    
    private func onGenerateImagePressed() {
        isGenerating = true
        
        Task {
            try await Task.sleep(for: .seconds(3))
            generatedImage = UIImage(systemName: "star.fill")
            isGenerating = false
        }
    }
    
    private func onSaveImagePressed() {
        isSaving = true
        
        Task {
            try await Task.sleep(for: .seconds(3))
            dismiss()
            isSaving = false
        }
    }
}

#Preview {
    CreateAvatarView()
}
