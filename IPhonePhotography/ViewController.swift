//
//  ViewController.swift
//  IPhonePhotography
//
//  Created by Gokul Murugan on 2023-01-30.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var lessonsArray:[lesson] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Lessons"
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "LessonsTableViewCell", bundle: nil), forCellReuseIdentifier: "LessonCell")
        (UIApplication.shared.delegate as! AppDelegate).screenResolution = .portrait
        
        getData()
        
    }
    
    
}


extension ViewController:UITableViewDelegate,UITableViewDataSource{
    
    // MARK: Table View data population
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lessonsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LessonCell", for: indexPath) as! LessonsTableViewCell
        cell.lessonName.text = lessonsArray[indexPath.row].name
        cell.thumbNail.getImage(with: lessonsArray[indexPath.row].thumbnail)
        return cell
    }
    
    // MARK: Selected row functionalities
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "DetailsView") as? DetailsViewController else {
            print("Unable to instantiate view Controler")
            return}
        vc.lessonIdex = indexPath.row
        vc.lessonsArray = lessonsArray
        navigationController?.pushViewController(vc, animated: true)
    }
    
    // MARK: Getting data from url and storing it in an array
    func getData(){
        
        guard let url = URL(string: "https://iphonephotographyschool.com/test-api/lessons") else {return}
        
        let task = URLSession.shared.dataTask(with: url) {[weak self] Dt, _ , Er in
            guard let data = Dt else {return}
            
            do{
                let result = try JSONDecoder().decode(Lessons.self, from: data)
                
                
                for i in result.lessons{
                    self?.lessonsArray.append(i)
                }
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
                
                
            }
            catch{
                print("Failed")
                print(error)
            }
            
        }
        task.resume()
        
        
    }
    
}

// MARK: Added extension to load image view with image using a URL
extension UIImageView{
    public func getImage(with thumbNailUrl:String){
        guard let url = URL(string: thumbNailUrl) else {
            self.image = UIImage(systemName: "i.circle.fill")
            return }
        
        let task = URLSession.shared.dataTask(with: url) { Dt, _ , Er in
            guard let data = Dt else {return}
            DispatchQueue.main.async {
                self.image = UIImage(data: data)
            }
        }
        task.resume()
    }
}

// MARK: Default model class
struct Lessons:Codable{
    let lessons:[lesson]
}

struct lesson:Codable{
    let id:Int
    let name:String
    let description:String
    let thumbnail:String
    let video_url:String
}
