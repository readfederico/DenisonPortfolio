//
//  HuffmanClass.swift
//  Dineson
//
//  Created by Federico Read on 11/10/17.
//  Copyright © 2017 testing. All rights reserved.
//

import UIKit
import WebKit


class HuffmanClass: UIViewController {
    
    @IBOutlet weak var huffmanWebView: WKWebView!
    
    @IBOutlet weak var HuffStatus: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let url = URL(string:"http://denison.cafebonappetit.com/cafe/huffman-cafe/")
        let request = URLRequest(url:url!)
        
        huffmanWebView.load(request)
        
        let RightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(HuffswipeAction(swipe:)))
        RightSwipe.direction = UISwipeGestureRecognizerDirection.left
        self.view.addGestureRecognizer(RightSwipe)
        self.dateCheck()
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
        HuffStatus.text = "Will be CLOSED until"+endTime
        HuffStatus.backgroundColor = UIColor.red
        HuffStatus.textColor = UIColor.white
        
    }
    
    func opened(endTime:String)
    {
        HuffStatus.text = "Open until  "+endTime
        HuffStatus.backgroundColor = UIColor.green
        HuffStatus.textColor = UIColor.white
    }
    
    func openContinental(endTime:String)
    {
        HuffStatus.text = "Hot food starts at  "+endTime
        HuffStatus.backgroundColor = UIColor.green
        HuffStatus.textColor = UIColor.white
    }
    
    func openSnack(endTime:String)
    {
        HuffStatus.text = "Snack Break ends at  "+endTime
        HuffStatus.backgroundColor = UIColor.green
        HuffStatus.textColor = UIColor.white
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
        case 1...6: closed(endTime: " 7:45")
        case 7:
            let minute = getTime().minute
            if minute < 45{
                closed(endTime: " 7:45")
            }
            else{
                opened(endTime:" 10:45")
            }
        case 8...10:
            let minute = getTime().minute
            if time == 10 && minute < 45 {
                closed(endTime: " 11")
            }
            else{
                opened(endTime:" 10:45")
            }
        case 11...12:
            let minute = getTime().minute
            if time == 11 && minute < 30{
                closed(endTime:" 11:30")
            }
            else{
                opened(endTime: " 1")
            }
        case 13...16:
            let minute = getTime().minute
            if time == 15 && minute >= 45{
                closed(endTime: " 5")
            }
            else{
                openSnack(endTime:" 4:45")
            }
        case 17...18:
            opened(endTime:" 8")
            
        default:closed(endTime: " tomorrow")
        }
        
    }
    
    
    func weekend()
    {
        
        let time = getTime().hour
        
        switch time
        {
        case 1...8: closed(endTime: " 9")
        case 9: openContinental(endTime: " 10")
            
        case 10...12:
            opened(endTime:" 2:30")
            
        case 15: closed(endTime: " 4:30")
            
        case 16...18:
            let minute = getTime().minute
            if time == 16 && minute < 30{
                closed(endTime: " 4:30")
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
}

extension UIViewController
{
    @objc func HuffswipeAction(swipe:UISwipeGestureRecognizer)
    {
        switch swipe.direction.rawValue {
        case 2:
            performSegue(withIdentifier: "Huff2Slay", sender: self)
        default:
            break
        }
    }
}
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */



