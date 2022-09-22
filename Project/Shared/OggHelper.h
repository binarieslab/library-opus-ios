#import <Foundation/Foundation.h>

@interface OggHelper : NSObject

- (OggHelper *)init;
- (NSData *)getOggOpusHeader: (int) sampleRate;
- (NSMutableData *)writePacket:(NSData*)data frameSize:(int)frameSize;

@end
