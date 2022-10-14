import OpusSwift

public enum BLOpusError: Error {
    case failedToEncode
    case failedToDecode
}

public typealias OpusData = Data

public struct BLOpus {
    
    /// Convers pcm to opus
    public static func encode(pcmData: Data, pcmRate: Int32, pcmChannels: Int32, frameSize: UInt32, opusRate: Int32, application: BLOpusApplication) throws -> OpusData {
        let encoder: OpusEncoder
        do {
            encoder = try OpusEncoder(
                pcmRate: pcmRate,
                pcmChannels: pcmChannels,
                pcmBytesPerFrame: frameSize,
                opusRate: opusRate,
                application: application.asOpusApplication
            )
            
        } catch let error as OpusError {
            throw error.asBLOpusError
            
        } catch let error as OggError {
            throw error.asBLOpusError
        }
        
        do {
            let encodedData = try encoder.encode(
                pcm: pcmData
            )
            return encodedData
            
        } catch let error as OpusError {
            throw error.asBLOpusError
            
        } catch let error as OggError {
            throw error.asBLOpusError
        }
    }
    
    /// converts opus to pcm
    public static func decode(opusData: OpusData, numChannels: Int32, sampleRate: Int32) throws -> Data {
        let decoder: OpusDecoder
        do {
            decoder = try OpusDecoder(
                numChannels: numChannels,
                sampleRate: sampleRate
            )
        } catch let error as OpusError {
            throw error.asBLOpusError
            
        } catch let error as OggError {
            throw error.asBLOpusError
        }
        
        do {
            let decodedData = try decoder.decode(
                audioData: opusData
            )
            return decodedData
            
        } catch let error as OpusError {
            throw error.asBLOpusError
            
        } catch let error as OggError {
            throw error.asBLOpusError
        }
    }
}

private extension BLOpusApplication {
    var asOpusApplication: OpusApplication {
        switch self {
        case .voip:
            return .voip
        case .audio:
            return .audio
        case .lowDelay:
            return .lowDelay
        }
    }
}

private extension OpusError {
    var asBLOpusError: BLOpusError {
        switch self {
        case .okay:
            return .failedToEncode
        case .badArgument:
            return .failedToEncode
        case .bufferTooSmall:
            return .failedToEncode
        case .internalError:
            return .failedToEncode
        case .invalidPacket:
            return .failedToEncode
        case .unimplemented:
            return .failedToEncode
        case .invalidState:
            return .failedToEncode
        case .allocationFailure:
            return .failedToEncode
        @unknown default:
            return .failedToEncode
        }
    }
}

private extension OggError {
    var asBLOpusError: BLOpusError {
        switch self {
        case .outOfSync:
            return .failedToEncode
        case .internalError:
            return .failedToEncode
        @unknown default:
            return .failedToEncode
        }
    }
}
