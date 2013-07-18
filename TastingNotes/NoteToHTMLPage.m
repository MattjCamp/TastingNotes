//
//  NoteToHTMLPage.m
//  TastingNotes
//
//  Created by Matthew Campbell on 10/4/12.
//
//

#import "NoteToHTMLPage.h"

@implementation NoteToHTMLPage

+(NSString *)startPage{
    return [NSString stringWithFormat:@"<html><head><link rel=\"stylesheet\" type=\"text/css\" href=\"%@\"></head><body>", [[AppContent sharedContent] cssFileCache]];
}

+(NSString *)htmlForThisSection:(Section *)section{
    NSMutableString *noteString = [[NSMutableString alloc] init];
    [noteString appendString:@"<p id=\"sectiontitle\">"];
    [noteString appendString:section.name];
    [noteString appendString:@"</p>"];
    
    return noteString;
}

+(NSString *)htmlForThisContent:(Content *)content{
    NSMutableString *noteString = [[NSMutableString alloc] init];
    if([content.control.type isEqualToString:@"Picture"]){
        if(content.note.thumbnailCacheFilename){
            //[noteString appendString:@"<div id=\"controltitle\">"];
            //[noteString appendString:content.control.title];
            //[noteString appendString:@"</div>"];
            //[noteString appendString:@"<br/>"];
            [noteString appendString:@"<div id=\"padder\">"];
            [noteString appendString:@"<img src=\""];
            [noteString appendString:content.note.thumbnailCacheFilename];
            [noteString appendString:@"\"></div>"];
        }
    }
    else{
        if(content.toString){
            [noteString appendString:@"<div id=\"controltitle\">"];
            [noteString appendString:content.control.title];
            [noteString appendString:@"</div>"];
            [noteString appendString:@"<br/>"];
            [noteString appendString:content.toString];
            [noteString appendString:@"<br/>"];
        }
    }
    return noteString;
}

+(NSString *)endPage{
    return @"</body></html>";
}

@end