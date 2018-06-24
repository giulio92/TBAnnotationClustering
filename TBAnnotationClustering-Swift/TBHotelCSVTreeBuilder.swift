//
//  TBCoordinateQuadTreeBuilder.swift
//  TBAnnotationClustering-Swift
//
//  Created by Eyal Darshan on 1/1/16.
//  Copyright © 2016 eyaldar. All rights reserved.
//

import Foundation

class TBHotelCSVTreeBuilder {
    
    func buildTree(dataFileName:String, worldBounds:TBBoundingBox) -> TBQuadTreeNode {
        let data = getFileContent(fileName: dataFileName)
        let lines = data.components(separatedBy: "\n") 
        
        var dataArray = [TBQuadTreeNodeData]()
        
        for line in lines {
            if line != "" {
                dataArray.append(dataFromLine(line: line as NSString))
            }
        }
        
        return TBQuadTreeNode(boundary: worldBounds, capacity: 4, dataArr: dataArray)
    }
    
    private func dataFromLine(line: NSString) -> TBQuadTreeNodeData {
        let components = line.components(separatedBy: ",")
        
        let latitude = Double(components[1].trimmingCharacters(in: CharacterSet.whitespacesAndNewlines))
        let longitude = Double(components[0].trimmingCharacters(in: CharacterSet.whitespacesAndNewlines))
        
        let hotelName = components[2].trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        let hotelPhoneNumber = components.last!.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        let hotelInfo = TBHotelInfo(hotelName: hotelName, hotelPhoneNumber: hotelPhoneNumber)
        
        return TBQuadTreeNodeData(x: latitude!, y: longitude!, data: hotelInfo)
    }
    
    private func getFileContent(fileName:String) -> String {
        let bundle = Bundle.main
        let path = bundle.path(forResource: fileName, ofType: "csv")!
        var data = ""
        
        do {
            data = try String(contentsOfFile: path, encoding: String.Encoding.utf8)
        } catch {}
        
        return data
    }
}
