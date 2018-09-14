//
//  CpuHandAnalyse.swift
//  ofc
//
//  Created by Alexey A on 10/09/2018.
//  Copyright © 2018 Alexey A. All rights reserved.
//

import Foundation


class CpuSetHand {
    
    
    
    
   /* func setOther() {
     
        let otherCardsCount = currentHand.count
     
        var highCard = [Bool](repeatElement(false, count: otherCardsCount))
     
        for i in 0...otherCardsCount - 1 {
     
            if currentHand[i].0 == 1 {
     
                currentHand[i].0 = 14
            }
     
            if currentHand[i].0 > 11 {
     
                highCard[i] = true
            }
        }
     
        for _ in 1...8 {
     
            hands.append((0,""))
        }
     
        if otherCardsCount == 1 {
     
            hands[5] = currentHand[0]
     
        } else {
     
            var queen = 2 // any > 1
     
            for i in 0...1 {
     
                if currentHand[i].0 == 1 {
                    
                    currentHand[i].0 = 14
                }
                
                if currentHand[i].0 == 12 {
                    
                    queen = i
                }
            }
            
            if queen != 2 && currentHand[1-queen].0 > 12 {
                
                hands[5] = currentHand[1-queen]
                
                hands[10] = currentHand[queen]
                
            } else {
                
                hands[5] = currentHand[0]
                
                hands[6] = currentHand[1]
            }
        }
        
        
        
        
    }*/
}
