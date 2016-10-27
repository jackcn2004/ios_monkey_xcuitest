//
//  ____UITests.swift
//
//  Created by wangshuai on 16/10/17.
//  pic 路径 /Users/ur_CP_name/Library/Developer/Xcode/DerivedData/Packagename-(随机）faandoxqjzseredzyubkxdrbayia/Logs/Test/Attachments
//  instruments -s devices  get devices name
//run: 
//xcodebuild test -scheme 'IntegrationApp' -destination 'platform=iOS,id=3d4e6c08281b295628dbaa8530d62a17833498a3' -resultBundlePath './log'
//xcodebuild test -scheme 'IntegrationApp' -destination 'platform=iOS Simulator,id=E037C483-9811-4AF9-A29F-05658F11A626' -resultBundlePath './log'


import XCTest

class ____UITests: XCTestCase {
    let minimumGestureFrequency: UInt32 = UInt32(1) // Minimum amount of time to pass between gestures in seconds
    let duration: Double = 6 * 1 // Execution time limit in seconds
    let gestureLimit: UInt = 10 // Number of gestures to be executed
    let gestureTypeCount: UInt32 = 27 // Number of types of gesture available
    let app = XCUIApplication()
    
    override func setUp() {
        super.setUp()
        continueAfterFailure = true
        app.launch()
    }
    
    override func tearDown() {
        super.tearDown()
    }
//    we can use the method to running the script for durationcase
    //    func testChaosHandlingForDuration() {
    //        // Create a loop for the given time limit
    //        let end = NSDate(timeIntervalSinceNow: duration)
    //        while NSDate().compare(end as Date) == ComparisonResult.orderedAscending {
    //            // Execute a gesture based on the random number
    //            executeRandomGesture()
    //        }
    //    }
    
    func testChaosHandlingUntilGestureLimit() {
        // Loop for as many times as the gesture limit allows
        for _ in 0..<gestureLimit {
            executeRandomGesture()
        }
    }
    
    private func executeRandomGesture() {
        let randomGestureID = arc4random_uniform(gestureTypeCount)
        let coordinate = getRandomCoordinate()
        let device = XCUIDevice.shared()
        switch randomGestureID {
        case 0:
            coordinate.tap()
        case 1:
            coordinate.doubleTap()
        case 2:
            // Scroll up
            let maxSize = app.windows.element(boundBy: 0).frame.size
            let startY = coordinate.screenPoint.y
            let dy = (startY * getRandomValueBetween0And1()) / maxSize.height
            let vector = CGVector(dx: coordinate.screenPoint.x / maxSize.width, dy: dy)
            scroll(fromCoordinate: coordinate, toCoordinate: getCoordinateForVector(vector: vector))
        case 3:
            // Scroll down
            let maxSize = app.windows.element(boundBy: 0).frame.size
            let startY = coordinate.screenPoint.y
            let dy = ((maxSize.height - startY) * getRandomValueBetween0And1() + startY) / maxSize.height
            let vector = CGVector(dx: coordinate.screenPoint.x / maxSize.width, dy: dy)
            scroll(fromCoordinate: coordinate, toCoordinate: getCoordinateForVector(vector: vector))
        case 4:
            // Scroll left
            let maxSize = app.windows.element(boundBy: 0).frame.size
            let startX = coordinate.screenPoint.x
            let dx = (startX * getRandomValueBetween0And1()) / maxSize.width
            let vector = CGVector(dx: dx, dy: coordinate.screenPoint.y / maxSize.height)
            scroll(fromCoordinate: coordinate, toCoordinate: getCoordinateForVector(vector: vector))
        case 5:
            // Scroll right
            let maxSize = app.windows.element(boundBy: 0).frame.size
            let startX = coordinate.screenPoint.x
            let dx = ((maxSize.width - startX) * getRandomValueBetween0And1() + startX) / maxSize.width
            let vector = CGVector(dx: dx, dy: coordinate.screenPoint.y / maxSize.height)
            scroll(fromCoordinate: coordinate, toCoordinate: getCoordinateForVector(vector: vector))
        case 6:
            device.orientation = .portrait
        case 7:
            device.orientation = .portraitUpsideDown
        case 8:
            device.orientation = .landscapeLeft
        case 9:
            device.orientation = .landscapeRight
        case 10:
            device.orientation = .faceUp
        case 11:
            device.orientation = .faceDown
        case 12:
            // Move in a completely random direction
            scroll(fromCoordinate: coordinate, toCoordinate: getRandomCoordinate())
        case 13:
            coordinate.press(forDuration: 2)
        case 14:
            coordinate.tap()
        case 15:
            coordinate.tap()
        case 16:
            coordinate.tap()
        case 17:
            coordinate.tap()
        case 18:
            coordinate.tap()
        case 19:
            coordinate.tap()
        case 20:
            coordinate.tap()
        case 21:
            coordinate.tap()
        case 22:
            coordinate.tap()
        case 23:
            coordinate.tap()
        case 24:
            coordinate.tap()
        case 25:
            coordinate.tap()
        case 26:
            coordinate.tap()
        default:
            XCTFail("Random number failure - unhandled case for number: \(randomGestureID)")
        }
        print("Executed gesture \(randomGestureID) on coordinate: \(coordinate)")
        
        // Wait for cooldown period
        sleep(minimumGestureFrequency)
    }
    
    private func getRandomCoordinate() -> XCUICoordinate {
        let randomX = getRandomValueBetween0And1()
        let randomY = getRandomValueBetween0And1()
        
        let randomVector = CGVector(dx: randomX, dy: randomY)
        let coordinate = getCoordinateForVector(vector: randomVector)
        
        return coordinate
    }
    
    private func getCoordinateForVector(vector: CGVector) -> XCUICoordinate {
        let window = app.windows.element(boundBy: 0)
        let coordinate = window.coordinate(withNormalizedOffset: vector)
        return coordinate
    }
    
    private func getRandomValueBetween0And1() -> CGFloat {
        return CGFloat(Float(arc4random()) / Float(UINT32_MAX))
    }
    
    private func scroll(fromCoordinate: XCUICoordinate, toCoordinate: XCUICoordinate) {
        fromCoordinate.press(forDuration: 0, thenDragTo: toCoordinate)
    }
    
}

