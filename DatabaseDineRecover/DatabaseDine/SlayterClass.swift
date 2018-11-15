//
//  SlayterClass.swift
//  Dineson
//
//  Created by Federico Read on 11/10/17.
//  Copyright © 2017 testing. All rights reserved.
//

import UIKit
import WebKit
class SlayterClass: UIViewController {
    
    @IBOutlet weak var slayterWebView: WKWebView!
    
    @IBOutlet weak var Slayter_status: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let url = URL(string:"http://denison.cafebonappetit.com/cafe/slayter-market/")
        let request = URLRequest(url:url!)
        
        slayterWebView.load(request)
        
        let RightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(SlayswipeAction(swipe:)))
        RightSwipe.direction = UISwipeGestureRecognizerDirection.left
        self.view.addGestureRecognizer(RightSwipe)
        
        self.dateCheck()
    }
    
    func dateCheck()
    {
        let today = Date().dayOfWeek()
        
        if today == 1 || today == 7
        {
            //print("Sunday")
            self.weekend()
        }
            
        else
        {
            self.weekDay()
        }
    }
    
    func getTime() -> (hour:Int, minute:Int, second:Int) {
        let currentDateTime = Date()
        let calendar = NSCalendar.current
        let component = calendar.dateComponents([.hour,.minute,.second], from: currentDateTime)
        let hour = component.hour
        let minute = component.minute
        let second = component.second
        return (hour!,minute!,second!)
    }
    
    
    func closed(endTime:String)
    {
        Slayter_status.text = "CLOSED until"+endTime
        Slayter_status.backgroundColor = UIColor.red
        Slayter_status.textColor = UIColor.white
        
    }
    
    func opened(endTime:String)
    {
        Slayter_status.text = "Open! Declining NOT accepted until "+endTime
        Slayter_status.backgroundColor = UIColor.green
        Slayter_status.textColor = UIColor.white
    }
    
    func openedDeclining(endTime:String)
    {
        Slayter_status.text = "Open and accepting Declining until "+endTime
        Slayter_status.backgroundColor = UIColor.green
        Slayter_status.textColor = UIColor.white
    }
    
    func weekDay()
    {
        let time = getTime().hour
        
        switch time
        {
        case 0: openedDeclining(endTime: " 11")
            
        case 7...10: openedDeclining(endTime: " 10:45")
        case 11...12: opened(endTime: " 1")
        case 13...23: openedDeclining(endTime: " 1")
        default:closed(endTime: " 7")
        }
    }
    
    func weekend()
    {
        let time = getTime().hour
        
        switch time
        {
        case 12...23: openedDeclining(endTime: " 2:30")
            
        default:closed(endTime: " 12")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension UIViewController
{
    @objc func SlayswipeAction(swipe:UISwipeGestureRecognizer)
    {
        switch swipe.direction.rawValue {
        case 2:
            performSegue(withIdentifier: "Slay2Curt", sender: self)
        default:
            break
        }
    }
}
