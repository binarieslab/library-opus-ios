#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

@interface OpusHelper : NSObject

@property (nonatomic,strong) dispatch_queue_t processingQueue;
@property (nonatomic) NSUInteger bitrate;

- (BOOL)createEncoder:(int)sampleRate;
- (NSData*)encode:(NSData *)pcmData frameSize:(int)frameSize;
- (NSData*)opusToPCM:(NSData *)oggOpus sampleRate:(long)sampleRate;

- (NSMutableData *)addWavHeader:(NSData *)wavNoheader;

@end
