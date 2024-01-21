//
//  coreMotionInit.swift
//  rollingMotion
//
//  Created by Ian Nail on 12/26/23.
//

import Foundation
import CoreMotion
import SwiftUI

//******** Data Used by Views ******** //
class myMotionInfo: ObservableObject {
    
    @Published var xcoord: CGFloat = 0
    @Published var ycoord: CGFloat = -250
    @Published var myRadian: CGFloat = 0
    @Published var yRandom: CGFloat = 0
    @Published var xRandom: CGFloat = 0
    @Published var score: Int = 0
    @Published var accelerometerData: (x: Double, y: Double, z: Double) = (0, 0, 0)
    @Published var isplay: Bool = false
    
    private var deltaX: CGFloat = 0
    private var deltaY: CGFloat = 0
    private var velocityX: CGFloat = 0
    private var velocityY: CGFloat = 0
    private var YDeltaY: CGFloat = 0
    private var XDeltaX: CGFloat = 0
    
    private var minAccel = 0.03 //filter on the minimum accelerometer values to update
    private var vel_multiplier = 0.10 // velocity multiplier
    let motionManager = CMMotionManager()
    let screenWidth = UIScreen.main.bounds.width - 200
    let screenHeight = UIScreen.main.bounds.height - 50
    
    // start accelerometer
    func startAccelerometerUpdates() {
        if motionManager.isAccelerometerAvailable {
            motionManager.deviceMotionUpdateInterval = 1.0 / 60.0
            motionManager.startAccelerometerUpdates(to: OperationQueue.main) { (data, error) in
                if let accelerometerData = data?.acceleration {
                    self.accelerometerData = (x: accelerometerData.x, y: accelerometerData.y, z: accelerometerData.z)
                }
            }
        } else {
            print("Accelerometer is not available on this device.")
        }
    }
    
    // stop accelerometer
    func stopAccelerometerUpdates() {
        motionManager.stopAccelerometerUpdates()
    }
    
    func initRandom() {
        yRandom = CGFloat.random(in: -screenHeight+100...0)
        xRandom = CGFloat.random(in: -screenWidth+20...screenWidth-20)
    }
    func setRandom() {
        if (abs(ycoord - yRandom) < 20) && (abs(xcoord - xRandom) < 20) {
            initRandom()
            score += 1
        }
    }
    
    // start or pause the accelerometer updates
    func isplaytrue() {
        
        if isplay {
            stopAccelerometerUpdates()
            velocityY = 0
            velocityX = 0
            isplay = false
            
        }else if !isplay {
            startAccelerometerUpdates()
            isplay = true
        }
    }
    
    //take the accelerometer data and use to calculate velocity and position along the x and y axis
    func calculateMovement() {
        if (accelerometerData.x > minAccel) || (accelerometerData.x < -minAccel) {
            deltaX = accelerometerData.x // Delta  X
            
        } else{
            deltaX = 0
        }
        
        if (accelerometerData.y  > minAccel) || (accelerometerData.y < -minAccel) {
            deltaY = (-1) * accelerometerData.y //Delta  Y
            
        }else{
            deltaY = 0
        }
        
        velocityX = velocityX + deltaX // Velocity X
        velocityY = velocityY + deltaY // Velocity Y

        XDeltaX = vel_multiplier * velocityX
        xcoord = xcoord + XDeltaX // Update Coordinate X

        YDeltaY = vel_multiplier * velocityY
        ycoord = ycoord + YDeltaY  // Update Coordinate Y
    }
    
    // function to take the position of the rocket and keep it within screen bounds.
    func setBoundary() {
        if ycoord < -screenHeight {
            ycoord = -screenHeight
            velocityY = 0
        }

        if ycoord > 0 {
            ycoord = 0
            velocityY = 0
        }
        
        if xcoord < -screenWidth {
            xcoord = -screenWidth
            velocityX = 0
        }
        
        if xcoord > screenWidth {
            xcoord = screenWidth
            velocityX = 0
        }
    }
    
    //Calculating the angle for the direction the rocket image should point so it appears to point in the direction of travel
    func calculateAngle() {
        myRadian  = atan2(YDeltaY, XDeltaX)
    }
  
}
