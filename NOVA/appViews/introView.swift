//
//  rocketPath.swift
//  rollingMotion
//
//  Created by Ian Nail on 12/30/23.
//

import SwiftUI

struct introView: View {
    let myCustomFont = Font.custom("Optima", size: 22).italic()

    @ObservedObject var myViewinfo: myViewinfo
    
    @State private var timer: Timer?
    @State private var timerbool: Bool = false
    @State private var xcord = -220.0 //initial value
    @State private var ycord = 650.0  //initial value
    private let pi = 3.1459
    @State private var theta: Double = 135 * 3.1459 / 180 //initial value
    private let radius: Double = 100
    private let thetaSpeed: Double = 0.02
    @State private var rocketPhase: Int = 0
    @State private var myRadian = 0.0
    @State private var incrementView = 0
    
    var body: some View {
        
        ZStack {
            Color.black
                .ignoresSafeArea(.all)
            Image("rocket")
                .resizable()
                .frame(width: 30, height: 30, alignment: .center)
                .colorInvert()
                .rotationEffect(.radians(myRadian + 0.785398))
                .offset(x: xcord, y: ycord)
                .scaleEffect(y: -1)
                .onAppear(){
                    startTimer()
                }
            
            if rocketPhase < 2 {
                VStack{
                    Spacer()
                    Spacer()
                    Spacer()
                    
                    Text(myViewinfo.introQuote[0])
                        .font(myCustomFont)
                        .foregroundColor(.white)
                        .padding(20)
                    Spacer()
                }
                .transition(AnyTransition.opacity.animation(.easeInOut(duration: 0.5)))
                } else {
                    
                    VStack {
                    Spacer()
                        Text(myViewinfo.introQuote[1])
                            .font(myCustomFont)
                            .foregroundColor(.white)
                            .padding(20)
                    
                    Spacer()
                    Spacer()
                    Spacer()
                }
                    .transition(AnyTransition.opacity.animation(.easeInOut(duration: 0.5)))
            }
        }
        .gesture(TapGesture()
            .onEnded {
                //change to a different view
                rocketPhase += 1
                if rocketPhase >= 4 {
                    myViewinfo.myViewOptions = .zenView
                }
            })
    }
    
    func startTimer() {
        // Make sure to stop the timer if it's already running
        //stoptimer()
        timerbool = true
        // Start a new timer
        timer = Timer.scheduledTimer(withTimeInterval: 1.0 / 60.0, repeats: true) { timer in
            // Timer action
            //Using the update equations for calculating the movement and direction of the rocket
            calculateMovement()
        }
    }
    
    func timertoggle() {
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
    func stoptimer() {
        timer?.invalidate()
        timer = nil
        timerbool = false
    }
    func calculateMovement() {
        let pointx = xcord
        let pointy = ycord
        switch rocketPhase {
        case 0:
            theta += thetaSpeed * 0.6
            xcord = CGFloat(radius * 1.80 * cos(theta))
            ycord = CGFloat(radius * 1.80 * sin(theta)) + radius * 1.8
            if xcord >= 0{
                rocketPhase = 1
            }
        case 1:
            theta += thetaSpeed
            xcord = CGFloat(radius * cos(theta))
            ycord = CGFloat(radius * sin(theta)) + radius
            if theta >= 10.97{
                rocketPhase = 2
                theta = 90*pi/180
            }
        case 2:
            theta -= thetaSpeed*0.9
            xcord = CGFloat(radius * 0.90 * cos(theta))
            ycord = CGFloat(radius * 0.90  * sin(theta)) - radius * 0.90
            if theta < -7 {
                rocketPhase = 3
            }
        case 3:
            stoptimer()
            myViewinfo.myViewOptions = .zenView
        case 4:
            myViewinfo.myViewOptions = .zenView
        default:
            print("\(xcord)")
            print("\(ycord)")
        }
        
        myRadian  = atan2(ycord - pointy, xcord-pointx)

    }
}

//******** Preview ******** //

#Preview {
    introView(myViewinfo: myViewinfo())
    //rocketPath()
}

