//
//  Recorder.swift
//  screenShare
//
//  Created by Akash Bhardwaj on 05/10/18.
//  Copyright © 2018 Akash Bhardwaj. All rights reserved.
//

import Foundation
import Cocoa
import AVFoundation

class Recoder: NSObject {
    
    private var session: AVCaptureSession?
    private var movieFileOutput: AVCaptureMovieFileOutput?
    private var timer: Timer?
    var layer: AVCaptureVideoPreviewLayer?
    func screenRecording(_ destPath: URL?) {
        session = AVCaptureSession()
        session?.sessionPreset = .high
        let displayId: CGDirectDisplayID = kCGNullDirectDisplay
        let input = AVCaptureScreenInput(displayID: displayId)
        if input == nil {
            session?.stopRunning()
            session = nil
            return
        }
        if session?.canAddInput(input!) == true {
            session?.addInput(input!)
        }
        movieFileOutput = AVCaptureMovieFileOutput()
        if session?.canAddOutput(movieFileOutput!) == true {
            session?.addOutput(movieFileOutput!)
        }
        if let layer = layer {
            layer.session = self.session
        }
        session?.startRunning()
        
        if FileManager.default.fileExists(atPath: destPath?.path ?? "") == true {
            if try! FileManager.default.removeItem(atPath: destPath?.path ?? "") == nil {
                print("Error in deleting the file")
            }
        }
        
        if let aPath = destPath {
            movieFileOutput?.startRecording(to: aPath, recordingDelegate: self)
        }
        
        timer = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(self.finishRecord(_:)), userInfo: nil, repeats: false)
    }
    
    
    @objc func finishRecord(_ timer: Timer) {
//        movieFileOutput?.stopRecording()
        timer.invalidate()
        self.timer = nil
    }
    
    func stopRecord() {
        movieFileOutput?.stopRecording()
        self.session?.stopRunning()
    }
}


extension Recoder: AVCaptureFileOutputRecordingDelegate {
    func fileOutput(_ output: AVCaptureFileOutput, didStartRecordingTo fileURL: URL, from connections: [AVCaptureConnection]) {
        print("Start recording")
    }
    func fileOutput(_ output: AVCaptureFileOutput, willFinishRecordingTo fileURL: URL, from connections: [AVCaptureConnection], error: Error?) {
        print("Going to finish")
    }
    func fileOutput(_ output: AVCaptureFileOutput, didPauseRecordingTo fileURL: URL, from connections: [AVCaptureConnection]) {
        print("It paused")
    }
    func fileOutput(_ output: AVCaptureFileOutput, didFinishRecordingTo outputFileURL: URL, from connections: [AVCaptureConnection], error: Error?) {
        print("Finished")
        if let aDescription = error?.localizedDescription {
            print("Did finish recording to \(outputFileURL.description) due to error \(aDescription)")
        }
        
        // Stop running the session
        session?.stopRunning()
        
        // Release the session
        
        session = nil
    }
    
}
