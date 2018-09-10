//
//  Calculations.swift
//  ofc
//
//  Created by Alexey A on 24/07/2018.
//  Copyright © 2018 Alexey A. All rights reserved.
//

import Foundation

import UIKit



class Calculations: UIViewController {

    
    
    var round = Int()
    
    var cardsOnDeck = [(Int,String)]()
    
    var bottomHand = [(Int,String)]()
    
    var middleHand = [(Int,String)]()
    
    var topHand = [(Int,String)]()
    
    var bottomSort = [[String]]()
    
    var middleSort = [[String]]()
    
    var topSort = [[String]]()
    
    var handCombos = [0,0,0]
    
    
   
    func start () {
    
        round = 0
        
        for _ in 0...17 {
        
            cardsOnDeck.append((0,""))
        }
    }
    
    
    
    func currentNum() -> Int {
    
        if round > 1 {
        
            return 3
        
        } else {
        
            return 5
        }
    }
  
    
    
    func checkRound(inLay: Layout) -> (Bool,String) {
        
        var next = true
    
        var error = "no errors"
        
        switch round {
        
        case 2:
            
            for i in 0...4 {
        
                if inLay.cardPlacesLay[i].tag == 1 {
                
                    next = false
                    
                    error = "Put all 5 cards"
                }
            }
            
        case 3,4,5,6 :
            
            var j = 0
            
            for i in 0...2 {
            
                if inLay.cardPlacesLay[i].tag == 1 {
                
                    j += 1
                }
            }
            
            if j != 1 {
                
                next = false
                
                error = "One card must be unused"
            }
            
        default:
            break
        }
     
        return (next,error)
    }
    
    
    
    func removeCurrent() {
    
        for i in 0...(currentNum() - 1) {
        
            cardsOnDeck[i] = (0,"")
        }
    }
    
    
    
    func handsOfThree() {
    
        cardsOnDeck.remove(at: 3)
        
        cardsOnDeck.remove(at: 3)
    }
    

    
    func addHands() -> (String,String) {
        
        for i in 3...7 {
    
            bottomHand.append(cardsOnDeck[i])
        }
        
        for i in 8...12 {
        
            middleHand.append(cardsOnDeck[i])
        }
        
        for i in 13...15 {
        
            topHand.append(cardsOnDeck[i])
        }
        
        bottomSort = sortHands(hand: bottomHand)
        
        middleSort = sortHands(hand: middleHand)
        
        topSort = sortHands(hand: topHand)
        
        checkCombos(sort: bottomSort, inHand: "bottom")
        
        checkCombos(sort: middleSort, inHand: "middle")
        
        checkCombos(sort: topSort, inHand: "top")
        
        return checkPoints(hands: handCombos)
    }
    
    
    
    func sortHands(hand: [(Int,String)]) -> [[String]] {
        
        var sort = [[String]](repeating: [""], count: 14)
     
        for i in hand {
           
            if sort[i.0] == [""] {
            
                sort[i.0] = [i.1]
            
            } else {
            
                sort[i.0].append(i.1)
            }
        }
    
        var ind = [Int]() // contain indexes of zeros element
        
        for i in 0...13 {
            
            if sort[i] == [""] {
            
                ind.append(i)
            
            } else {
            
                sort[i].append(String(i))
            }
        }
        
        let j = ind.count
        
        for _ in 1...j { // deleting zeros in sort hand
            
            sort.remove(at: ind[0])
            
            for s in 0...ind.count-1 {
                if ind[s] != 0 {
                    ind[s] -= 1
                }
            }
            
            ind.remove(at: 0)
        }
        return sort
    }
     
     
    func checkCombos(sort: [[String]], inHand: String) {
     
        var combo = 0
        
        switch sort.count {
            
        case 1:
            
            combo = 3
       
        case 2: // quads, fullhouse
            
            if sort[0].count == 5 {
            
                combo = 7
            
            } else if sort[1].count == 5 {
            
                combo = 7
            }
            
            if sort[0].count == 4 {
            
                combo = 6
            
            } else if sort[1].count == 4 {
            
                combo = 6
            }
            
            if inHand == "top" {
              
                combo = 1
            }
            
        case 3: // tpairs, set, hCard in top
            var i = 0
            
            for j in sort {
                if j.count != 2 {
                    i += j.count
                }
            }
            
            if i == 6 {
                combo = i - 4
            } else if i == 4 {
                combo = i - 1
            } else {
                combo = i
            }
            
        
        case 4: // pair
            for i in 0...3 {
                if sort[i].count == 3 {
                    combo = 1
                }
            }
     
        case 5: // straight hCard flush sf rf
            
            var hValues = [Int]()
            
            hValues.append(Int(sort[0].last!)!)
            
            let color = sort[0].first
            
            var flsuh = true
            
            var royal = false
            
            var straight = true
            
            for i in 1...sort.count-1 {
            
                if sort[i].first != color { flsuh = false }
     
                if (Int(sort[i].last!)! - 1) != hValues.last! { straight = false}
                
                hValues.append(Int(sort[i].last!)!)
            }
            
            if hValues == [1,10,11,12,13] {
               
                straight = true
                
                royal = true
            }
            
            if straight { combo = 4 }
            
            if flsuh { combo = 5 }
            
            if straight && flsuh { combo = 8 }
            
            if royal && flsuh { combo = 9 }
     
        default:
            break
        }
        
        switch inHand {
        
        case "bottom":
            handCombos[0] = combo
        case "middle":
            handCombos[1] = combo
        case "top":
            handCombos[2] = combo
        default:
            break
        }
    }
    
    
    func checkPoints(hands: [Int]) -> (String,String) {
        
        var stage = String()
        var firstCompare = true
        var secondCompare = true
        var message = String()
        
        if hands[1] == hands[0] {
            (firstCompare,message) = compare(hand1: bottomSort, hand2: middleSort, named: ("bottom","middle"), tag: hands[1])
        }
        if  hands[1] > hands[0] {
            firstCompare = !firstCompare
            message = "combo in middle > combo in  bottom"
        }
        if hands[1] == hands[2] && firstCompare {
            var mes2 = String()
            (secondCompare,mes2) = compare(hand1: middleSort, hand2: topSort, named: ("middle","top"), tag: hands[2])
            if message != "ok" {
                message = mes2
            }
        }
        if firstCompare && hands[2] > hands[1] {
            secondCompare = !secondCompare
            message = "combo in top > combo in  middle"
        }
        if firstCompare && secondCompare {
            stage = "score"
        } else {
            stage = "break"
        }
        
        return (stage,message)
    }
    
    func compare(hand1: [[String]], hand2: [[String]], named: (String,String), tag: Int) -> (Bool,String) {
        
        var next = true
        var message = "ok"
        
        let hand1Name = named.0
        let hand2Name = named.1
        
    
        switch tag {
        
        case 0,4,5,8:
            
         return compareHighCard(hand1: hand1, hand2: hand2, named: named)
            
        case 1:
            
            var pair1 = 0
            var pair2 = 0
            
            for i in hand1 {
                if i.count == 3 {
                    pair1 = Int(i.last!)!
                }
            }
            for i in hand2 {
                if i.count == 3 {
                    pair2 = Int(i.last!)!
                }
            }
            if pair1 == pair2 {
                return compareHighCard(hand1: hand1, hand2: hand2, named: named)
            } else {
                if pair2 > pair1 && pair1 != 1 {
                    next = false
                    message = "Pair of \(pair2) in \(hand2Name) > pair of \(pair1) in \(hand1Name)"
                }
            }
            return(next,message)
        
        case 2:
            
            var fPair1 = 0
            var sPair1 = 0
            
            var fPair2 = 0
            var sPair2 = 0
            
            for i in hand1 {
                if i.count == 3 {
                    fPair1 == 0 ? (fPair1 = Int(i.last!)!) : (sPair1 = Int(i.last!)!)
                }
            }
            if fPair1 == 1 {
                let j = sPair1
                sPair1 = 14
                fPair1 = j
            }
            for i in hand2 {
                if i.count == 3 {
                    fPair2 == 0 ? (fPair2 = Int(i.last!)!) : (sPair2 = Int(i.last!)!)
                }
            }
            if fPair2 == 1 {
                let j = sPair2
                sPair2 = 14
                fPair2 = j
            }
            if sPair1 == sPair2 && fPair1 == fPair2 {
                return compareHighCard(hand1: hand1, hand2: hand2, named: named)
            } else {
                if sPair2 > sPair1 {
                    next = false
                    message = "Pairs of \(sPair2) in \(hand2Name) > pairs of \(sPair1) in \(hand1Name)"
                } else if (sPair2 == sPair1) && (fPair2 > fPair1) {
                    next = false
                    message = "Pairs of \(fPair2) in \(hand2Name) > pairs of \(fPair1) in \(hand1Name)"
                }
            }
            return(next,message)
        
        case 3:
            var set1 = 0
            var set2 = 0
            
            for i in hand1 {
                if i.count == 4 {
                    set1 = Int(i.last!)!
                }
            }
            for i in hand2 {
                if i.count == 4 {
                    set2 = Int(i.last!)!
                }
            }
            
            if set2 > set1 && set1 != 1 {
                next = false
                message = "Set of \(set2) in \(hand2Name) > set of \(set1) in \(hand1Name)"
            }
        
            return(next,message)
        
        case 6:
            
            var fh1 = 0
            var fh2 = 0
            
            for i in hand1 {
                if i.count == 4 {
                    fh1 = Int(i.last!)!
                }
            }
            for i in hand2 {
                if i.count == 4 {
                    fh2 = Int(i.last!)!
                }
            }
            
            if fh2 > fh1 && fh1 != 1 {
                next = false
                message = "Fullhouse of \(fh2) in \(hand2Name) > fullhouse of \(fh1) in \(hand1Name)"
            }
        
            return(next,message)
        
        case 7:
            var qds1 = 0
            var qds2 = 0
            
            for i in hand1 {
                if i.count == 5 {
                    qds1 = Int(i.last!)!
                }
            }
            for i in hand2 {
                if i.count == 5 {
                    qds2 = Int(i.last!)!
                }
            }
            
            if qds2 > qds1 && qds1 != 1 {
                next = false
                message = "Quads of \(qds2) in \(hand2Name) > quads of \(qds1) in \(hand1Name)"
            }
            return(next,message)
        default:
            break
        }
        
        return(next,message)
        
    }
    
    func compareHighCard (hand1: [[String]], hand2: [[String]], named: (String,String)) -> (Bool,String) {
        
        var next = true
        var message = "ok"
        
        let hand1Name = named.0
        let hand2Name = named.1
        
        var haveAceFirst = false
        var haveAceSecond = false
        
        if Int(hand1[0].last!)! == 1 { haveAceFirst = true }
        if Int(hand2[0].last!)! == 1 { haveAceSecond = true }
        
        if haveAceSecond == haveAceFirst {
            
            for i in 0...hand2.count-1 {
                let index = hand2.count-1-i
                if (Int(hand2[index].last!)! > Int(hand1[hand1.count-1-i].last!)!) && next {
                    next = false
                    message = "High card \(hand2[index].last!) in \(hand2Name) > \(hand1[hand1.count-1-i].last!) in \(hand1Name)"
                }
            }
        } else {
            
            if haveAceSecond && !haveAceFirst {
                next = false
                message = "High card Ace in \(hand2Name) > \(hand1[0].last!) in \(hand1Name)"
            }
        }
        return(next,message)
    }
    
    
    func addPoints() -> [Int] {
        
        var points = [Int]()
        
        for  i in 0...2 {
        
            var point = 0
        
            let scores = [ 0, 0, 0, 2, 4, 8, 12, 20, 30, 50 ]
        
            switch i {
            
            case 0:
            
                if handCombos[i] > 3 {
                
                    point = scores[handCombos[i]] / 2
                }
            
            case 1:
            
                point = scores[handCombos[i]]
            
            case 2:
                
                if handCombos[i] == 1 {
                   
                    if topSort[0].count == 3 {
                        
                        let pair = Int(topSort[0].last!)!
                        
                        if pair == 1 { point = 9 }
                        
                        if pair - 5 > 0 {
                            
                            point = pair - 5
                        }
                        
                    } else {
                        
                        let pair = Int(topSort[1].last!)!
                        
                        if pair - 5 > 0 {
                            
                            point = pair - 5
                        }
                    }
                }
                
                if handCombos[i] == 3 {
                    
                    let set = Int(topSort[0].last!)!
                    
                    if set == 1 {
                        
                        point = 22
                    
                    } else {
                    
                        point = set + 8
                    }
                }
            
            default:
                break
            }
            
            points.append(point)
        }
    
        return points
    }

    
    
    func clear() {
       
        round = 0
        
        cardsOnDeck.removeAll()
        
        bottomHand.removeAll()
        middleHand.removeAll()
        topHand.removeAll()
        
        bottomSort.removeAll()
        middleSort.removeAll()
        topSort.removeAll()
        
        handCombos = [0,0,0]
    }
    
}
