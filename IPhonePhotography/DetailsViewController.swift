//
//  DetailsViewController.swift
//  IPhonePhotography
//
//  Created by Gokul Murugan on 2023-01-30.
//

import UIKit
import AVFoundation
import AVKit

class DetailsViewController: UIViewController {
    
    @IBOutlet weak var lessonTitle: UILabel!
    @IBOutlet weak var lessonDescription: UILabel!
    @IBOutlet weak var lessonThumbnail: UIImageView!
    
    var player:AVPlayer?
    let avCOntroller = AVPlayerViewController()
    
    var lessonsArray:[lesson] = []
    var lessonIdex:Int = 0
    
    @IBOutlet weak var nextLessonButton: UIButton!
    //
    //    var lessonName:String?
    //    var lessonDesc:String?
    //    var videoUrl:String?
    //    var videoThumnail:String?
    var downloadStats:downloadStatus = .download
    
    
    
    @IBOutlet weak var playButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if lessonIdex >= (lessonsArray.count - 1){
            nextLessonButton.isHidden = true
        }
        lessonTitle.text = lessonsArray[lessonIdex].name
        lessonDescription.text = lessonsArray[lessonIdex].description
        lessonThumbnail.getImage(with: lessonsArray[lessonIdex].thumbnail)
        lessonThumbnail.clipsToBounds = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Download", image: UIImage(systemName: "icloud.and.arrow.down"), target: self, action: #selector(downloadVideo))
        
    }
    
    @objc func downloadVideo(){
        
        if downloadStats == .download{
            navigationItem.rightBarButtonItem?.image = UIImage(systemName: "x.circle")
            downloadStats = .cancel
            //Download and save the file to DB
            
        }
        else if downloadStats == .cancel{
            navigationItem.rightBarButtonItem?.image = UIImage(systemName: "icloud.and.arrow.down")
            downloadStats = .download
            //Terminate the downloading task if it is not completed
            
            
        }
        else if downloadStats == .downloaded{
            navigationItem.rightBarButtonItem?.image = UIImage(systemName: "checkmark")
        }
        
        
        
        
    }
    
    
    @IBAction func playTap(_ sender: Any) {
        let urlString = lessonsArray[lessonIdex].video_url
        guard let videoURL = URL(string: urlString) else {return}
        playButton.isHidden = true
        player = AVPlayer(url: videoURL)
        avCOntroller.player = player
        avCOntroller.view.frame.size.height = lessonThumbnail.frame.size.height
        avCOntroller.view.frame.size.width = lessonThumbnail.frame.size.width
        lessonThumbnail.addSubview(avCOntroller.view)
        player?.play()
    }
    
    
    @IBAction func nextLesson(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
        guard let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "DetailsView") as? DetailsViewController else {
            print("Unable to instantiate view Controler")
            return}
        vc.lessonsArray = lessonsArray
        vc.lessonIdex = lessonIdex+1
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    
}


extension DetailsViewController{
    
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        if UIDevice.current.orientation.isLandscape{
            avCOntroller.view.frame.size.height = self.view.frame.size.height
            avCOntroller.view.frame.size.width = self.view.frame.size.width
            self.view.addSubview(avCOntroller.view)
        }
        else if UIDevice.current.orientation.isPortrait{
            print("Portrait")
        }
    }
    
    
    
    
}

enum downloadStatus {
    case download
    case downloaded
    case cancel
}
