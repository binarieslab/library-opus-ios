import XCTest
@testable import BLOpus

final class BLOpusTests: XCTestCase {
    
    func testEncodeDecode_whenRateIsGiven_shouldReturnOriginalData() throws {
        // Given
        let pcmData = TestUtils.contentsOfFile(name: "audiosample.mp3")
        let sampleRate: Int32 = 48000
        let frameSize: UInt32 = pcmData.count.calculateFrameSize(forFrame: 960)
        
        // When
        let opusData = try BLOpus.encode(
            pcmData: pcmData,
            pcmRate: sampleRate,
            pcmChannels: 1,
            frameSize: frameSize,
            opusRate: sampleRate,
            application: .audio
        )
        let pcmDecodedData = try BLOpus.decode(
            opusData: opusData,
            numChannels: 1,
            sampleRate: sampleRate
        )
        
        print("originalPcmData.count: \(pcmData.count) vs opus.count: \(opusData.count)")
        print("pcmDecodedData.count: \(pcmDecodedData.count)")
        
        // Expected
        XCTAssertTrue(opusData.count > 0)
        XCTAssertTrue(pcmDecodedData.count > 0)
    }
}

private extension Int {
    func calculateFrameSize(forFrame: UInt32) -> UInt32 {
        var upperPcmBytesPerFrame = forFrame
        while true {
            if UInt32(self) % upperPcmBytesPerFrame == 0 {
                return upperPcmBytesPerFrame
            }
            if upperPcmBytesPerFrame < UInt32(self) {
                break
            }
            upperPcmBytesPerFrame += 1
        }
        
        var downerPcmBytesPerFrame = forFrame
        while true {
            if UInt32(self) % downerPcmBytesPerFrame == 0 {
                return downerPcmBytesPerFrame
            }
            downerPcmBytesPerFrame -= 1
        }
    }
}
