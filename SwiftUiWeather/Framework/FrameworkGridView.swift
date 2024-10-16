//
//  FrameworkGridView.swift
//  SwiftUiWeather
//
//  Created by stephen chacha on 21/09/2024.
//

import SwiftUI

struct FrameworkGridView: View {
    @StateObject var viewModel = FrameworkGridViewModel()
    let columns: [GridItem] = [GridItem(.flexible()),
                               GridItem(.flexible()),
                               GridItem(.flexible())]
    

    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: columns) {
                    ForEach(MockData.mockFrameworks){ framework in
                        FrameworkTitleView(framework: framework)
                            .onTapGesture {
                                viewModel.selectedFramework = framework
                            }
                    }
                }
            }.navigationTitle("FrameWork")
                .sheet(isPresented: $viewModel.isShowingDetailView) {
                    FrameworkDetailView(framework: viewModel.selectedFramework ?? MockData.sampleData,isShowingDetailView: $viewModel.isShowingDetailView)
                }
                        
        }
    }
}

#Preview {
    FrameworkGridView()
}

struct Framework: Hashable ,Identifiable{
    let id = UUID()
    let name: String
    let imageUrl: String
    let urlString: String
    let description: String
}

struct MockData {
   static let sampleData  = Framework(
        name: "SwiftUI",
        imageUrl: "https://developer.apple.com/assets/elements/icons/swiftui/swiftui-96x96_2x.png",
        urlString: "https://developer.apple.com/documentation/swiftui",
        description: "SwiftUI helps you build great-looking apps across all Apple platforms with the power of Swift."
    )
    
   static let mockFrameworks: [Framework] = [
        Framework(
            name: "SwiftUI",
            imageUrl: "https://developer.apple.com/assets/elements/icons/swiftui/swiftui-96x96_2x.png",
            urlString: "https://developer.apple.com/documentation/swiftui",
            description: "SwiftUI helps you build great-looking apps across all Apple platforms with the power of Swift."
        ),
        Framework(
            name: "Combine",
            imageUrl: "https://developer.apple.com/assets/elements/icons/combine/combine-96x96_2x.png",
            urlString: "https://developer.apple.com/documentation/combine",
            description: "Combine is a framework that provides a declarative Swift API for processing values over time."
        ),
        Framework(
            name: "Core Data",
            imageUrl: "https://developer.apple.com/assets/elements/icons/coredata/coredata-96x96_2x.png",
            urlString: "https://developer.apple.com/documentation/coredata",
            description: "Core Data is Apple’s framework for managing object graphs and persisting data in iOS and macOS apps."
        ),
        Framework(
            name: "ARKit",
            imageUrl: "https://developer.apple.com/assets/elements/icons/arkit/arkit-96x96_2x.png",
            urlString: "https://developer.apple.com/documentation/arkit",
            description: "ARKit combines device motion tracking, camera scene capture, and advanced rendering techniques to bring augmented reality to your app."
        ),
        Framework(
            name: "CloudKit",
            imageUrl: "https://developer.apple.com/assets/elements/icons/cloudkit/cloudkit-96x96_2x.png",
            urlString: "https://developer.apple.com/documentation/cloudkit",
            description: "CloudKit allows apps to store data in iCloud and keep data up-to-date across all of a user's devices.")
]
}
struct FrameworkTitleView : View {
    let framework: Framework
    var body: some View {
        VStack {
            Image(framework.imageUrl)
                .resizable()
                .frame(width: 90, height: 90)
            Text(framework.name)
                .font(.title2)
                .fontWeight(.semibold)
                .scaledToFit()
                .minimumScaleFactor(0.6)
            
        }
    }
}
