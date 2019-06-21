//
//  DetailViewController.swift
//  Alarming
//
//  Created by Jae Heo on 19/06/2019.
//  Copyright © 2019 iExploits. All rights reserved.
//

import UIKit
import GoogleMaps

class DetailViewController: UIViewController{
    
    @IBOutlet weak var tableView: UITableView!
    var disaster: DisasterInfo!
    @IBOutlet weak var type_img: UIImageView!
    @IBOutlet weak var type: UILabel!
    @IBOutlet weak var location: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var guideline: UITextView!
    
    let test_Image = ["twitter","twitter","twitter"]
    let test_Time = ["2019. 09. 18. 15:30:04", "2019. 09. 18. 15:30:55", "2019. 09. 18. 15:31:49" ]
    let test_Content = ["아니 진짜 산불났어 천마산;;; ", "천마산 화재..\n 모두들 조심하세요ㅠㅠㅠ", "우리집 ㅋㅋㅋㅋㅋ\n뒤에가 천마산인데 뭐냐 \n불타오르네 !"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        guideline.text = " 1. 산불보다 높은 위치를 피한다. \n 2. 화재가 약한 곳으로 신속히 대피한다. \n 3. 연료가 없는 지역으로 피한다. \n 4. 복사열로부터 멀리 있는 위치로 피한다."
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    
}

extension DetailViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return test_Image.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath) as! SNSFeedCell
        
        cell.snsType.image = UIImage(named: test_Image[indexPath.row])
        cell.feedTime.text = test_Time[indexPath.row]
        cell.feedContent.text = test_Content[indexPath.row]
        
        cell.layer.masksToBounds = true
        cell.layer.cornerRadius = 5
        cell.layer.borderWidth = 1
        
        
        
        return cell
    }
    
    
}

extension DetailViewController: UITableViewDelegate {
    
}
