//
//  CpuStrat.swift
//  ofc
//
//  Created by Alexey A on 28/08/2018.
//  Copyright © 2018 Alexey A. All rights reserved.
//

import Foundation


class CpuHandAnalyse {
    
    var currentHand = [(Int,String)]()
    
    var straightFlushDraws1 = [[String]]()
    
    var straightFlushDraws2 = [[String]]()
    
    var flushDraws1 = [String]()
    
    var flushDraws2 = [String]()
    
    var straightDraws = [[Int]]()
    
    var kinds1 = [Int]()
    
    var kinds2 = [Int]()
   
    var set = CpuSetHand()
    
    

    
    func getHand(startHand: [(Int,String)]) {
        
        currentHand = startHand
        
        currentHand = [(10,"s"),(12,"d"),(12,"s"),(12,"h"),(10,"h")]
        
        straightFlushAnalyse(hand: currentHand)
        
        straightAnalyse(hand: currentHand)
        
        kindAnalyse(hand: currentHand)
    }
  
    
    
    
    func howToSet() {
      
      /*  var massive = [straightFlushDraws1, straightFlushDraws2]
        
        for i in 0...1 {
            
            if massive[i].count != 0 {
        
                var min = massive[i][0].count
        
                for j in massive[i] {
            
                    if j.count < min {
                
                        min = j.count
                    }
                }
        
                var sort = [[String]]()
        
                for j in massive[i] {
            
                    if j.count == min {
                
                        sort.append(j)
                    }
                }
        
                massive[i] = sort
            }
        } // sorting
       
        for draws in massive {
            
            if !draws.isEmpty && draws[0].count < 5 {
                
                let first = Int(draws[0].first!)
                
                for i in first!...first! + 4 {
                    
                    var add = true
                    
                        for j in 1...draws[0].count - 1 {
                        
                            if let k = Int(draws[0][j]) {
                            
                                if  i == k {
                                
                                    add = false
                                }
                            }
                        }
                
                    if add {
                        
                        hands.append((i,draws[0][1]))
                        
                        var ind = 0
                        
                        for j in 0...currentHand.count - 1 {
                            
                            if currentHand[j].0 == i && currentHand[j].1 == draws[0][1] {
                                
                                ind = j
                            }
                        }
                        
                        currentHand.remove(at: ind)
                    }
                }
                
                if currentHand.count != 0 {
                    
                    for _ in 1...5 - hands.count {
                    
                        hands.append((0,""))
                    }

                }
                
                if currentHand.count != 0 {
                    
                    setOther()
                }
            }
        } // straight flushes
        
       */
        
    }
    
    
    
    func straightFlushAnalyse(hand: [(Int,String)]) {
        
        let cards = hand
        
        var withColors = Int()
        
        for i in cards {
            
            switch i.1 {
                
            case "c": withColors += 1000
                
            case "d": withColors += 100
                
            case "h": withColors += 10
                
            case "s": withColors += 1
                
            default:
                break
            }
        }
        
        var straightFlushCards1 = [Int]()
       
        var straightFlushCards2 = [Int]()
        
        var straightColors = [String]()
        
        let colorC = withColors / 1000
        
        let colorD = (withColors / 100) % 10
        
        let colorH = (withColors / 10) % 10
        
        let colorS = withColors % 10
        
        let colorsCount = [colorC, colorD, colorH, colorS]
        
        var split = false
        
        let col = ["c", "d", "h", "s"]
        
        for i in 0...3 { // split by colors
            
            if colorsCount[i] > 1 {
                
                straightColors.append(col[i])
                
                var key = 1
                
                if !straightFlushCards1.isEmpty {
                    
                    key = 2
                    
                    split = true
                    
                    straightColors.append(col[i])
                }
                
                for card in cards {
                    
                    if card.1 == col[i] {
                        
                        key == 1 ? straightFlushCards1.append(card.0) : straightFlushCards2.append(card.0)
                    }
                }
            }
        }
       
        // draws variations
        
        var index = 1
        
        if split {
            
            index = 2
        }
       
        for i in 1...index {
            
            var straight = [Int]()
            
            var flushCards = [Int]()
            
            var draws = [[String]]()
            
            var flushDraws = [String]()
            
            let color = straightColors[i-1]
            
            if i == 1 {
                
                straight = straightFlushCards1
                
                draws = straightFlushDraws1
                
                flushDraws = flushDraws1
                
                flushCards = straightFlushCards1
                
            } else {
                
                straight = straightFlushCards2
                
                draws = straightFlushDraws2
                
                flushDraws = flushDraws2
                
                flushCards = straightFlushCards2
            }
            
                   // flushDraws add
            
            flushDraws.append(straightColors[i-1])
            
            for i in 1...13 {
                
                var find = false
                
                for j in flushCards {
                    
                    if i == j {
                        
                        find = true
                    }
                }
                
                if !find {
                    
                    flushDraws.append(String(i))
                }
            }       // flushDraws end
            
        
            var range = [Int](repeatElement(0, count: 14))
            
            for i in straight {
                
                range[i-1] = i
            }
            
            if range[0] == 1 {
                
                range[13] = 14
            }
           
            for i in 0...9 {
                
                draws.append(["\(i+1)"])
                
                draws[i].append(color)
                
                for j in i...i+4 {
                    
                    if range[j] == 0 {
                        
                        draws[i].append("\(j+1)")
                    }
                }
            }
            
            if i == 1 {
                
                straightFlushCards1 = straight
                
                straightFlushDraws1 = draws
                
                flushDraws1 = flushDraws
                
                straightFlushCards1 = flushCards
                
            } else {
                
                straightFlushCards2 = straight
                
                straightFlushDraws2 = draws
                
                flushDraws2 = flushDraws
                
                straightFlushCards2 = flushCards
            }
        }
    }
    
    func kindAnalyse(hand: [(Int,String)]) {
        
        var cards = [Int]()
        
        var range = [[Int]](repeatElement([0], count: 13))
        
        for i in hand {
            
            if range[i.0 - 1] != [0] {
                
                range[i.0 - 1].append(i.0)
            
            } else {
                
                range[i.0 - 1] = [i.0]
            }
        }
        
        for i in range {
            
            if i != [0] {
                
                for j in i {
                    
                    cards.append(j)
                }
            }
        }
        
        for i in 0...cards.count - 2 {
            
            if cards[i] == cards[i+1] {
               
                if kinds1.count != 0 && cards[i] != kinds1.last! {
                    
                    kinds2.append(cards[i])
                
                } else {
                    
                    kinds1.append(cards[i])
                }
            }
        }
    }
    
    func straightAnalyse(hand: [(Int,String)]) {
       
        var cards = hand
        
        var range = [Int](repeatElement(0, count: 14))
        
        for i in cards {
            
            range[i.0 - 1] = i.0
        }
        
        if cards[0].0 == 1 {
            
            range[13] = 1
        }
        
        for i in 0...9 {
            
            straightDraws.append([i+1])
            
            for j in i...i+4 {
                
                if range[j] == 0 {
                    
                    straightDraws[i].append(j+1)
                }
            }
        }
    }
    
    
    
    
    
    
    
    
    

    
    func clear() {
        
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
