//
//  menuView.swift
//  rollingMotion
//
//  Created by Ian Nail on 12/29/23.
//

import SwiftUI

struct menuView: View {
    @ObservedObject var myMotionInfo: myMotionInfo
    @ObservedObject var myViewinfo: myViewinfo
    
    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
            VStack {
                HStack {
                    classic_button(buttonWidth: 40, buttonHeight: 40, fontSize: 32, systemImageName: "line.3.horizontal", buttonColor: .black, fontColor: .white ){
                        myViewinfo.myViewOptions = .menuView
                    }
                    .padding(20)
                    Spacer()
                    classic_button(buttonWidth: 40, buttonHeight: 40, fontSize: 32, name: "x", buttonColor: .black, fontColor: .white ){
                        
                        myViewinfo.myViewOptions = .zenView
                    }
                    .padding()
                    
                }
                HStack {
                    classic_button(buttonWidth: 200, buttonHeight: 30, fontSize: 24, name: "Zen", buttonColor: .black, fontColor: .white ){
                        myViewinfo.myViewOptions = .zenView
                    }
                    .padding(20)
                    Spacer()
                    
                }
                
                HStack {
                    classic_button(buttonWidth: 200, buttonHeight: 30, fontSize: 24, systemImageName: "gear", buttonColor: .black, fontColor: .white ){
                        myViewinfo.myViewOptions = .settingsView
                    }
                    .padding(20)
                    
                    Spacer()
                }
                Spacer()
            }
            .transition(AnyTransition.opacity.animation(.easeInOut(duration: 1.0)))
        }
    }
}

#Preview {
    menuView(myMotionInfo: myMotionInfo(), myViewinfo: myViewinfo())
}
