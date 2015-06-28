//
//  BLKTextDrawer.swift
//  BLKActFiller
//
//  Created by black9 on 27/06/15.
//  Copyright (c) 2015 black9. All rights reserved.
//

import AppKit
import CoreText

public struct BLKTextOnImageLabel
{
    let text:String?
    let position:NSPoint
    let font:NSFont?
    
    init(text:String?,position:NSPoint,font:NSFont?) {
        self.text = text
        self.position = position
        self.font = font
    }
}

public class BLKTextDrawer: NSObject {
   
    private var pathToSaveFolder:String? = ""
    private var savedImageName:String? = "image.png"
    
    public func setPathToSaveFolder(path:String?) {
        self.pathToSaveFolder = path
    }
    public func setImageName(imageName:String?) {
        self.savedImageName = imageName
    }
    
    override init() {
        
    }
    
    public func drawLabels(labels:Array<BLKTextOnImageLabel>?,onImage:NSImage?) -> NSImage?
    {
        if let image = onImage, let allLabels = labels {
            let contextWithRep = self.drawingContextFromImage(onImage)
            if let drawingContext = contextWithRep.context {
                for label in allLabels {
                    self.drawStringInContext(drawingContext,text: label.text,position: label.position,font:label.font)
                }
            }
            return self.saveImageRepresentation(contextWithRep.imageRep,size:image.size)
        }
        return nil
    }
    func drawingContextFromImage(image:(NSImage?)) -> (context:CGContext?,imageRep:NSBitmapImageRep?)
    {
        if let existedImage = image {
            let imageData:NSData? = existedImage.TIFFRepresentation
            let imageRep = NSBitmapImageRep(data: imageData!)

            let drawingContext:CGContext? = NSGraphicsContext(bitmapImageRep: imageRep!)!.CGContext
            
            return (context:drawingContext,imageRep:imageRep)
        }
       
        return (nil,nil)
    }
    func drawStringInContext(context:CGContext,text:String?,position:CGPoint,font:NSFont?)
    {
        let attr:CFDictionaryRef = [NSFontAttributeName:font!]
        let text = CFAttributedStringCreate(nil, text!, attr)
        let line = CTLineCreateWithAttributedString(text)
        let bounds = CTLineGetBoundsWithOptions(line, CTLineBoundsOptions.UseGlyphPathBounds)
 
        CGContextSetLineWidth(context, 1.5)
        CGContextSetTextDrawingMode(context, kCGTextStroke)
        CGContextSetTextPosition(context, position.x, position.y)
 
        CTLineDraw(line, context)
    }
    func saveImageRepresentation(imageRep:NSBitmapImageRep?,size:CGSize) -> NSImage?
    {
        if let imageRepresentation = imageRep, let imageName = self.savedImageName {
            let newImage = NSImage(size:size)
            newImage.addRepresentation(imageRepresentation)
            newImage.TIFFRepresentation!.writeToFile(self.pathToSaveFolder!.stringByAppendingPathComponent(imageName), atomically: true)
            return newImage;
        }
        
        return nil;
    }
    
}
