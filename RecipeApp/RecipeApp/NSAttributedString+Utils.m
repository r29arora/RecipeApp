/***********************************************************************************
 * This software is under the MIT License quoted below:
 ***********************************************************************************
 *
 * Copyright (c) 2010 Olivier Halligon
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 *
 ***********************************************************************************/

#import "NSAttributedString+Utils.h"

@implementation NSMutableAttributedString (Utils)

- (void)setFont:(UIFont *)font
{
    [self setFont:font range:NSMakeRange(0, [self length])];
}

- (void)setFont:(UIFont *)font range:(NSRange)range
{
    CTFontRef fontRef = CTFontCreateWithName((__bridge CFStringRef)font.fontName, font.pointSize, NULL);
    if (fontRef)
    {
        [self removeAttribute:(__bridge NSString *)kCTFontAttributeName range:range];
        [self addAttribute:(__bridge NSString *)kCTFontAttributeName value:(__bridge id)fontRef range:range];
        CFRelease(fontRef);
    }
}

- (void)setTextColor:(UIColor *)color
{
    [self setTextColor:color range:NSMakeRange(0, [self length])];
}

- (void)setTextColor:(UIColor *)color range:(NSRange)range
{
    [self removeAttribute:(__bridge NSString *)kCTForegroundColorAttributeName range:range];
    [self addAttribute:(__bridge NSString *)kCTForegroundColorAttributeName value:(__bridge id)color.CGColor range:range];
}

- (void)setLink:(NSURL *)link
{
    [self setLink:link range:NSMakeRange(0, [self length])];
}

- (void)setLink:(NSURL *)link range:(NSRange)range
{
    [self removeAttribute:NSLinkAttributeName range:range];
    [self addAttribute:NSLinkAttributeName value:(id)link range:range];
}

- (void)setUnderline:(BOOL)isUnderlined range:(NSRange)range
{
    int32_t style = isUnderlined ? (kCTUnderlineStyleSingle|kCTUnderlinePatternSolid) : kCTUnderlineStyleNone;
    [self removeAttribute:(__bridge NSString *)kCTUnderlineStyleAttributeName range:range];
    [self addAttribute:(__bridge NSString *)kCTUnderlineStyleAttributeName value:[NSNumber numberWithInt:style] range:range];
}

- (void)setTextBold:(BOOL)isBold
{
    [self setTextBold:isBold range:NSMakeRange(0, [self length])];
}

- (void)setTextBold:(BOOL)isBold range:(NSRange)range
{
    [self changeFontWithTraits:(isBold?kCTFontTraitBold:0)
                          mask:kCTFontTraitBold
                         range:range newFontFinder:^NSString *(NSString *currentFontName)
     {
         if ([currentFontName isEqualToString:kHelveticaNeueUI_Italic] || [currentFontName isEqualToString:kHelveticaNeueUI_Bold_Italic])
         {
             // Italic private font
             return isBold ? kHelveticaNeueUI_Bold_Italic : kHelveticaNeueUI_Italic;
         } else if ([currentFontName isEqualToString:kHelveticaNeueUI] || [currentFontName isEqualToString:kHelveticaNeueUI_Bold]) {
             // Non-Italic private font
             return isBold ? kHelveticaNeueUI_Bold : kHelveticaNeueUI;
         } else {
             return nil;
         }
     }];
}

- (void)setTextItalics:(BOOL)isItalics
{
    [self setTextItalics:isItalics range:NSMakeRange(0, [self length])];
}

- (void)setTextItalics:(BOOL)isItalics range:(NSRange)range
{
    [self changeFontWithTraits:(isItalics?kCTFontTraitItalic:0)
                          mask:kCTFontTraitItalic
                         range:range
                 newFontFinder:^NSString *(NSString *currentFontName)
     {
         if ([currentFontName isEqualToString:kHelveticaNeueUI_Bold] || [currentFontName isEqualToString:kHelveticaNeueUI_Bold_Italic])
         {
             // Bold private font
             return isItalics ? kHelveticaNeueUI_Bold_Italic : kHelveticaNeueUI_Bold;
         } else if ([currentFontName isEqualToString:kHelveticaNeueUI] || [currentFontName isEqualToString:kHelveticaNeueUI_Italic]) {
             // Non-Bold private font
             return isItalics ? kHelveticaNeueUI_Italic : kHelveticaNeueUI;
         } else {
             return nil;
         }
     }];
}

#pragma private methods

-(void)changeFontWithTraits:(CTFontSymbolicTraits)traits
                       mask:(CTFontSymbolicTraits)traitsMask
                      range:(NSRange)range
              newFontFinder:( NSString*(^)(NSString* currentFontPostscriptName) )fontFinderBlock
{
    NSUInteger startPoint = range.location;
    NSRange effectiveRange;
    [self beginEditing];
    do {
        // Get font at startPoint
        CTFontRef currentFont = (__bridge CTFontRef)[self attribute:(__bridge NSString*)kCTFontAttributeName atIndex:startPoint effectiveRange:&effectiveRange];
        if (!currentFont)
        {
            currentFont = CTFontCreateUIFontForLanguage(kCTFontLabelFontType, 0.0, NULL);
        }
        // The range for which this font is effective
        NSRange fontRange = NSIntersectionRange(range, effectiveRange);
        // Create the font variant for this font according to new traits
        CTFontRef newFont = CTFontCreateCopyWithSymbolicTraits(currentFont, 0.0, NULL, traits, traitsMask);
        if (!newFont)
        {
            CFStringRef fontNameRef = CTFontCopyPostScriptName(currentFont);
            // Give a chance to try a hack for the private ".HelveticaNeueUI" font family, which is the default
            // font for labels in XIB, but fail to detect its italic variant correctly prior to iOS 6.1
            if (fontFinderBlock)
            {
                NSString* newFontName = fontFinderBlock((__bridge NSString*)fontNameRef);
                if (newFontName)
                {
                    CTFontDescriptorRef fontDesc = CTFontCopyFontDescriptor(currentFont);
                    NSDictionary* nameAttr = [NSDictionary dictionaryWithObject:newFontName forKey:@"NSFontNameAttribute"];
                    CTFontDescriptorRef newFontDesc = CTFontDescriptorCreateCopyWithAttributes(fontDesc, (__bridge CFDictionaryRef)nameAttr);
                    newFont = CTFontCreateWithFontDescriptor(newFontDesc, CTFontGetSize(currentFont), NULL);
                    CFRelease(fontDesc);
                    CFRelease(newFontDesc);
                }
            }
            // If still no luck, display a warning message in console
            if (!newFont)
            {
                NSLog(@"[OHAttributedLabel] Warning: can't find an italic font variant for font family %@. "
                      @"Try another font family (like Helvetica) instead.", (__bridge NSString*)fontNameRef);
            }
            if (fontNameRef) CFRelease(fontNameRef);
        }
        
        // Apply the new font with new traits
        if (newFont)
        {
            [self removeAttribute:(__bridge NSString*)kCTFontAttributeName range:fontRange]; // Work around for Apple leak
            [self addAttribute:(__bridge NSString*)kCTFontAttributeName value:(__bridge id)newFont range:fontRange];
            CFRelease(newFont);
        }
        
        // If the fontRange was not covering the whole range, continue with next run
        startPoint = NSMaxRange(effectiveRange);
    } while(startPoint<NSMaxRange(range));
    [self endEditing];
}

@end
