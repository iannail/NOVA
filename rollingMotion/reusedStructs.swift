//
//  update.swift
//  rollingMotion
//
//  Created by Ian Nail on 12/26/23.
//

import SwiftUI

enum myViewOptions {
    case gameMenu
    case gameZen
    case game3
    case game4
    case game5
}

class myViewinfo: ObservableObject {
    
    @Published var myViewOptions: myViewOptions = .gameZen
}

//******** Reuseable Button ******** //
struct classic_button: View {
    
    var buttonWidth: CGFloat
    var buttonHeight: CGFloat
    var fontSize: CGFloat = 28
    var name: String? // Optional string for text-based button
    var systemImageName: String? // Optional string for systemImage-based button
    var buttonColor: Color = .black
    var fontColor: Color = .white
    var action: () -> Void
    
    var body: some View {
        Button(action: {
            // Action to perform when the button is tapped
            action()
        }) {
            // Conditionally display Text or Image based on available content
                        if let name = name {
                            Text(name)
                                .frame(width: buttonWidth, height: buttonHeight, alignment: .leading)
                                .padding()
                                .font(.system(size: fontSize))
                                .foregroundColor(fontColor) // Set text color
                                .background(buttonColor) // Set background color
                                //.cornerRadius(10)
                            
                        } else if let systemImageName = systemImageName {
                            Image(systemName: systemImageName)
                                .font(.largeTitle)
                                .frame(width: buttonWidth, height: buttonHeight)
                                .padding()
                                .foregroundColor(fontColor) // Set text color
                                .background(buttonColor) // Set background color
                                //.cornerRadius(10)
                        }

        }
    }
}

//******** Background ******** //
struct app_background: View {
    var imageName: String
    
    var body: some View {
        Image(imageName)
            .resizable()
            .scaledToFill()
            .edgesIgnoringSafeArea(.all)
            .opacity(0.8)
            
    }
}
