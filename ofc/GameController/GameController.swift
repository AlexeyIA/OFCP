//
//  ViewController.swift
//  ofc
//
//  Created by Alexey A on 09/05/2018.
//  Copyright © 2018 Alexey A. All rights reserved.
//

import UIKit


class GameController: UIViewController {

    
   // var gameData = GameData()
    
    var placesLay = PlacesLay()
    
    
    var cardsColode = [(Int,String)]()
    
    var lay = Layout()
    
    var startRound = UIButton()
    
    
    var calc = Calculations()

    var cpu = CpuHandAnalyse()
    
    var playerHands = PlayerHandsData()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createStartLays()
    }
    
    func createStartLays() {
        
        placesLay.configureLayParameters(frame: view.frame)
        
        for i in placesLay.player {
            
            view.addSubview(i)
        }
        
        for i in placesLay.cpu {
            
            view.addSubview(i)
        }
        
        lay.createStartButton(button: startRound, frame: placesLay.player[4].frame, space: placesLay.distanceX)
        
        view.addSubview(startRound)
        
        startRound.addTarget(self, action: #selector(toNextRound), for: .touchUpInside)
    }

    
   
    @objc func toNextRound() {
        
        if calc.round == 0 {
           
            cardsColode.removeAll()
            
            cardsColode = [(Int,String)]()
            
            lay.clear()
            
            calc.clear()
            
            lay.createPlaces()
            
            for i in lay.cardPlacesLay {
            
                view.addSubview(i)
            }
            
            calc.start()
        }
        
        lay.clearMessages()
        
        calc.round += 1
        
        if calc.round == 1 {
            
            let colors = ["c","d","h","s"]
            
            for i in 1...13 {
                
                for j in colors {
                
                    cardsColode.append((i,j))
                }
            }
        
            getRandomHand()
            
            startRound.setTitle("OK", for: UIControlState.normal)
            
        } else {
            
            if calc.checkRound(inLay: lay).0 {
                
                lay.removeCurrent(number: calc.currentNum())
                
                calc.removeCurrent()
                
                if calc.round != 6 {
                
                    getRandomHand()
                
                } else {
                
                    makeSolid()
                    
                    var stage = String()
                    
                    var message = String()
                    
                    (stage,message) = calc.addHands()
                    
                    if stage == "score" {
                        
                        let scores = calc.addPoints()
                    
                        lay.showScore(hand: calc.handCombos, points: scores)
                    
                    } else {
                    
                        lay.showBreak(reason: message)
                    }
                    
                    calc.round = 0
                }
                
            } else {
                
                lay.breakReason.text = calc.checkRound(inLay: lay).1
                
                calc.round -= 1
            }
        }
    }
    
    /*
    
    func getRandomHand() {
        
        if calc.round == 2 {
            lay.layOfThree()
            calc.handsOfThree()
        }
        
        if calc.round != 1 { makeSolid() }
        
        var cpuHand = [(Int,String)]()
        
        for i in 1...calc.currentNum() {
            
            let j = Int(arc4random()%UInt32(cardsColode.count))
            
            calc.cardsOnDeck[i-1] = cardsColode[j]
            
            cardsColode.remove(at: j)
            
            let m = Int(arc4random()%UInt32(cardsColode.count))
            
            cpuHand.append(cardsColode[m])
            
            cardsColode.remove(at: m)
            
        }
        
        cpu.getHand(startHand: cpuHand)
        
        lay.createHand(hand: calc.cardsOnDeck, howMany: calc.currentNum())
        
        let shift = lay.cardsOnDeck[0].frame.height + 20
        
        for i in 0...(calc.currentNum() - 1) {
         
            let gesture = UIPanGestureRecognizer(target: self, action: #selector(GameController.wasDragged(_:)))
            
            lay.cardsOnDeck[i].addGestureRecognizer(gesture)
            
            lay.cardsOnDeck[i].isUserInteractionEnabled = true
            
            view.addSubview(lay.cardsOnDeck[i])
            
            lay.cardPlacesLay[i].tag = 1
            
            UIView.animate(withDuration: 0.5, animations: {
                self.lay.cardsOnDeck[i].center.y -= shift
            })
        }        
    }
    
    
    
    func wasDragged(_ sender: UIPanGestureRecognizer) {
        
        let translation = sender.translation(in: self.view)
        
        sender.view?.center = CGPoint(x: sender.view!.center.x + translation.x, y: sender.view!.center.y + translation.y)
        
        sender.setTranslation(CGPoint.zero, in: self.view)
        
        if sender.state == .ended {
            
            let toTag = lay.searchPlace(sender: sender.view!)
            
            let fromTag = sender.view!.tag
            
            var isLocked = true
            
            lay.cardPlacesLay[toTag].tag == 1 ? (isLocked = true):( isLocked = false)
        
            if !isLocked {
                
                sender.view!.tag = toTag
                
                self.lay.cardPlacesLay[toTag].tag = 1
                
                self.lay.cardPlacesLay[fromTag].tag = 0
                
                self.lay.cardsOnDeck[toTag] = sender.view! as! UILabel
                
                self.lay.cardsOnDeck[fromTag] = UILabel()
                
                self.calc.cardsOnDeck[toTag] = calc.cardsOnDeck[fromTag]
                
                self.calc.cardsOnDeck[fromTag] = (0,"")
                
                UIView.animate(withDuration: 0.2, animations: {
                  
                    sender.view!.center = self.lay.cardPlacesLay[toTag].center
                })
           
            } else {
            
                UIView.animate(withDuration: 0.2, animations: {
            
                    sender.view!.center = self.lay.cardPlacesLay[sender.view!.tag].center
                })
            }
        }
    }

    
    
    func makeSolid() {
      
        for i in lay.cardsOnDeck {
        
            i.isUserInteractionEnabled = false
        }
        
        for i in 3...lay.cardPlacesLay.count-1 {
            
            if lay.cardPlacesLay[i].tag == 1 {
            
                lay.cardPlacesLay[i].removeFromSuperview()
                
                lay.cardPlacesLay[i].layer.borderWidth = 1
                
                lay.cardPlacesLay[i].layer.borderColor = UIColor.darkGray.cgColor
                
                view.addSubview(lay.cardPlacesLay[i])
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
*/
}

