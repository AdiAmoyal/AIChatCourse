//
//  AsyncCallToAcrionButton.swift
//  AIChatCourse
//
//  Created by Adi Amoyal on 08/05/2025.
//

import SwiftUI

struct AsyncCallToAcrionButton: View {
    
    var isLoading: Bool = false
    var title: String = "Save"
    var action: () -> Void
    
    var body: some View {
        ZStack {
            if isLoading {
                ProgressView()
                    .tint(.white)
            } else {
                Text(title)
            }
        }
        .callToActionButton()
        .anyButton(.press) {
            action()
        }
        .disabled(isLoading)
    }
}

#Preview {
    AsyncCallToAcrionButton(isLoading: false, title: "Save") {
        
    }
}
