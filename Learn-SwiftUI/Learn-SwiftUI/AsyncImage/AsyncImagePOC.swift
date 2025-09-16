//
//  AsyncImagePOC.swift
//  Learn-SwiftUI
//
//  Created by Piyush Rathi on 16/09/25.
//

import SwiftUI

struct AsyncImagePOC: View {
    
    private let imageName = "https://cdn.jim-nielsen.com/ios/1024/apple-developer-2020-02-10.png?rf=1024"
    
    var body: some View {
        VStack {
            Text("Async Image")
                .font(.title)
                .foregroundStyle(
                    .linearGradient(colors: [.cyan, .pink, .blue], startPoint: .topLeading, endPoint: .bottomTrailing)
                )
                .padding()
            
            //MARK: - Loading Async Image
            // AsyncImage(url: URL(string: imageName)!)
            
            //MARK: - Load Async Image with Scale
            // AsyncImage(url: URL(string: imageName)!, scale: 3.0)
            
            //MARK: - More Async Image with Placeholder
            //        AsyncImage(url: URL(string: imageName)!) { image in
            //            image
            //                .resizable()
            //                .scaledToFit()
            //        } placeholder : {
            //            Image(systemName: "photo.circle.fill")
            //                .resizable()
            //                .scaledToFit()
            //                .frame(maxWidth: 128)
            //                .foregroundColor(.cyan)
            //                .opacity(0.5)
            //        }
            
            //MARK: - Async Image with Phase
            //        AsyncImage(url: URL(string: imageName)!) { phase in
            //            switch phase {
            //                case .success(let image):
            //                    image
            //                    .imageModifiers()
            //                case .failure:
            //                    Image(systemName: "ant.circle.fill")
            //                    .iconModifier()
            //                case .empty:
            //                    Image(systemName: "photo.circle.fill")
            //                    .iconModifier()
            //                @unknown default:
            //                    ProgressView()
            //            }
            //        }
            
            //MARK: - Async Image with Animations
            AsyncImage(url: URL(string: imageName),
                       transaction: Transaction(animation: .spring(response: 0.6, dampingFraction: 0.6, blendDuration: 0.25))) { phase in
                switch phase {
                case .success(let image):
                    image
                        .imageModifiers()
                        .transition(.scale)
                case .failure:
                    Image(systemName: "ant.circle.fill")
                        .iconModifier()
                case .empty:
                    Image(systemName: "photo.circle.fill")
                        .iconModifier()
                @unknown default:
                    ProgressView()
                }
            }
            .padding(40)
        }
    }
}


#Preview {
    AsyncImagePOC()
}

//MARK: - Extension
extension Image {
    func imageModifiers() -> some View {
        self
            .resizable()
            .scaledToFit()
    }
    
    func iconModifier() -> some View {
        self
            .imageModifiers()
            .foregroundColor(.cyan)
            .frame(maxWidth: 128)
            .opacity(0.5)
    }
}
