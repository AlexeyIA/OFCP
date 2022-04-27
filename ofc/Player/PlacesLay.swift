//
//  PlayerLayData.swift
//  ofc
//
//  Created by Alexey A on 14/09/2018.
//  Copyright © 2018 Alexey A. All rights reserved.
//

import Foundation

import UIKit



class PlacesLay {
    
    let upDownBorders : CGFloat = 10.0
    
    let percentOfGlobalWidth : CGFloat = 0.5
    
    let distancePercent : CGFloat = 0.01 // 1 unit of distance = 1% of width
    
    let rightField : CGFloat = 2 // 2 cards
    
    let betweenField : CGFloat = 0.5 // distance between Lines block and current hand = 0.5 card
    
    
    
    var player = [UILabel]()
    
    var cpu = [UILabel]()
    
    var shift = CGFloat()
    
    var distanceX = CGFloat() // for start button
    
    
    
    func configureLayParameters(frame: CGRect) {
        
        let width = frame.width * percentOfGlobalWidth
        
        let height = frame.height - 2*upDownBorders
        
        var firstPoint = CGPoint()
        
        var cardsSize = CGSize()
        
        var distanceY = CGFloat()
        
        distanceX = width * distancePercent
        
        cardsSize.width = (width - 7*distanceX) / (5 + rightField)
        
        cardsSize.height = (height - 2*distanceX) / (4 + betweenField)
        
        distanceY = cardsSize.height * betweenField
        
        firstPoint.y = frame.height - upDownBorders - cardsSize.height
        
        firstPoint.x = width
        
        shift = width - upDownBorders - cardsSize.width
        
        setInfo(parameters: (firstPoint, cardsSize, distanceX, distanceY))
    }
    
    
    
    func setInfo(parameters: (CGPoint, CGSize, CGFloat, CGFloat)) {
        
        var point = parameters.0
        
        for i in 0...17 {
            
            var card = UILabel()
            
            card.frame = CGRect(origin: point, size: parameters.1)
            
            card = style(toCard: card)
            
            player.append(card)
            
            point.x = point.x + parameters.1.width + parameters.2
            
            if (i+1)%5 == 0 {
                
                point.x = parameters.0.x
                
                if (i+1)/5 == 1 {
                    
                    point.y = point.y - parameters.3 - parameters.1.height
                    
                } else {
                    
                    point.y = point.y - parameters.2 - parameters.1.height
                }
            }
        }
        
        for i in player {
            
            var card = UILabel()
            
            card.frame = i.frame
            
            card.frame.origin.x -= shift
            
            card = style(toCard: card)
            
            cpu.append(card)
        }
        
        for _ in 0...4 {
            
            cpu.remove(at: 0)
        }
    }
    
    
    
    func style (toCard: UILabel) -> UILabel {
        
        toCard.layer.borderWidth = 1
        
        toCard.layer.cornerRadius = 3
        
        toCard.layer.masksToBounds = true
        
        toCard.layer.borderColor = UIColor.lightGray.cgColor
        
        return toCard
    }
    
    
    
}
