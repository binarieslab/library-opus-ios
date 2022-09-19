#import <Foundation/Foundation.h>

@interface OggHelper : NSObject

- (OggHelper *)init;
- (NSData *)getOggOpusHeader: (int) sampleRate;
- (NSMutableData *)writePacket:(NSData*)data frameSize:(int)frameSize;

@end

// warning build: Building for iOS Simulator, but linking in object file (/Users/marcelosarquis/Library/Developer/Xcode/DerivedData/BLOpus-fmmioyodpixmnjgipiwmaggeqlrm/Build/Intermediates.noindex/BLOpus.build/Debug-iphonesimulator/lib-opus-ios.build/Objects-normal/arm64/lib_opus_ios_lto.o) built for iOS
