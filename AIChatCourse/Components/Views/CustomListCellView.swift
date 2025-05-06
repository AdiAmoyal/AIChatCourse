//
//  CustomListCellView.swift
//  AIChatCourse
//
//  Created by Adi Amoyal on 06/05/2025.
//

import SwiftUI

struct CustomListCellView: View {
    
    var imageName: String? = Constants.randonImage
    var title: String? = "Alpha"
    var subtitle: String? = "An alien that is smiling in the park."
    
    var body: some View {
        HStack {
            ZStack {
                if let imageName {
                    ImageLoaderView(urlString: imageName)
                } else {
                    Rectangle()
                        .fill(.secondary.opacity(0.5))
                }
            }
            .aspectRatio(1, contentMode: .fit)
            .frame(height: 60)
            .cornerRadius(16)
            
            VStack(alignment: .leading, spacing: 4) {
                if let title {
                    Text(title)
                        .font(.headline)
                }
                
                if let subtitle {
                    Text(subtitle)
                        .font(.subheadline)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding(12)
        .padding(.vertical, 4)
        .background(Color(uiColor: .systemBackground))
    }
}

#Preview {
    VStack {
        CustomListCellView()
            .frame(height: 65)
        
        CustomListCellView(imageName: nil)
            .frame(height: 65)
        
        CustomListCellView(title: nil)
            .frame(height: 65)
        
        CustomListCellView(subtitle: nil)
            .frame(height: 65)
    }
}
