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
        VStack {
            
        HStack {
            classic_button(buttonWidth: 40, buttonHeight: 40, fontSize: 16, systemImageName: "line.3.horizontal", buttonColor: .black, fontColor: .white ){
                myViewinfo.myViewOptions = .gameMenu
            }
            .padding()
            
            Spacer()
            
        }
            HStack {
                classic_button(buttonWidth: 200, buttonHeight: 30, fontSize: 24, name: "Zen", buttonColor: .black, fontColor: .white ){
                    myMotionInfo.initRandom()
                    myMotionInfo.score = 0
                    myViewinfo.myViewOptions = .gameZen
                }
                //multilineTextAlignment(.left)
                //.padding()
                
                Spacer()
                
                
            }
            HStack {
                classic_button(buttonWidth: 200, buttonHeight: 30, fontSize: 24, name: "Mode2", buttonColor: .black, fontColor: .white ){
                    //myMotionInfo.pauseplaytoggle()
                }
                //multilineTextAlignment(.left)
                //.padding()
                
                Spacer()
                
                
            }
            Spacer()
    }
        //Spacer()
}
}


#Preview {
    menuView(myMotionInfo: myMotionInfo(), myViewinfo: myViewinfo())
}
