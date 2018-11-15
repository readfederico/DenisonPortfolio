//
//  ViewController.swift
//  Dineson
//
//  Created by Federico Read on 10/31/17.
//  Copyright © 2017 testing. All rights reserved.
//

import UIKit


class ViewController: UIViewController {

   // @IBOutlet var docPopView: UIView!
    @IBOutlet var docuPopView: UIView!
    
   // @IBOutlet weak var visualEffectVie: UIVisualEffectView!
    
    @IBOutlet weak var visualEffectView: UIVisualEffectView!
    
    var effect:UIVisualEffect!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        effect = visualEffectView.effect
        visualEffectView.effect = nil
        
        docuPopView.layer.cornerRadius = 5
    }
    
    func animateIn() {
        self.view.addSubview(docuPopView)
        docuPopView.center = self.view.center
        
        docuPopView.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
        docuPopView.alpha = 0
        
        UIView.animate(withDuration: 0.4){
            self.visualEffectView.effect = self.effect
            self.docuPopView.alpha = 1
            self.docuPopView.transform = CGAffineTransform.identity
            
        }
    }
    
    func animateOut(){
        UIView.animate(withDuration: 0.3, animations: {
            self.docuPopView.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
            self.docuPopView.alpha = 0
            
            self.visualEffectView.effect = nil
        }) { (success:Bool) in
            self.docuPopView.removeFromSuperview()
        }
    }

    @IBAction func popUpLoad(_ sender: AnyObject) {
        animateIn()
    }
    //@IBAction func popUpLoad(_ sender: AnyObject) {
    //    animateIn()
    //}
    @IBAction func popUpClose(_ sender: AnyObject) {
        animateOut()
    }
    
    //@IBAction func popUpClose(_ sender: AnyObject) {
   //     animateOut()
   // }
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

