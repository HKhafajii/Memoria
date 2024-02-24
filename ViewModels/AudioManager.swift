//
//  AudioManager.swift
//  ARApplication
//
//  Created by Hassan Alkhafaji on 2/1/24.
//

import Foundation
import AVFoundation

class AudioManager {
    
    var audioRecorder: AVAudioRecorder!
    var audioPlayer: AVAudioPlayer!
    
    // setting up a variable to check if recording to play with the UI
    var isRecording: Bool = false
    
    // setting up an array of the struct Recording in our model to store the URL of recordings and some other details
    
    // Creating the start recording func and some "Formalities"
    func startRecording() throws {
        
        let recordingSession = AVAudioSession.sharedInstance()
        
        try recordingSession.setCategory(.playAndRecord, mode: .default)
        try recordingSession.setActive(true)
        
        // the path will include the directory of the recording
        let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        
        // we have to give a unique name to every recording, so we are setting it to the date and time it was recorded the .m4a is very important doing this
        let fileName = path.appendingPathComponent("CO-Voice : \(Date().toString(dateFormat: "dd-MM-YY 'at' HH:mm:ss")).m4a")
        
        let settings = [
            AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
            AVSampleRateKey: 12000,
            AVNumberOfChannelsKey: 1,
            AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
        ]
        
        // when we start the recording we set the isRecording bool to true
        do {
            audioRecorder = try AVAudioRecorder(url: fileName, settings: settings)
            audioRecorder.prepareToRecord()
            audioRecorder.record()
            isRecording = true
        } catch {
            print("Failed to set up recording!")
        }
    }
    
    // a function that stops the recording and sets the bool back to false
    func stopRecording() {
        audioRecorder.stop()
        isRecording = false
    }
    
    
    
    
    func startPlaying(url: URL) throws {
        let playSession = AVAudioSession.sharedInstance()
        
        do {
            try playSession.overrideOutputAudioPort(AVAudioSession.PortOverride.speaker)
        } catch {
            print("Playing failex in Device")
        }
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer.prepareToPlay()
            audioPlayer.play()
        } catch(let error) {
            print("Playing Failed")
            throw error
        }
    }
    
    func stopPlaying(url: URL) {
        audioPlayer.stop()
    }
    
    func deleteRecording(url: URL) throws {
        do {
            try FileManager.default.removeItem(at: url)
        } catch {
            print("Can't Delete")
            throw error
        }
        
        
        
    }
}


