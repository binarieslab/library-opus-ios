//
//  OpusSwiftTests.swift
//  OpusSwiftTests
//
//  Created by Marcelo Sarquis on 27.10.22.
//

@testable import OpusSwift
import XCTest

final class OpusSwiftTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testEncoder_whenValidAudioIsGiven_shouldEncodeNewFormat() throws {
        // Given
        let pcmData = TestUtils.pcmfile.data
        let pcmRate: Int32 = 48000
        let pcmChannels: Int32 = 1
        let frameSize: UInt32 = pcmData.count.calculateFrameSize(forOriginalFrame: 960)
        let opusRate: Int32 = 48000
        
        // When
        let encoder = try OpusEncoder(pcmRate: pcmRate, pcmChannels: pcmChannels, pcmBytesPerFrame: frameSize, opusRate: opusRate, application: .audio)
        let encodedData = try encoder.encode(pcm: pcmData) // TODO !!!
        
        // Expected
        let encodedURL = TestUtils.pcmfile.url
            .deletingLastPathComponent()
            .appendingPathComponent("encodedfile.ogg")
        try encodedData.write(to: encodedURL)
        
        XCTAssertTrue(encodedData.count > 0)
    }
    
    func testEncoder_whenWrongAudioIsGiven_shouldThrowError() throws {
    }
    
    func testDecoder_whenValidAudioIsGiven_shouldEncodeNewFormat() throws {
        // Given
        let audioData = TestUtils.opusfile.data
        let numChannels: Int32 = 1
        let sampleRate: Int32 = 48000
        
        // When
        let decoder = try OpusDecoder(numChannels: numChannels, sampleRate: sampleRate)
        let decodedData = try decoder.decode(audioData: audioData)
        
        // Expected
        XCTAssertEqual(decodedData.count, 283892)
    }
    
    func testDecoder_whenWrongAudioIsGiven_shouldThrowError() throws {
    }
}

private extension Int {
    func calculateFrameSize(forOriginalFrame frame: UInt32) -> UInt32 {
        var upperPcmBytesPerFrame = frame
        while true {
            if UInt32(self) % upperPcmBytesPerFrame == 0 {
                return upperPcmBytesPerFrame
            }
            if upperPcmBytesPerFrame < UInt32(self) {
                break
            }
            upperPcmBytesPerFrame += 1
        }
        
        var downerPcmBytesPerFrame = frame
        while true {
            if UInt32(self) % downerPcmBytesPerFrame == 0 {
                return downerPcmBytesPerFrame
            }
            downerPcmBytesPerFrame -= 1
        }
    }
}
