//
//  AudioPlayer_VC.swift
//  audioquiz
//
//  Created by khushboo patel on 29/12/20.
//  Copyright © 2020 Khushboo. All rights reserved.
//

import UIKit
import SwiftAudioPlayer
import  AVFoundation

class AudioPlayer_VC: UIViewController
{
    var playlistitem : Playlist_Model = Playlist_Model()
    var isaudioplaying : Bool = false
    var duration: Double = 0.0
     var beingSeeked: Bool = false
    
    //MARK:- IBOutlets
    @IBOutlet weak var btn_play : UIButton!
    @IBOutlet weak var btn_backward : UIButton!
    @IBOutlet weak var btn_forward : UIButton!
    @IBOutlet weak var btn_quiz : UIButton!
    @IBOutlet weak var lbl_title : UILabel!
    @IBOutlet weak var lbl_details : UILabel!
    @IBOutlet weak var durationLabel: UILabel!
      @IBOutlet weak var currentTimestampLabel: UILabel!
    @IBOutlet weak var bufferProgress: UIProgressView!
     @IBOutlet weak var scrubberSlider: UISlider!
    
    
    
    
    //MARK:- App life Cycle
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        /// setup audio
        audiosetup()
        setupvalues()
      
    }
    //MARK:- Setup Values
    func setupvalues()
    {
        lbl_title.text = playlistitem.title
        lbl_details.text = playlistitem.details
    }
    //MARK:- Audio setup
    func audiosetup()
    {
        let selectedurl : URL = URL(string: playlistitem.audiourl)!
              
             
              _ = SAPlayer.Updates.Duration.subscribe { [weak self] (url, duration) in
                        guard let self = self else { return }
                        guard url == selectedurl else { return }
                       self.durationLabel.text = SAPlayer.prettifyTimestamp(duration)
                        self.duration = duration
                    }
              _ = SAPlayer.Updates.StreamingBuffer.subscribe{ [weak self] (url, buffer) in
                         guard let self = self else { return }
                         guard url == selectedurl else
                         { return }
                         
                         if self.duration == 0.0 { return }
                         
                         self.bufferProgress.progress = Float(buffer.bufferingProgress)
                         }
              _ = SAPlayer.Updates.ElapsedTime.subscribe { [weak self] (url, position) in
                         guard let self = self else { return }
                         guard url == selectedurl
                          else { return }
                         
                        self.currentTimestampLabel.text = SAPlayer.prettifyTimestamp(position)
                         
                         guard self.duration != 0 else { return }
                         
                         self.scrubberSlider.value = Float(position/self.duration)
                     }
                     
              
           SAPlayer.shared.startRemoteAudio(withRemoteUrl: selectedurl)
    }
    //MARK:- IBActions
    @IBAction func onclick_back(sender : UIButton)
    {
       
        if isaudioplaying == true
        {
            SAPlayer.shared.togglePlayAndPause()
            SAPlayer.shared.stopStreamingRemoteAudio()
             
        }
       
             self.navigationController?.popViewController(animated: true)
    
        
    }
    @IBAction func onclick_play(sender : UIButton)
    {
        if isaudioplaying == false
        {
        sender.setBackgroundImage(UIImage(named: "pause"), for: .normal)
            isaudioplaying = true
        }
        else
        {
          sender.setBackgroundImage(UIImage(named: "play"), for: .normal)
        }
        SAPlayer.shared.togglePlayAndPause()
    }
    @IBAction func onclick_forward(sender : UIButton)
    {
        SAPlayer.shared.skipForward()
    }
    @IBAction func onclick_backward(sender : UIButton)
    {
         SAPlayer.shared.skipBackwards()
        
    }
    @IBAction func scrubberSeeked(_ sender: Any)
    {
           let value = Double(scrubberSlider.value) * duration
           SAPlayer.shared.seekTo(seconds: value)
           beingSeeked = false
       }
    @IBAction func scrubberStartedSeeking(_ sender: UISlider) {
        beingSeeked = true
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
