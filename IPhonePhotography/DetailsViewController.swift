//
//  DetailsViewController.swift
//  IPhonePhotography
//
//  Created by Gokul Murugan on 2023-01-30.
//

import UIKit

class DetailsViewController: UIViewController {

    @IBOutlet weak var lessonTitle: UILabel!
    @IBOutlet weak var lessonDescription: UILabel!
    @IBOutlet weak var lessonThumbnail: UIImageView!
    
    var lessonName:String?
    var lessonDesc:String?
    var videoUrl:String?
    var videoThumnail:String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lessonTitle.text = lessonName
        lessonDescription.text = lessonDesc
        lessonThumbnail.getImage(with: videoThumnail!)
        lessonThumbnail.clipsToBounds = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Download", image: UIImage(systemName: "icloud.and.arrow.down"), target: self, action: #selector(downloadVideo))
        
    }
    
    @objc func downloadVideo(){
        
        navigationItem.rightBarButtonItem?.image = UIImage(systemName: "checkmark")
        
        
    }
    

    @IBAction func playTap(_ sender: Any) {
    }
    

    @IBAction func nextLesson(_ sender: Any) {
    }
    
   

}
