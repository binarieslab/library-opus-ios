//
//  TestUtils.swift
//  
//
//  Created by Marcelo Sarquis on 24.09.22.
//

import Foundation

class TestUtils: NSObject {
    
    static let bundle = Bundle.module
    
    static func contentsOfFile(name: String) -> Data {
        let pubPath  = bundle.path(forResource: name, ofType: nil)!
        return (try! Data(contentsOf: URL(fileURLWithPath: pubPath)))
    }
}
