//
//  GameData.swift
//  ofc
//
//  Created by Alexey A on 14/09/2018.
//  Copyright © 2018 Alexey A. All rights reserved.
//

import Foundation


class GameData {
    
    var isPlayerFirst = Bool()
    
    var cardsColode = [(Int,String)]()
    
    
    
    func whoIsFirst() {
        
        if arc4random()%2 == 0 {
            
            isPlayerFirst = true
            
        } else {
            
            isPlayerFirst = false
        }
    }
    
    
    
    
    
    
    
    
}
