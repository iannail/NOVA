//
//  update.swift
//  rollingMotion
//
//  Created by Ian Nail on 12/26/23.
//

import SwiftUI

enum myViewOptions {
    case introView
    case quoteView
    case menuView
    case zenView
    case settingsView
    case tempView
}
enum myStateOptions {
    case oninit
    case startmovement
    case nothing
}

class myViewinfo: ObservableObject {
    
    @Published var myViewOptions: myViewOptions = .introView
    @Published var quoteIncrement: Int = 0
    @Published var myStateOptions: myStateOptions = .oninit
    
    @Published var poems = [
        "poem0",
        "poem1",
        "poem2",
        "poem3",
        "poem4",
        "poem5",
    ]
}

struct AppPhaseObserver: ViewModifier {
    let action: () -> Void
    @Environment(\.scenePhase) var scenePhase
    
    func body(content: Content) -> some View {
        content
            .onChange(of: scenePhase) {
                if scenePhase == .inactive || scenePhase == .background {
                    action()
                }
            }
    }
}

extension View {
    func appPhaseObserver(action: @escaping () -> Void) -> some View {
        modifier(AppPhaseObserver(action: action))
    }
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
                //.padding()
                    .font(.system(size: fontSize))
                    .foregroundColor(fontColor) // Set text color
                    .background(buttonColor) // Set background color
                //.cornerRadius(10)
                
            } else if let systemImageName = systemImageName {
                Image(systemName: systemImageName)
                    .font(.system(size: fontSize))
                    .frame(width: buttonWidth, height: buttonHeight, alignment: .leading)
                //.padding()
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
