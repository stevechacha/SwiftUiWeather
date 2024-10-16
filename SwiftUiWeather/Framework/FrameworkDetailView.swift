//
//  FrameworkDetailView.swift
//  SwiftUiWeather
//
//  Created by stephen chacha on 21/09/2024.
//

import SwiftUI

struct FrameworkDetailView: View {
    var framework: Framework
    @Binding var isShowingDetailView: Bool
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Button(action: {isShowingDetailView = false}, label: {
                   Image(systemName: "xmark")
                        .foregroundColor(Color(.label))
                        .imageScale(.large)
                        .frame(width: 44, height: 44)
                })
            }.padding()
            
            Spacer()
            
            FrameworkTitleView(framework: framework)
            Text(framework.description)
                .font(.body)
                .padding()
            
            Spacer()
        }
    }
}

#Preview {
    FrameworkDetailView(framework: Framework(name: "String", imageUrl: "String", urlString: "String", description: "String"), isShowingDetailView: .constant(false))
}
