//
//  DribbbleImportTests.swift
//  JSON
//
//  Created by muukii on 9/18/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import XCTest
import Foundation

@testable import JAYSON

class DribbbleImportTests: XCTestCase {
    
    let data = Data(referencing: NSData(contentsOfFile: Bundle(for: Tests.self).path(forResource: "Sample", ofType: "json")!)!)
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testImport() {
        
        do {
            let json = try JSON(data: data)

            let shots: [Shot] = try json.getArray().map { json -> Shot in
                
                let imagesJayson = try json.next("images")
                
                //        print(try json.next("images", "normal").currentPath())
                
                return Shot(
                    id: try json.next("id").getInt(),
                    title: try json.next("title").getString(),
                    width: try json.next("width").getInt(),
                    height: try json.next("height").getInt(),
                    hidpiImageURLString: try? imagesJayson.next("hidpi").getString(),
                    normalImageURLString: try imagesJayson.next("normal").getString(),
                    teaserImageURLString: try imagesJayson.next("teaser").getString()
                )
            }
            
            print(shots)
            
        } catch {
            XCTFail("\(error)")
        }
    }
 
    struct Shot {
        let id: Int
        let title: String
        let width: Int
        let height: Int
        let hidpiImageURLString: String?
        let normalImageURLString: String
        let teaserImageURLString: String
    }

}
