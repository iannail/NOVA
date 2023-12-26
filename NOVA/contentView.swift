//
//  ContentView.swift
//  rollingMotion
//
//  Created by Ian Nail on 12/26/23.
//

import SwiftUI
//import SwiftData
//import CoreMotion

struct contentView: View {
    
    @ObservedObject var myMotionInfo: myMotionInfo
    @ObservedObject var myViewinfo: myViewinfo
    
    var body: some View {
        
        switch myViewinfo.myViewOptions {
        case .introView:
            introView(myViewinfo: myViewinfo)
        case .menuView:
            menuView(myMotionInfo: myMotionInfo, myViewinfo: myViewinfo)
        case .zenView:
            zenView(myMotionInfo: myMotionInfo, myViewinfo: myViewinfo)
        case .settingsView:
            settingsView(myMotionInfo: myMotionInfo, myViewinfo: myViewinfo)
        case .quoteView:
            quoteView(myMotionInfo: myMotionInfo, myViewinfo: myViewinfo)
        case .tempView:
            introView(myViewinfo: myViewinfo)
        }
    }
}
//******** Preview ******** //

#Preview {
    contentView(myMotionInfo: myMotionInfo(), myViewinfo: myViewinfo())
}
