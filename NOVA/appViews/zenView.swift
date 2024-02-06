//
//  zenView.swift
//  rollingMotion
//
//  Created by Ian Nail on 12/29/23.
//

import SwiftUI

struct zenView: View {
    
    @ObservedObject var myMotionInfo: myMotionInfo
    @ObservedObject var myViewinfo: myViewinfo
    @State private var timer: Timer?
    @State private var timerbool: Bool = false
    @State private var showQuote = 0
    
    var body: some View {
            
            ZStack {
                    Color.black
                        .ignoresSafeArea(.all)
                VStack{
                    HStack {
                        classic_button(buttonWidth: 40, buttonHeight: 40, fontSize: 32, systemImageName: "line.3.horizontal", buttonColor: .black, fontColor: .white){
                            if myMotionInfo.isplay {
                                timertoggle()
                                myMotionInfo.isplaytrue()
                            }
                            myViewinfo.myViewOptions = .menuView
                        }
                        .padding(20)
                        
                        Spacer()
                        Text("\(myMotionInfo.scoreZen)")
                            .font(.largeTitle)
                        
                        Spacer()
                        classic_button(buttonWidth: 40, buttonHeight: 40, fontSize: 32, systemImageName: "playpause", buttonColor: .black, fontColor: .white ){
                            timertoggle()
                            myMotionInfo.isplaytrue()
                        }
                        .padding(20)
                    }
                    //.padding(30)
                    Spacer()
                }
                .transition(AnyTransition.opacity.animation(.easeInOut(duration: 1.0)))

            .onAppear(){
                if myViewinfo.myStateOptions == .startmovement{
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                        timertoggle()
                        myMotionInfo.isplaytrue()
                        myViewinfo.myStateOptions = .nothing
                    }
                }
            }
            
                Image(systemName: "star")
                    .offset(x: myMotionInfo.xRandom, y: myMotionInfo.yRandom)
                    .foregroundColor(.white)
                    .scaleEffect(y: -1)
                
                Image("rocket")
                    .resizable()
                    .frame(width: 30, height: 30, alignment: .center)
                    .colorInvert()
                    .rotationEffect(.radians(myMotionInfo.myRadian + 0.785398))
                    .offset(x: myMotionInfo.xcoord, y: myMotionInfo.ycoord)
                    .scaleEffect(y: -1)
            }
            .transition(AnyTransition.opacity.animation(.easeInOut(duration: 1.0)))
            .appPhaseObserver {
                // Perform state change logic when app goes inactive or to background
                if myMotionInfo.isplay {
                    timertoggle()
                    myMotionInfo.isplaytrue()
                }
            }
        }
    
    private func startTimer() {
        // Make sure to stop the timer if it's already running
        //stoptimer()
        timerbool = true
        showQuote =  myMotionInfo.scoreZen + Int.random(in: 15...20)
        // Start a new timer
        timer = Timer.scheduledTimer(withTimeInterval: 1.0 / 60.0, repeats: true) { timer in
            // Timer action
            //Calculating the rocket movement
            myMotionInfo.calculateMovement()
            
            //Calculating the angle for the direction the rocket image should point so it appears to point in the direction of travel
            myMotionInfo.calculateAngle()
            
            // Setting the boundery
            myMotionInfo.setBoundary()

            //if the object is found increment the score and set a new random object
            myMotionInfo.setRandom()

            // show a quote after a random number of stars are collected.
            if myMotionInfo.scoreZen == showQuote {
                
                if myMotionInfo.isplay {
                    timertoggle()
                    myMotionInfo.isplaytrue()
                }
                myViewinfo.myViewOptions = .quoteView
            }
        }
    }
    
    private func timertoggle() {
        // Stop the timer if it's running, start if it is not
        
        if !timerbool {
            startTimer()
            print("\(timerbool)")
        } else {
            stoptimer()
            print("\(timerbool)")
        }
    }
    //stop the timer
    private func stoptimer() {
        timer?.invalidate()
        timer = nil
        timerbool = false
    }
}

//******** Preview ******** //

#Preview {
    contentView(myMotionInfo: myMotionInfo(), myViewinfo: myViewinfo())
}

