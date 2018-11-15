//
//  CurtisClass.swift
//  Dineson
//
//  Created by Federico Read on 11/10/17.
//  Copyright © 2017 testing. All rights reserved.
//

import UIKit
import WebKit

extension Date {
    func dayOfWeek() -> Int? {
        let calender: Calendar = Calendar.current
        let component: DateComponents = (calender as NSCalendar).components(.weekday, from: self)
        return component.weekday
    }
}

class CurtisClass: UIViewController {

    @IBOutlet weak var curtisWebView: WKWebView!
    
    @IBOutlet weak var Curtis_status: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.dateCheck()
        
        // Do any additional setup after loading the view.
        let url = URL(string:"http://denison.cafebonappetit.com/cafe/curtis-cafe/")
        let request = URLRequest(url:url!)
        
        curtisWebView.load(request)
        
        let RightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(CurtswipeAction(swipe:)))
        RightSwipe.direction = UISwipeGestureRecognizerDirection.left
        self.view.addGestureRecognizer(RightSwipe)
        
        
    }
    
    func dateCheck()
    {
        let today = Date().dayOfWeek()
        
        if today == 1 || today ==  7
        {
            //print("Sunday")
            self.weekend()
        }
        else
        {
            //print("Saturday")
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
        Curtis_status.text = "Will be CLOSED until"+endTime
        Curtis_status.backgroundColor = UIColor.red
        Curtis_status.textColor = UIColor.white
        
    }
    
    func opened(endTime:String)
    {
        Curtis_status.text = "Open until "+endTime
        Curtis_status.backgroundColor = UIColor.green
        Curtis_status.textColor = UIColor.white
    }
    
    func openContinental(endTime:String)
    {
        Curtis_status.text = "Hot food starts at  "+endTime
        Curtis_status.backgroundColor = UIColor.green
        Curtis_status.textColor = UIColor.white
    }
    
    func openSnack(endTime:String)
    {
        Curtis_status.text = "Snack Break ends at  "+endTime
        Curtis_status.backgroundColor = UIColor.green
        Curtis_status.textColor = UIColor.white
    }
    
    //template for hours func uptoNight()
    // {
    //
    //     let time = getTime().hour
    
    //     switch time
    //     {
    //     case 09...20: opened(endTime: "21") //set time for 09:00 to 20:59
    //     default:closed(endTime: "4:30")
    //     }
    
    // }
    func weekDay()
    {
        
        let time = getTime().hour
        
        switch time
        {
        case 1...6: closed(endTime: " at 7:45")
        case 7:
            let minute = getTime().minute
            if minute < 45{
                closed(endTime: " at 7:45")
            }
            else{
                opened(endTime:" 10:45")
            }
        case 8...10:
            let minute = getTime().minute
            if time == 10 && minute < 45 {
                closed(endTime: " at 11")
            }
            else{
                opened(endTime:" 10:45")
            }
        case 11...13: opened(endTime: " 2:45")
            
        case 14:
            let minute = getTime().minute
            if minute >= 45{
                openSnack(endTime: " 4:15")
            }
            else{
                opened(endTime:" 2:45")
            }
        case 15:
            openSnack(endTime: " 4:15")
            
        case 16:
            let minute = getTime().minute
            if minute < 15{
                openSnack(endTime: " 4:15")
            }
            else if minute < 30{
                closed(endTime: " at 4:30")
            }
            else{
                opened(endTime:" 7")
            }
        case 17...18:
            opened(endTime:" 7")
            
        default:closed(endTime: " tomorrow")
        }
    }
    
    func weekend()
    {
        let time = getTime().hour
        
        switch time
        {
        case 1...8: closed(endTime: " at 9")
        case 9: openContinental(endTime: " 10")
            
        case 10...14:
            let minute = getTime().minute
            if time == 14 && minute >= 30{
                closed(endTime: " at 4:30")
            }
            else{
                opened(endTime:" 2:30")
            }
            
        case 15: closed(endTime: " at 4:30")
            
        case 16...18:
            let minute = getTime().minute
            if time == 16 && minute < 30{
                closed(endTime: " at 4:30")
            }
            else{
                opened(endTime:" 7")
            }
            
            break
            
        default:closed(endTime: " tomorrow")
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
    @objc func CurtswipeAction(swipe:UISwipeGestureRecognizer)
    {
        switch swipe.direction.rawValue {
        case 2:
            performSegue(withIdentifier: "Curt2Huff", sender: self)
        default:
            break
        }
    }
}
