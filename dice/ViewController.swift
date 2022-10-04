//
//  ViewController.swift
//  dice
//
//  Created by 董禾翊 on 2022/9/21.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    @IBOutlet weak var dicePlate: UIImageView!
    @IBOutlet var diceImageViews: [UIImageView]!
    @IBOutlet weak var diceCup: UIImageView!
    var player: AVPlayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        dicePlate.transform = CGAffineTransform(rotationAngle: .pi / 180 * -2)
    }
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
       if motion == .motionShake {
          rollDice()
           
       }
    }


    func voice(){
        let url = Bundle.main.url(forResource: "搖骰聲", withExtension: "mp3")!
        player = AVPlayer(url: url)
        player?.play()
    }
    
    func rollDice(){
        diceCup.shake()
        dicePlate.shake()
        dicePlate.transform = CGAffineTransform(rotationAngle: .pi / 180 * -2)
        voice()
        let rotateAnimation = CABasicAnimation(keyPath: "transform.rotation")
        rotateAnimation.fromValue = 0
        rotateAnimation.toValue = Float.pi * 6
        rotateAnimation.duration = 1
        
        for diceImageView in diceImageViews {
            let number = Int.random(in: 1...6)
            diceImageView.image = UIImage(named: "dice\(number)")
            diceImageView.layer.add(rotateAnimation, forKey: nil)
        }
    }
    
    @IBAction func look(_ sender: UISwitch) {
        if sender.isOn{
            diceCup.alpha = 0.7
        }else{
            diceCup.alpha = 1
        }
    }
    
    @IBAction func openSwitch(_ sender: UISwitch) {
        if sender.isOn{
            diceCup.transform = CGAffineTransform(translationX: 0, y: -180)
        }else{
            diceCup.transform = CGAffineTransform(translationX: 0, y: 0)
        }
    }
    
}

extension UIView {
    func shake(times: Int = 5,deltaX : CGFloat = 10) {
        let shakeAnimator = UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.1, delay: 0, options: [.curveEaseIn], animations: {
            self.layer.setAffineTransform(CGAffineTransform(translationX: deltaX, y: 0))
        })
        { (_) in
            if times != 0 {
                self.shake(times: times - 1, deltaX: -deltaX)
            } else {
                self.layer.setAffineTransform(CGAffineTransform.identity)
            }
        }
        shakeAnimator.startAnimation()
    }
}
