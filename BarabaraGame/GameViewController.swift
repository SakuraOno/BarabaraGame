//
//  GameViewController.swift
//  BarabaraGame
//
//  Created by 小野　櫻 on 2018/04/13.
//  Copyright © 2018年 小野　櫻. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {
    
    @IBOutlet var imageView1 : UIImageView!
    @IBOutlet var imageView2 : UIImageView!
    @IBOutlet var imageView3 : UIImageView!
    
    @IBOutlet var resultLabel : UILabel!
    
    
    var timer : Timer!
    var score : Int = 1000
    let defaults : UserDefaults = UserDefaults.standard
    
    let width : CGFloat = UIScreen.main.bounds.size.width
    
    var positionx: [CGFloat] = [0.0,0.0,0.0]
    var dx: [CGFloat] = [1.0,0.5,-1.0]
    
    func start() {
        //結果ラベルを見えなくする
        resultLabel.isHidden = true
        
        //タイマーを動かす
        timer = Timer.scheduledTimer(timeInterval: 0.005, target: self, selector: #selector(self.up), userInfo: nil, repeats: true)
        timer.fire()
        
    }
    
    @objc func up() {
        for i in 0..<3 {
            //橋に来たら動かす向きを逆にする
            if positionx[i] > width || positionx[i] < 0 {
                dx[i] = dx[i] * (-1)
            }
            positionx[i] += dx[i]//画像の向きをdx分ずらす
        }
        imageView1.center.x = positionx[0]//上の画像をずらした位置に移動させる
        imageView2.center.x = positionx[1]//真ん中の画像をずらした位置に移動させる
         imageView2.center.x = positionx[2]//下の画像をずらした位置に移動させる
        
    }
    //ストップボタンを押したら
    @IBAction func stop() {
        if timer.isValid == true{//もしタイマーが動いていたら
            timer.invalidate()//タイマーを止める（無効にする）
     
        }
        
        for i in 0..<3 {
            score = score - abs(Int(width/2 - positionx[i]))*2//スコアの計算をする
        }
        resultLabel.text = "SCORE:" + String(score)//結果ラベルのスコアを表示する
        resultLabel.isHidden = false//結果ラベルを隠さない(現す)
        
        let highScore1: Int = defaults.integer(forKey: "score1")
        let highScore2: Int = defaults.integer(forKey: "score2")
        let highScore3: Int = defaults.integer(forKey: "score3")
        
        if score > highScore1{
            defaults.set(score, forKey: "score1")
            defaults.set(highScore1, forKey: "score2")
            defaults.set(highScore2, forKey: "score3")
        } else if score > highScore2{
            defaults.set(score, forKey: "score2")
            defaults.set(highScore2, forKey: "score3")
        } else if score > highScore3{
            defaults.set(highScore3, forKey:"score4")
            
        }
        defaults.synchronize()
    }
    
    @IBAction func retry() {
            score = 1000//スコアの値をリセットする
            positionx = [width/2,width/2,width/2]//画像を画面の真ん中に戻す
            if timer.isValid == false {
                self.start()//スタートメソッドを呼び出す
            }
    }
    
      @IBAction func toTop() {
        self.dismiss(animated:true, completion: nil)
        }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        super.viewDidLoad()
        positionx = [width/2,width/2,width/2]
        self.start()


        // Do any additional setup after loading the view.
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
