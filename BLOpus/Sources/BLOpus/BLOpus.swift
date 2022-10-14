import OpusSwift

public enum BLOpusError: Error {
    case failedToEncode
    case failedToDecode
}

public typealias OpusData = Data

public struct BLOpus {
    
    /// Convers pcm to opus
    public static func encode(pcmData: Data, sampleRate: Int32, frameSize: UInt32) throws -> OpusData {
        let speechToTextEncoder = try SpeechToTextEncoder(
            pcmRate: sampleRate,
            pcmChannels: 1,
            pcmBytesPerFrame: frameSize,
            opusRate: sampleRate,
            application: .audio
        )
        
        try speechToTextEncoder.encode(pcm: pcmData)
        
        let opusData = try speechToTextEncoder.endstream()
        return opusData
    }
    
    /// converts opus to pcm
    public static func decode(opusData: OpusData, sampleRate: Int32) throws -> Data {
        let decoder = try TextToSpeechDecoder(audioData: opusData)
        let pcmDecodedData = decoder.pcmDataWithHeaders
        return pcmDecodedData
    }
}
