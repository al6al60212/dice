//
//  diceTool.swift
//  dice
//
//  Created by 董禾翊 on 2022/9/24.
//

import UIKit
import AVFoundation

class diceTool: UIViewController {

    @IBOutlet var diceImageViews: [UIImageView]!
    @IBOutlet var sumLables: [UILabel]!
    var leftSum = 3
    var rightSum = 3
    var total = 0
    var index = 0
    var player: AVPlayer?
    override func viewDidLoad() {
        super.viewDidLoad()
        total = leftSum + rightSum
        // Do any additional setup after loading the view.
        sumLables[0].text = "合計：\(leftSum)"
        sumLables[1].text = "合計：\(rightSum)"
        sumLables[2].text = "總計：\(total)"
    }
    
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
       if motion == .motionShake {
           voice()
           let rollDiceAnimate = CABasicAnimation(keyPath: "transform.rotation")
           rollDiceAnimate.fromValue = 0
           rollDiceAnimate.toValue = Float.pi * 6
           rollDiceAnimate.duration = 1
           leftSum = 0
           rightSum = 0
           for index in 0...2{
               let number = Int.random(in: 1...6)
               diceImageViews[index].image = UIImage(named: "dice\(number)")
               diceImageViews[index].layer.add(rollDiceAnimate, forKey: nil)
               leftSum += number
           }
           for index in 3...5{
               let number = Int.random(in: 1...6)
               diceImageViews[index].image = UIImage(named: "dice\(number)")
               diceImageViews[index].layer.add(rollDiceAnimate, forKey: nil)
               rightSum += number
           }
           sumLables[0].text = "合計：\(leftSum)"
           sumLables[1].text = "合計：\(rightSum)"
           total = leftSum + rightSum
           sumLables[2].text = "總計：\(total)"
       }
    }
    
    func voice(){
        let url = Bundle.main.url(forResource: "搖骰聲", withExtension: "mp3")!
        player = AVPlayer(url: url)
        player?.play()
    }
   

    
    @IBAction func leftRollDiceBtn(_ sender: Any) {
        voice()
        let rollDiceAnimate = CABasicAnimation(keyPath: "transform.rotation")
        rollDiceAnimate.fromValue = 0
        rollDiceAnimate.toValue = Float.pi * 6
        rollDiceAnimate.duration = 1
        leftSum = 0
        for index in 0...2{
            let number = Int.random(in: 1...6)
            diceImageViews[index].image = UIImage(named: "dice\(number)")
            diceImageViews[index].layer.add(rollDiceAnimate, forKey: nil)
            leftSum += number
        }
        sumLables[0].text = "合計：\(leftSum)"
        total = leftSum + rightSum
        sumLables[2].text = "總計：\(total)"
    }
    
    @IBAction func rightRollDiceBtn(_ sender: Any) {
        voice()
        let rollDiceAnimate = CABasicAnimation(keyPath: "transform.rotation")
        rollDiceAnimate.fromValue = 0
        rollDiceAnimate.toValue = Float.pi * 6
        rollDiceAnimate.duration = 1
        rightSum = 0
        for index in 3...5{
            let number = Int.random(in: 1...6)
            diceImageViews[index].image = UIImage(named: "dice\(number)")
            diceImageViews[index].layer.add(rollDiceAnimate, forKey: nil)
            rightSum += number
        }
        sumLables[1].text = "合計：\(rightSum)"
        total = leftSum + rightSum
        sumLables[2].text = "總計：\(total)"
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
