//
//  ChatRowCellView.swift
//  AIChatCourse
//
//  Created by Adi Amoyal on 07/05/2025.
//

import SwiftUI

struct ChatRowCellView: View {
    
    var imageName: String? = Constants.randonImage
    var headline: String? = "Alpha"
    var subheadline: String? = "This is the last message in the chat."
    var hasNewChat: Bool = true
    
    var body: some View {
        HStack(spacing: 8) {
            ZStack {
                if let imageName {
                    ImageLoaderView(urlString: imageName)
                } else {
                    Circle()
                        .fill(.secondary.opacity(0.5))
                }
            }
            .frame(width: 50, height: 50)
            .clipShape(Circle())
            
            
            VStack(alignment: .leading, spacing: 4) {
                if let headline {
                    Text(headline)
                        .font(.headline)
                }
                
                if let subheadline {
                    Text(subheadline)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            if hasNewChat {
                Text("NEW")
                    .font(.caption)
                    .bold()
                    .foregroundStyle(.white)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 6)
                    .background(Color.blue)
                    .cornerRadius(6)
            }
        }
        .padding(.vertical, 12)
        .padding(.horizontal, 8)
        .background(Color(uiColor: .systemBackground))
    }
}

#Preview {
    List {
        ChatRowCellView()
            .removeListRowFormatting()
        ChatRowCellView(hasNewChat: false)
            .removeListRowFormatting()
        ChatRowCellView(imageName: nil)
            .removeListRowFormatting()
        ChatRowCellView(headline: nil)
            .removeListRowFormatting()
    }
    
}
