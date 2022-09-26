//
//  OpusSwiftTests.swift
//  OpusSwiftTests
//
//  Created by Marcelo Sarquis on 22.09.22.
//

import XCTest
@testable import OpusSwift

class OpusSwiftTests: XCTestCase {

    private var pcmData: Data {
        TestUtils.contentsOfFile(name: "audiosample.mp3")
    }
    
    private var opusHelper: OpusHelper!
    private var oggHelper: OggHelper!
    override func setUpWithError() throws {
        try super.setUpWithError()
        
        opusHelper = OpusHelper()
        oggHelper = OggHelper()
    }

    override func tearDownWithError() throws {
        opusHelper = nil
        oggHelper = nil
        
        try super.tearDownWithError()
    }

    func testExample() throws {
        let sampleRate: Int32 = 48000
        let frameSize: Int32 = Int32(960 / (48000 / sampleRate))
        
        // 1. Convert pcm to opus
        let encodedCreated = opusHelper.createEncoder(sampleRate)
        let pcmWithHeaderData = opusHelper.addWavHeader(pcmData)
        let opusData = opusHelper.encode(pcmWithHeaderData! as Data, frameSize: frameSize)
        
        guard
            let oggOpusData = oggHelper.writePacket(opusData, frameSize: frameSize),
            let oggOpusHeader = oggHelper.getOggOpusHeader(sampleRate)
        else {
            XCTFail("oggOpusData should not be nil")
            return
        }
        let mutableData = NSMutableData()
        mutableData.append(oggOpusHeader)
        mutableData.append(oggOpusData as Data)
        
        // 2. Convert opus to pcm
        let pcmTempData = opusHelper.opus(toPCM: mutableData as Data, sampleRate: Int(sampleRate))
        let decodedData = opusHelper.addWavHeader(pcmTempData) as Data?
        
        XCTAssertTrue(encodedCreated)
        XCTAssertEqual(pcmData, decodedData)
    }
}
