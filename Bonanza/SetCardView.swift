//
//  SetCardView.swift
//  Bonanza
//
//  Created by SATINDAR S DHILLON on 6/4/14.
//  Copyright (c) 2014 Satindar Dhillon. All rights reserved.
//

import Foundation
import UIKit

//@IBDesignable // not sure if needed

class SetCardView : UIView {
    
    let symbol: Int, shading: Int, color: Int, symbolCount: Int
    let cornerRadius: Float = 12.0
    var isChosen: Bool, isMatched: Bool
    // add observers for isChosen and isMatched
    // update views appropriately when they change
    
    override func drawRect(rect: CGRect) {
        let roundedRect = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius)
        roundedRect.addClip()
        
        if (isMatched) {
            UIColor.yellowColor().setFill()
        } else if (isChosen) {
            UIColor.lightGrayColor().setFill()
        } else {
            UIColor.whiteColor()
        }
        
        UIRectFill(bounds)
        
        UIColor.blackColor().setStroke()
        roundedRect.stroke()
        
        drawSymbolsWithAttributes()
    }
    
    func drawSymbolsWithAttributes() -> () {
        var cardImage: UIImage
        switch symbol {
            case 1:
                cardImage = triangleImage()
            case 2:
                cardImage = circleImage()
            case 3:
                cardImage = squareImage()
            default:
                cardImage = squareImage()
        }
        
        let scaleFactor: Float = max(cardImage.size.width / bounds.size.width,
                                cardImage.size.height / bounds.size.height)
        
        let newWidth: Float = cardImage.size.width / scaleFactor;
        let newHeight: Float = cardImage.size.height / scaleFactor;
        
        let leftOffset: Float = (bounds.size.width - newWidth) / 2;
        let topOffset: Float = (bounds.size.height - newHeight) / 2;

        let imageRect: CGRect = CGRectMake(leftOffset, topOffset, newWidth, newHeight)
        
        cardImage.drawInRect(imageRect)
    }
    
    func triangleImage() -> UIImage {
        let triangleWidth = 150
        let spacing = 25
        let xOffset = 10
        let imageHeight = 200
        let width = triangleWidth * symbolCount + spacing * (symbolCount - 1) + (xOffset * 2)
        
        
        UIGraphicsBeginImageContext(CGSizeMake(CGFloat(width), CGFloat(imageHeight)))
        
        
        var xPosition = xOffset
        for index in 0..symbolCount {
            var trianglePath: UIBezierPath = UIBezierPath()
            trianglePath.moveToPoint(CGPointMake(CGFloat(xPosition), CGFloat(150)))
            trianglePath.moveToPoint(CGPointMake(CGFloat(xPosition + triangleWidth), CGFloat(150)))
            trianglePath.addLineToPoint(CGPointMake(CGFloat(xPosition + triangleWidth / 2), CGFloat(10)))
            trianglePath.closePath()
   
            xPosition += triangleWidth + spacing
            
//            [self strokeAndFillShape:trianglePath];
        }
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext();
        return image;
    }
    
    func circleImage() -> UIImage {
        let circleRadius = 150
        let spacing = 25
        let imageHeight = 200
        let yOffset = imageHeight - circleRadius
        var xOffset = 10
        let width = circleRadius * symbolCount + spacing * (symbolCount - 1) + (xOffset * 2)
        
        UIGraphicsBeginImageContext(CGSizeMake(CGFloat(width), CGFloat(imageHeight)))
        
        for index in 0..symbolCount {
            let imageRect: CGRect = CGRectMake(CGFloat(xOffset), CGFloat(yOffset), CGFloat(circleRadius), CGFloat(circleRadius))
            let circlePath = UIBezierPath(ovalInRect: imageRect)
            xOffset += circleRadius + spacing
            
            //    [self strokeAndFillShape:circlepath];
        }
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext();
        return image;
    }
    
    func squareImage() -> UIImage {
        let edgeLength = 100
        let spacing = 25
        let imageHeight = 200
        let yOffset = (imageHeight - edgeLength) / 2
        var xOffset = 25
        let width = edgeLength * symbolCount + spacing * (symbolCount - 1) + (xOffset * 2)
        
        UIGraphicsBeginImageContext(CGSizeMake(CGFloat(width), CGFloat(imageHeight)))
        
        for index in 0..symbolCount {
            let imageRect: CGRect = CGRectMake(CGFloat(xOffset), CGFloat(yOffset), CGFloat(edgeLength), CGFloat(edgeLength))
            let circlePath = UIBezierPath(ovalInRect: imageRect)
            xOffset += edgeLength + spacing
            
            //    [self strokeAndFillShape:squarepath];
        }
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext();
        return image;
    }
    
    
    init(symbol: Int, shading: Int, color: Int, symbolCount: Int, inFrame frame: CGRect) {
        self.symbol = symbol
        self.shading = shading
        self.color = color
        self.symbolCount = symbolCount
        self.isChosen = false
        self.isMatched = false
        super.init(frame: frame)
        setup()
    }
    
    override func awakeFromNib() {
        setup()
    }
    
    func setup() -> () {
        self.backgroundColor = nil
        self.opaque = false
        self.contentMode = UIViewContentMode.Redraw
    }
   
}