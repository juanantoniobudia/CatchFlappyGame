//
//  ViewController.swift
//  CatchFlappyGame
//
//  Created by Juan Antonio Ortega Budia on 12/1/23.
//

import UIKit

class ViewController: UIViewController {
    var score = 0
    var timer = Timer()//creo temporizador
    var makeVisibleImageTimer = Timer()
    var counter = 0
    var flappyArray = [UIImageView]()
    var highScore = 0

    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var highscoreLabel: UILabel!
    @IBOutlet weak var flappy1: UIImageView!
    @IBOutlet weak var flappy2: UIImageView!
    @IBOutlet weak var flappy3: UIImageView!
    @IBOutlet weak var flappy4: UIImageView!
    @IBOutlet weak var flappy5: UIImageView!
    @IBOutlet weak var flappy6: UIImageView!
    @IBOutlet weak var flappy7: UIImageView!
    @IBOutlet weak var flappy8: UIImageView!
    @IBOutlet weak var flappy9: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Highscore check
        let storedHighscore = UserDefaults.standard.object(forKey: "highscore")
        if storedHighscore == nil {
            highScore = 0
            highscoreLabel.text = "Score: \(highScore)"
        }
        if let newScore = storedHighscore as? Int {
            
            highScore = newScore
            highscoreLabel.text = "Highscore: \(highScore)"
            
        }
        
        //hago que se pueda hacer tap sobre la imagen
        flappy1.isUserInteractionEnabled = true
        flappy2.isUserInteractionEnabled = true
        flappy3.isUserInteractionEnabled = true
        flappy4.isUserInteractionEnabled = true
        flappy5.isUserInteractionEnabled = true
        flappy6.isUserInteractionEnabled = true
        flappy7.isUserInteractionEnabled = true
        flappy8.isUserInteractionEnabled = true
        flappy9.isUserInteractionEnabled = true
        //creo una accion para cuando haga tap sobre la imagen
        let recognizer1 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer2 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer3 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer4 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer5 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer6 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer7 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer8 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer9 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        //agrego la accion a la imagen
        flappy1.addGestureRecognizer(recognizer1)
        flappy2.addGestureRecognizer(recognizer2)
        flappy3.addGestureRecognizer(recognizer3)
        flappy4.addGestureRecognizer(recognizer4)
        flappy5.addGestureRecognizer(recognizer5)
        flappy6.addGestureRecognizer(recognizer6)
        flappy7.addGestureRecognizer(recognizer7)
        flappy8.addGestureRecognizer(recognizer8)
        flappy9.addGestureRecognizer(recognizer9)
        
        flappyArray = [flappy1,flappy2,flappy3,flappy4,flappy5,flappy6,flappy7,flappy8,flappy9]
        
        
        
        //Temporizador
        counter = 10
        flappy8.addGestureRecognizer(recognizer8)
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countDown), userInfo: nil, repeats: true)
        
        makeVisibleImageTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(hideFlappy), userInfo: nil, repeats: true)
        
        hideFlappy()
    }
    
    
    @objc func hideFlappy() {
        
        for flappy in flappyArray {
            
            flappy.isHidden = true
            
        }
        
        let random = Int(arc4random_uniform(UInt32(flappyArray.count)))//0..8
        flappyArray[random].isHidden = false
        
    }

    @objc func increaseScore() {
        
        score += 1
        scoreLabel.text = "Score: \(score)"
        
    }
    
    @objc func countDown() {
        
        counter -= 1
        timeLabel.text = String(counter)
        
        if counter == 0 {
            
            timer.invalidate()
            makeVisibleImageTimer.invalidate()
            for flappy in flappyArray {
                
                flappy.isHidden = true
                
            }
            
            //HighScore
            if self.score > self.highScore {
                self.highScore = self.score
                highscoreLabel.text = "Highscore: \(self.highScore)"
                UserDefaults.standard.set(self.highScore, forKey: "highscore")
            }
            
            //Alert
            let alert = UIAlertController(title: "The Time Is Up", message: "Do you wanna play again?", preferredStyle: UIAlertController.Style.alert)
            let okButtom = UIAlertAction(title: "Ok", style: UIAlertAction.Style.cancel, handler: nil)
            let replayButton = UIAlertAction(title: "Replay", style: UIAlertAction.Style.default)  {
                (UIAlertAction) in
                //replay function
                self.score = 0
                self.scoreLabel.text = "Score: \(self.score)"
                self.counter = 10
                self.timeLabel.text = String(self.counter)
                
                self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.countDown), userInfo: nil, repeats: true)
                
                self.makeVisibleImageTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(self.hideFlappy), userInfo: nil, repeats: true)
                
            }
            
            
            alert.addAction(okButtom)
            alert.addAction(replayButton)
                    
            self.present(alert, animated: true)
            
            
    
        }
        
    }
    
}

