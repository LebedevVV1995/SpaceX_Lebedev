//
//  ViewController.swift
//  SpaceX_Lebedev
//
//  Created by Владимир on 13/07/2019.
//  Copyright © 2019 Владимир. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class MainViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
 
    @IBOutlet weak var MyTableView: UITableView?
    
    var mission_nameArr = [String]()
    var mission_dateArr = [String]()
    var mission_patchArr = [String]()
    var mission_detailArr = [String]()
    var mission_wikiArr = [String]()
    var mission_youTbArr = [String]()
    var mission_orbcommArr = [String]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Alamofire.request("https://api.spacexdata.com/v3/launches").responseJSON {
            response in
            guard response.result.isSuccess else {
                print("Ошибка при запросе данных\(String(describing: response.result.error))")
                return
            }
            guard let result = response.result.value as? [[String: AnyObject]]else{
                print("Ошибка при запросе данных\(String(describing: response.result.error))")
                return
            }
            
            for item in result{
                let nameArr = item["mission_name"] as! String
                self.mission_nameArr.append(nameArr)
                
                let dateArr = item["launch_date_local"] as! String
                self.mission_dateArr.append(dateArr)
                
                let linkArr = item["links"] as! Dictionary <String, Any>
                let mission_putch = linkArr["mission_patch"] as Any
                self.mission_patchArr.append(mission_putch as? String ?? "Default")
                
                let detailArr = item["details"] as Any
                self.mission_detailArr.append(detailArr as? String ?? "На данный момент по конкретному запуску нет подробной информации, приносим свои извинения :)")
                
                let wikiLinkArr = item["links"] as! Dictionary <String, Any>
                let wiki_arr = wikiLinkArr["wikipedia"] as Any
                self.mission_wikiArr.append(wiki_arr as? String ?? "https://en.wikipedia.org/wiki/Main_Page")
                
                let youTbLinkArr = item["links"] as! Dictionary <String, Any>
                let youT_arr = youTbLinkArr["video_link"] as Any
                self.mission_youTbArr.append(youT_arr as? String ?? "https://www.youtube.com")
                
                let orbcommLinkArr = item["links"] as! Dictionary <String, Any>
                let orbcomm_arr = orbcommLinkArr["article_link"] as Any
                self.mission_orbcommArr.append(orbcomm_arr as? String ?? "https://www.orbcomm.com/en")
            }
            self.MyTableView?.delegate = self
            self.MyTableView?.dataSource = self
            
            DispatchQueue.main.async {
                self.MyTableView?.reloadData()
            }
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mission_nameArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "mCell", for: indexPath) as? MyTableViewCell
        let itemName = mission_nameArr[indexPath.row]
        cell?.mission_name.text = "Название миссии - \(itemName)"
        
        let itemDate = mission_dateArr[indexPath.row]
        cell?.mission_date.text = "Время - \(itemDate)"
        
        let patchImage = mission_patchArr[indexPath.row]
        let url = URL(string: patchImage)
        cell?.mission_path.image = UIImage(named: "Default")
        cell?.mission_path.af_setImage(withURL: url!)
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let Storyboard = UIStoryboard(name: "Main", bundle: nil)
        let DVC = Storyboard.instantiateViewController(withIdentifier: "DetailVC") as! DetailViewController
        
        DVC.getName = mission_nameArr[indexPath.row]
        
        DVC.getImage = mission_patchArr[indexPath.row]
        
        DVC.getDate = mission_dateArr[indexPath.row]
        
        DVC.getDetail = mission_detailArr[indexPath.row]
        
        DVC.getWiki = mission_wikiArr[indexPath.row]
        
        DVC.getYouTb = mission_youTbArr[indexPath.row]
        
        DVC.getOrbcomm = mission_orbcommArr[indexPath.row]
        
        self.navigationController?.pushViewController(DVC, animated: true)
    }
}
