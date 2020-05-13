//
//  SoundViewController.swift
//  SoundBoard
//
//  Created by mbtec22 on 5/13/20.
//  Copyright © 2020 Tecsup. All rights reserved.
//

import UIKit
import AVFoundation
class SoundViewController: UIViewController {

    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var addButton: UIButton!
    
    var audioRecorder:AVAudioRecorder?
    var audioPlayer:AVAudioPlayer?
    var audioURL:URL?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupRecorder()
        playButton.isEnabled=false
    }
    func setupRecorder(){
        do{
            //seisión de audio
            let session = AVAudioSession.sharedInstance()
            try session.setCategory(AVAudioSession.Category.playAndRecord)
            try session.overrideOutputAudioPort(.speaker)
            try session.setActive(true)
            //direccion para el archivo de audio
            let basePath : String = NSSearchPathForDirectoriesInDomains(.documentDirectory,.userDomainMask,true).first!
            let pathComponents = [basePath,"audio.m4a"]
            audioURL = NSURL.fileURL(withPathComponents: pathComponents)!
            print("*************")
            print(audioURL)
            print("*************")
            //opciones para grabar el audio
            var settings : [String:AnyObject] = [:]
            settings[AVFormatIDKey]=Int(kAudioFormatMPEG4AAC) as AnyObject?
            settings[AVSampleRateKey]=44100.0 as AnyObject?
            settings[AVNumberOfChannelsKey]=2 as AnyObject?
            //Objeto de grabación de audio
            audioRecorder = try AVAudioRecorder(url:audioURL!,settings: settings)
            audioRecorder!.prepareToRecord()
        }catch let error as NSError{
            print(error)
        }
    }
    @IBAction func recordTapped(_ sender: Any) {
        if audioRecorder!.isRecording{
            //detener grabación
            audioRecorder?.stop()
            //cambiar el texto del boton de grabación
            recordButton.setTitle("Record", for: .normal)
            playButton.isEnabled=true
        }else{
            //empezar a grabar
            audioRecorder?.record()
            //cambiar el titulo del boton a detener
            recordButton.setTitle("Stop", for: .normal)
        }
    }
    @IBAction func playTapped(_ sender: Any) {
        do{
            try audioPlayer = AVAudioPlayer(contentsOf:audioURL!)
            audioPlayer!.play()
        }catch{}
    }
    @IBAction func addTapped(_ sender: Any) {
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
