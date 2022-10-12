import OpusSwift

public enum BLOpusError: Error {
    case failedToEncode
    case failedToDecode
}

public typealias OpusData = Data

public struct BLOpus {
    
    /// Convers pcm to opus
    public static func encode(pcmData: Data, sampleRate: Int32, frameSize: Int32) throws -> OpusData {
//        let opusHelper = OpusHelper()
//        opusHelper.createEncoder(sampleRate)
//        return opusHelper.encode(pcmData, frameSize: frameSize)
        Data()
    }
    
    /// converts opus to pcm
    public static func decode(opusData: OpusData, sampleRate: Int) throws -> Data {
//        let opusHelper = OpusHelper()
//        let pcmData = opusHelper.opus(toPCM: opusData, sampleRate: sampleRate)
//        guard let decodedData = opusHelper.addWavHeader(pcmData) as Data? else {
//            throw BLOpusError.failedToEncode
//        }
//        return decodedData
        Data()
    }
}
