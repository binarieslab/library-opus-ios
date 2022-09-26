//
//  TestUtils.swift
//  OpusSwiftTests
//
//  Created by Marcelo Sarquis on 24.09.22.
//

import Foundation

class TestUtils: NSObject {
    
    static let bundle = Bundle(for: TestUtils.self)
    
    static func contentsOfFile(name: String) -> Data {
        guard
            let url = bundle.url(forResource: name, withExtension: nil),
            let data = try? Data(contentsOf: url)
        else {
            fatalError("No file found")
        }
        return data
    }
}
