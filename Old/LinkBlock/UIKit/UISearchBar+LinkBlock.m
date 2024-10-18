//
//  UISearchBar+LinkBlock.m
//  LinkBlockProgram
//
//  Created by NOVO on 17/5/8.
//  Copyright © 2017年 NOVO. All rights reserved.
//
#import "LinkBlock.h"

@implementation NSObject(UISearchBarLinkBlock)

- (UISearchBar *(^)(NSString *))searchBarText
{
    return ^id(NSString* text){
        LinkHandle_REF(UISearchBar)
        LinkGroupHandle_REF(searchBarText, text)
        _self.text = text;
        return _self;
    };
}

- (UISearchBar *(^)(NSString *))searchBarPlaceholder
{
    return ^id(NSString* placeholder){
        LinkHandle_REF(UISearchBar)
        LinkGroupHandle_REF(searchBarPlaceholder, placeholder)
        _self.placeholder = placeholder;
        return _self;
    };
}

- (UISearchBar *(^)(id<UISearchBarDelegate>))searchBarDelegate
{
    return ^id(id<UISearchBarDelegate> delegate){
        LinkHandle_REF(UISearchBar)
        LinkGroupHandle_REF(searchBarDelegate, delegate)
        _self.delegate = delegate;
        return _self;
    };
}

- (UISearchBar *(^)(BOOL))searchBarShowsBookmarkButton
{
    return ^id(BOOL showsBookmarkButton){
        LinkHandle_REF(UISearchBar)
        LinkGroupHandle_REF(searchBarShowsBookmarkButton, showsBookmarkButton)
        _self.showsBookmarkButton = showsBookmarkButton;
        return _self;
    };
}

- (UISearchBar *(^)(BOOL))searchBarShowsCancelButton
{
    return ^id(BOOL showsCancelButton){
        LinkHandle_REF(UISearchBar)
        LinkGroupHandle_REF(searchBarShowsCancelButton, showsCancelButton)
        _self.showsCancelButton = showsCancelButton;
        return _self;
    };
}

- (UISearchBar *(^)(BOOL))searchBarShowsSearchResultsButton
{
    return ^id(BOOL showsSearchResultsButton){
        LinkHandle_REF(UISearchBar)
        LinkGroupHandle_REF(searchBarShowsSearchResultsButton, showsSearchResultsButton)
        _self.showsSearchResultsButton = showsSearchResultsButton;
        return _self;
    };
}

- (UISearchBar *(^)(UIImage *))searchBarBackgroundImage
{
    return ^id(UIImage* backgroundImage){
        LinkHandle_REF(UISearchBar)
        LinkGroupHandle_REF(searchBarBackgroundImage, backgroundImage)
        _self.backgroundImage = backgroundImage;
        return _self;
    };
}

- (UITextField *(^)(void))searchBarSearchField
{
    return ^id(){
        LinkHandle_REF(UISearchBar)
        LinkGroupHandle_REF(searchBarSearchField)
        return [_self valueForKey:@"_searchField"];
    };
}

- (UISearchBar *(^)(UIColor *))searchBarBackgroundImageColor
{
    return ^id(UIColor* color){
        LinkHandle_REF(UISearchBar)
        LinkGroupHandle_REF(searchBarBackgroundImageColor, color)
        if([color isKindOfClass:[UIColor class]]){
            _self.backgroundImage = color.colorToUIImage(CGSizeMake(1, 1));
        }
        return _self;
    };
}

- (UISearchBar *(^)(UIColor *))searchBarPlaceholderColor
{
    return ^id(UIColor* color){
        LinkHandle_REF(UISearchBar)
        LinkGroupHandle_REF(searchBarPlaceholderColor, color)
        if([color isKindOfClass:[UIColor class]]){
            [[_self valueForKey:@"_searchField"] setValue:color forKey:@"_placeholderLabel.textColor"];
        }
        return _self;
    };
}
@end
