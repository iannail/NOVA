//
//  introView.swift
//  rollingMotion
//
//  Created by Ian Nail on 12/29/23.
//

import SwiftUI

struct quoteView: View {
    let myCustomFont = Font.custom("Optima", size: 26).italic()
    
    @ObservedObject var myMotionInfo: myMotionInfo
    @ObservedObject var myViewinfo: myViewinfo
    
    @State private var hasHandledTap = false // Flag to track tap gesture
    
    var body: some View {
        ZStack{
            Color.black
                .ignoresSafeArea(.all)
            
        withAnimation {
            
            VStack {
                Text(myViewinfo.quotes[myViewinfo.quoteIncrement])
                    .font(myCustomFont)
                    .foregroundColor(.white)
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                    .ignoresSafeArea(.all)
                    .contentShape(Rectangle())
            }
        }
        
        .gesture(TapGesture()
            .onEnded {
                if !hasHandledTap { // Allow only one tap gesture
                    handleTapGesture()
                    hasHandledTap = true
                }
            })
        .transition(AnyTransition.opacity.animation(.easeIn(duration: 0.6)))
    }
}
    
    
    private func handleTapGesture() {
        
        // Update the variable that might trigger a view update
        myViewinfo.myViewOptions = .zenView
        myViewinfo.myStateOptions = .startmovement
        
        // Change the variable without triggering a view update
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            myViewinfo.quoteIncrement = Int.random(in: 0...myViewinfo.quotes.count-1)
        }
        //CGFloat.random(in: -screenWidth...screenWidth)
    }
}

#Preview {
    quoteView(myMotionInfo: myMotionInfo(), myViewinfo: myViewinfo())
}
