//
//  DetailViewController.swift
//  SpaceX_Lebedev
//
//  Created by Владимир on 14/07/2019.
//  Copyright © 2019 Владимир. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class DetailViewController: MainViewController {
    
    var getName = String()
    var getImage = String()
    var getDetail = String()
    var getDate = String()
    var getWiki = String()
    var getYouTb = String()
    var getOrbcomm = String()
    
    @IBOutlet weak var image_patch: UIImageView!
    @IBOutlet weak var mission_name: UILabel!
    @IBOutlet weak var date_label: UILabel!
    @IBOutlet weak var textDetail: UITextView!
    
    @IBOutlet weak var youTubeBtn: UIButton!
    @IBOutlet weak var wikipediaBtn: UIButton!
    @IBOutlet weak var orbcommBtn: UIButton!
    
    @IBAction func youTubeBtnAct(_ sender: UIButton) {
        let pathYT = getYouTb
        UIApplication.shared.open(URL(string: pathYT)! as URL, options: [:], completionHandler: nil)
    }
    
    @IBAction func wikipediaBtnAct(_ sender: UIButton) {
        let pathWiki = getWiki
        UIApplication.shared.open(URL(string: pathWiki)! as URL, options: [:], completionHandler: nil)
    }
    
    @IBAction func orbcommBtnAct(_ sender: UIButton) {
        let pathOrbcomm = getOrbcomm
        UIApplication.shared.open(URL(string: pathOrbcomm)! as URL, options: [:], completionHandler: nil)
        
    }    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let urrl = getImage.self
        let url = URL(string: urrl)
        self.image_patch.image = UIImage(named: "Default")
        self.image_patch.af_setImage(withURL: url!)

        self.mission_name.text = getName
        
        self.date_label.text = getDate
        
        textDetail.isEditable = false
        self.textDetail.text = getDetail
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        textDetail.layoutIfNeeded()
        textDetail.contentOffset = CGPoint.zero
    }
}


