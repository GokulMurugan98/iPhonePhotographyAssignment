//
//  DetailsViewController.swift
//  IPhonePhotography
//
//  Created by Gokul Murugan on 2023-01-30.
//

import UIKit
import AVFoundation

class DetailsViewController: UIViewController {

    @IBOutlet weak var lessonTitle: UILabel!
    @IBOutlet weak var lessonDescription: UILabel!
    @IBOutlet weak var lessonThumbnail: UIImageView!
    
    var player:AVPlayer?
    var lessonName:String?
    var lessonDesc:String?
    var videoUrl:String?
    var videoThumnail:String?
    var isPlayig:Bool = false
    var downloadStats:downloadStatus = .download
    
    
    
    @IBOutlet weak var playButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lessonTitle.text = lessonName
        lessonDescription.text = lessonDesc
        lessonThumbnail.getImage(with: videoThumnail!)
        lessonThumbnail.clipsToBounds = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Download", image: UIImage(systemName: "icloud.and.arrow.down"), target: self, action: #selector(downloadVideo))
        
    }
    
    @objc func downloadVideo(){
        
        if downloadStats == .download{
            navigationItem.rightBarButtonItem?.image = UIImage(systemName: "x.circle")
            downloadStats = .cancelled
            DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
                self.navigationItem.rightBarButtonItem?.image = UIImage(systemName: "checkmark")
                self.downloadStats = .downloaded
            }
        }
        else if downloadStats == .cancelled{
            navigationItem.rightBarButtonItem?.image = UIImage(systemName: "icloud.and.arrow.down")
            downloadStats = .download
        }
        else if downloadStats == .downloaded{
            navigationItem.rightBarButtonItem?.image = UIImage(systemName: "checkmark")
        }
        
        
        
        
    }
    

    @IBAction func playTap(_ sender: Any) {
        guard let urlString = videoUrl else {return}
        guard let videoURL = URL(string: urlString) else {return}
        
        if isPlayig == false{
            playButton.setImage(UIImage(systemName: "pause"), for: .normal)
            player = AVPlayer(url: videoURL)
            let layer = AVPlayerLayer(player: player)
            layer.frame = self.lessonThumbnail.bounds
            layer.videoGravity = .resizeAspectFill
            self.lessonThumbnail.layer.addSublayer(layer)
            isPlayig = true
            player!.play()
            return
        }
        if isPlayig == true{
            playButton.setImage(UIImage(systemName: "play.fill"), for: .normal)
            if player != nil {
                print("Stopping")
                player!.pause()
                player = nil
                player?.replaceCurrentItem(with: nil)
                isPlayig = false
                print("Stopped")
            }
            else{
                return
            }
           return
        }
        
        
    }
    

    @IBAction func nextLesson(_ sender: Any) {
    }
    
   

}

enum downloadStatus {
    case download
    case downloaded
    case cancelled
}
