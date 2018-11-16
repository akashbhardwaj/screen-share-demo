//
//  ViewController.swift
//  screenShare
//
//  Created by Akash Bhardwaj on 05/10/18.
//  Copyright © 2018 Akash Bhardwaj. All rights reserved.
//
import Cocoa
import AVFoundation
import AVKit
import WebKit
import VideoToolbox

class ViewController: NSViewController {
    var recorder: Recoder?
    var avlayer: AVCaptureVideoPreviewLayer?
    @IBOutlet weak var previewVIEW: NSView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear() {
        super.viewWillAppear()
        preferredContentSize = view.fittingSize
    }
    
    override func viewWillLayout() {
        super.viewWillLayout()
        avlayer?.frame = self.previewVIEW.bounds

    }
    
    override func viewDidLayout() {
        super.viewDidLayout()
        avlayer?.frame = self.previewVIEW.bounds
    }
    
    func startRecord() {
        recorder = Recoder()
        if self.avlayer == nil {
        self.avlayer = AVCaptureVideoPreviewLayer()
        }
        avlayer?.frame = self.previewVIEW.bounds
        recorder?.layer = avlayer
        let url = URL(fileURLWithPath: "~/Users/akash/Desktop/screenShare/mov")
        recorder?.screenRecording(url)
        self.previewVIEW.layer?.addSublayer(self.avlayer!)
    }
    
    @IBAction func btnCapture(_ sender: NSButton) {
        startRecord()
    }
    
    @IBAction func btnStopAction(_ sender: Any) {
        recorder?.stopRecord()
    }
    
    
    
    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }

    func fetchVideo () {
        let configuration = URLSessionConfiguration.background(withIdentifier: "mediaDownload")
        
        
    }
}

