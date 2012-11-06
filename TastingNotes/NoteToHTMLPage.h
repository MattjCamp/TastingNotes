//
//  NoteToHTMLPage.h
//  TastingNotes
//
//  Created by Matthew Campbell on 10/4/12.
//
//

#import <Foundation/Foundation.h>
#import "AppContent.h"

@interface NoteToHTMLPage : NSObject

+(NSString *)startPage;
+(NSString *)htmlForThisSection:(Section *)section;
+(NSString *)htmlForThisContent:(Content *)content;
+(NSString *)endPage;

@end
