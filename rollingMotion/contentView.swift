//
//  ContentView.swift
//  rollingMotion
//
//  Created by Ian Nail on 12/26/23.
//

import SwiftUI
import SwiftData
import CoreMotion

struct contentView: View {
    
    @ObservedObject var myMotionInfo: myMotionInfo
    @ObservedObject var myViewinfo: myViewinfo
    
    var body: some View {
        
        switch myViewinfo.myViewOptions {
        case .gameMenu:
            menuView(myMotionInfo: myMotionInfo, myViewinfo: myViewinfo)
        case .gameZen:
            gameMode1(myMotionInfo: myMotionInfo, myViewinfo: myViewinfo)
        case .game3:
            menuView(myMotionInfo: myMotionInfo, myViewinfo: myViewinfo)
        case .game4:
            menuView(myMotionInfo: myMotionInfo, myViewinfo: myViewinfo)
        default:
            gameMode1(myMotionInfo: myMotionInfo, myViewinfo: myViewinfo)
        }
    
    }
}
//******** Preview ******** //

#Preview {
    contentView(myMotionInfo: myMotionInfo(), myViewinfo: myViewinfo())
}

