//
//  layout.swift
//  ofc
//
//  Created by Alexey A on 12/07/2018.
//  Copyright © 2018 Alexey A. All rights reserved.
//

import Foundation

import UIKit



class Layout  {



    var card = UILabel()

    var cardsOnDeck = [UILabel]()

    var onX = CGFloat()

    var onY = CGFloat()

    var topScore = UILabel()

    var middleScore = UILabel()

    var bottomScore = UILabel()

    var breakReason = UILabel()

    let combos =  ["High Card", "Pair", "Two pairs", "Set", "Straight", "Flush", "Full House", "Quads", "Straight Flush", "Royal Flush"]


//
//    func createPlaces () {
//
//
//        var scoreMessages = [bottomScore,middleScore,topScore]
//
//        var sOrigin = cardPlacesLay[9].frame.origin
//
//        sOrigin.x = sOrigin.x + distance + cardWidth
//
//        let sWidth = cardPlacesLay[9].frame.width * 2
//
//        var shift : CGFloat = 0
//
//        for i in 0...2 {
//
//            scoreMessages[i].frame = CGRect(x: sOrigin.x, y: sOrigin.y - shift, width: sWidth, height: cardHeight)
//
//            shift = shift + distance + cardHeight
//
//            scoreMessages[i].font = UIFont.systemFont(ofSize: 8)
//
//            scoreMessages[i].textAlignment = NSTextAlignment.center
//        }
//
//        topScore.center.x = topScore.center.x - 2 * (distance + cardWidth)
//
//        var bOrigin = cardPlacesLay[0].frame.origin
//
//        bOrigin.y = bOrigin.y - betweenField * cardHeight + distance
//
//        let bHeight = betweenField * cardHeight - 2 * distance
//
//        let bWidth = 5 * cardWidth + 4 * distance
//
//        breakReason.frame = CGRect(x: bOrigin.x, y: bOrigin.y, width: bWidth, height: bHeight)
//
//        breakReason.font = UIFont.systemFont(ofSize: 8)
//
//        breakReason.textAlignment = NSTextAlignment.center
//
//    }
//


    func createStartButton (button: UIButton, frame: CGRect, space: CGFloat) {

        let i = frame

        button.frame = CGRect(origin: i.origin, size: CGSize(width: i.width * 1.5 , height: i.height))

        button.frame.origin.x += (i.width + 2*space)

        button.backgroundColor = UIColor.lightGray

        button.layer.cornerRadius = 10

        button.layer.masksToBounds = true

        button.setTitle("PLAY", for: UIControl.State.normal)
        
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 10)
    }



//    func createHand (hand: [(Int,String)], howMany: Int) {
//
//        var currentCard = UILabel()
//
//        let yShift = cardPlacesLay[0].frame.height + 20
//
//        let width = cardPlacesLay[0].frame.width
//
//        let height = yShift - 20
//
//        for i in 0...(howMany-1){
//
//            let xPos = cardPlacesLay[i].frame.origin.x
//
//            let yPos = cardPlacesLay[i].frame.origin.y
//
//            currentCard.frame = CGRect(x: xPos, y: yPos + yShift, width: width, height: height)
//
//            currentCard.layer.cornerRadius = 3
//
//            currentCard.layer.masksToBounds = true
//
//            currentCard.backgroundColor = addColor(color: hand[i].1)
//
//            currentCard.tag = i
//
//            addNumber(num: hand[i].0, curCard: currentCard)
//
//            cardsOnDeck[i] = currentCard
//
//            currentCard = UILabel()
//        }
//    }



    func addColor (color: String) -> UIColor {

        var col = UIColor()

        switch color {

        case "d":
            col = UIColor(red: 102/255, green: 178/255, blue: 1, alpha: 1)
        case "c":
            col = UIColor(red: 0/255, green: 204/255, blue: 102/255, alpha: 1)
        case "h":
            col = UIColor(red: 255, green: 102/255, blue: 102/255, alpha: 1)
        case "s":
            col = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 1)
        default:
            break
        }

        return col
    }



    func addNumber (num: Int, curCard: UILabel) {

        var number = String(num)

        switch num {

        case 1:
            number = "A"
        case 11:
            number = "J"
        case 12:
            number = "Q"
        case 13:
            number = "K"
        default:
            break
        }

        curCard.text = number

        curCard.textColor = UIColor.white

        curCard.textAlignment = NSTextAlignment.center
    }



   
//    func searchPlace(sender: UIView) -> Int {
//
//        var placeTag = 0
//
//        var min = cardPlacesLay[0].bounds.height
//
//        var newMin = CGFloat()
//
//        for i in 0...(cardPlacesLay.count-1) {
//
//            let localX = cardPlacesLay[i].center.x
//
//            let localY = cardPlacesLay[i].center.y
//
//            let senderX = sender.center.x
//
//            let senderY = sender.center.y
//
//            var delX = CGFloat()
//
//            var delY = CGFloat()
//
//            if localX > senderX {
//
//                delX = localX - senderX
//
//            } else {
//
//                delX = senderX - localX
//            }
//
//            if localY > senderY {
//
//                delY = localY - senderY
//
//            } else {
//
//                delY = senderY - localY
//            }
//
//            newMin = CGFloat(sqrtf(Float(delX*delX + delY*delY)))
//
//            if newMin < min {
//
//                min = newMin
//
//                placeTag = i
//            }
//        }
//
//        return placeTag
//    }
//
//
//
//    func layOfThree() {
//
//        cardPlacesLay[3].removeFromSuperview()
//
//        cardPlacesLay[4].removeFromSuperview()
//
//        cardPlacesLay.remove(at: 3)
//
//        cardPlacesLay.remove(at: 3)
//
//        cardsOnDeck.remove(at: 3)
//
//        cardsOnDeck.remove(at: 3)
//
//        for i in 3...15 {
//
//            if cardsOnDeck[i].tag != 0 { cardsOnDeck[i].tag -= 2 }
//        }
//    }
//
//
//
//    func removeCurrent (number: Int) {
//
//        for i in 0...(number - 1) {
//
//            cardsOnDeck[i].removeFromSuperview()
//
//            cardsOnDeck[i] = UILabel()
//
//            cardPlacesLay[i].tag = 0
//        }
//    }
//
//
//
//    func showScore(hand: [Int], points: [Int]) {
//
//        var labels = [bottomScore,middleScore,topScore]
//
//        var score = 0
//
//        for i in 0...2 {
//
//            labels[i].text = "+" + String(points[i]) + ", " + String(combos[hand[i]])
//
//            labels[i].font = UIFont.systemFont(ofSize: 8)
//
//            labels[i].textAlignment = NSTextAlignment.center
//
//            score += points[i]
//        }
//
//        breakReason.text = "hand completed, total score: \(score)"
//
//    }
//
//
//
//    func showBreak(reason: String) {
//
//        breakReason.text = reason
//
//    }
//
//
//
//    func clearMessages() {
//
//    let messages = [breakReason, bottomScore, middleScore, topScore]
//
//        for i in messages {
//
//            i.text = ""
//        }
//    }
//
//
//
//    func clear() {
//
//        for i in cardPlacesLay {
//
//            i.removeFromSuperview()
//        }
//
//        cardPlacesLay.removeAll()
//
//        for i in cardsOnDeck {
//
//            i.removeFromSuperview()
//        }
//
//        cardsOnDeck.removeAll()
//
//        card = UILabel()
//    }
}









