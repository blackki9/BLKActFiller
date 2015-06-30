//
//  ViewController.swift
//  BLKActFiller
//
//  Created by black9 on 20/06/15.
//  Copyright © 2015 black9. All rights reserved.
//

import Cocoa
import AppKit

class ViewController: NSViewController {

    @IBOutlet var imageView: NSImageView!
    @IBOutlet var dateTextfield: NSTextField!
    @IBOutlet var hoursTextField: NSTextField!
    @IBOutlet var rateTextfield: NSTextField!
    @IBOutlet var sumTextField: NSTextField!
    @IBOutlet var sumRusField: NSTextField!
    @IBOutlet var actNumberField: NSTextField!
    
    private var originalImage:NSImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.originalImage = self.imageView.image;
        
        // Do any additional setup after loading the view.
    }

    override var representedObject: AnyObject? {
        didSet {
        // Update the view, if already loaded.
        }
    }

    @IBAction func fillCertificate(sender: NSButton) {
        let drawer = BLKTextDrawer()

        drawer.setPathToSaveFolder("/Users/black9/")
        drawer.setImageName("act_"+self.dateTextfield.stringValue + ".png");
        let resultImage = drawer.drawLabels(self.allLabelsForDraw(),onImage:self.originalImage)
        self.imageView.image = resultImage;
        
    }
    
    func allLabelsForDraw() -> Array<BLKTextOnImageLabel>?
    {
        let headerFont = NSFont(name: "Times New Roman", size: 18)
        
        let dateLabel = BLKTextOnImageLabel(text: self.dateTextfield.stringValue, position: NSPoint(x: 485, y: 1227),font:headerFont)
        let actNumberLabel = BLKTextOnImageLabel(text: self.actNumberField.stringValue, position: NSPoint(x:470,y:1255),font:headerFont)
        
        let tableFont = NSFont(name:"Times New Roman",size : 16)
        
        let hoursAmountLabel = BLKTextOnImageLabel(text:self.hoursTextField.stringValue,position: NSPoint(x:580,y: 1025), font:tableFont)
        let rateLabel = BLKTextOnImageLabel(text: self.rateTextfield.stringValue, position: NSPoint(x:700,y:1025), font: tableFont)
        
        let sum = self.hoursTextField.doubleValue * self.rateTextfield.doubleValue
        var sumString:String = String(format:"%.2f", sum)

        let sumLabel = BLKTextOnImageLabel(text: String(sumString), position: NSPoint(x:780,y:1025), font: tableFont)
        
        let sumInEnglishLabel = BLKTextOnImageLabel(text: self.sumTextField.stringValue, position: NSPoint(x:120,y:870), font: tableFont)
        let sumInRussianLabel = BLKTextOnImageLabel(text: self.sumRusField.stringValue,position:NSPoint(x:120,y:845), font:tableFont)
        
        return [dateLabel,actNumberLabel,hoursAmountLabel,rateLabel,sumLabel,sumInEnglishLabel,sumInRussianLabel];
    }
}

