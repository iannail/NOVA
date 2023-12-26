//
//  settingsView.swift
//  rollingMotion
//
//  Created by Ian Nail on 12/29/23.
//

import SwiftUI

struct settingsView: View {
    
    @ObservedObject var myMotionInfo: myMotionInfo
    @ObservedObject var myViewinfo: myViewinfo
    @AppStorage("myCustomVelocity") private var myCustomVelocity = 5.0
    @AppStorage("myCustomAccelerator") private var myCustomAccelerator = 5.0
    
    var body: some View {
        VStack{
            HStack {
                classic_button(buttonWidth: 40, buttonHeight: 40, fontSize: 32, systemImageName: "line.3.horizontal", buttonColor: .black, fontColor: .white ){
                    myViewinfo.myViewOptions = .menuView
                }
                .padding(20)
                Text("Settings")
                    .font(.title)
                    .padding()
                Spacer()
            }
            Text("Sustained Speed \(myCustomVelocity,specifier: "%.2f")")
                .font(.title3)
            Slider(value: $myCustomVelocity, in: 1.0...10)
                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                .frame(width: 250, height: 50, alignment: .center)
                .onChange(of: myCustomVelocity){
                                // Call the function when the accelerator slider changes
                                myMotionInfo.myCustomValues(value1: myCustomAccelerator/50, value2: myCustomVelocity/2000)
                            }
            Text("Speed \(myCustomAccelerator,specifier: "%.2f")")
                .font(.title3)
            Slider(value: $myCustomAccelerator, in: 1.0...10)
                .frame(width: 250, height: 50, alignment: .center)
                .onChange(of: myCustomAccelerator) {
                                    // Call the function when the accelerator slider changes
                                    myMotionInfo.myCustomValues(value1: myCustomAccelerator/50, value2: myCustomVelocity/2000)
            }
            HStack {
                Text("Zen Stars : \(myMotionInfo.scoreZen)")
                    .font(.title3)
                classic_button(buttonWidth: 20, buttonHeight: 20, fontSize: 22, systemImageName: "delete.left.fill", buttonColor: .black, fontColor: .white ){
                    myMotionInfo.scoreZen = 0
                }
            }
            Spacer()
        }
        .transition(AnyTransition.opacity.animation(.easeInOut(duration: 1.0)))
    }
}

#Preview {
    settingsView(myMotionInfo: myMotionInfo(), myViewinfo: myViewinfo())
}

