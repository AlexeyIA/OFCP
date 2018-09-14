//
//  PlayerLayData.swift
//  ofc
//
//  Created by Alexey A on 14/09/2018.
//  Copyright © 2018 Alexey A. All rights reserved.
//

import Foundation

import UIKit



class PlayerLayData {
    
    let upDownBorders : CGFloat = 10.0
    
    let percentOfGlobalWidth : CGFloat = 0.5
    
    let distancePercent : CGFloat = 0.01 // 1 unit of distance = 1% of width
    
    let rightField : CGFloat = 2 // 2 cards
    
    let betweenField : CGFloat = 0.5 // distance between Lines block and current hand = 0.5 card
    
    
    
    var firstPoint = CGPoint()
    
    var cardsSize = CGSize()
    
    var distanceX = CGFloat()
    
    var distanceY = CGFloat()
    
    
    
    func configureLayParameters(frame: CGRect) {
        
        let width = frame.width * percentOfGlobalWidth
        
        let height = frame.height - 2*upDownBorders
        
        distanceX = width * distancePercent
        
        cardsSize.width = (width - 7*distanceX) / (5 + rightField)
        
        cardsSize.height = (height - 2*distanceX) / (4 + betweenField)
        
        distanceY = cardsSize.height * betweenField
        
        firstPoint.y = frame.height - upDownBorders - cardsSize.height
        
        firstPoint.x = width
    }
    
    
    
    func getLayParameters() -> (CGPoint,CGSize,CGFloat,CGFloat) {
        
        return (firstPoint, cardsSize, distanceX, distanceY)
    }
    
    
}
