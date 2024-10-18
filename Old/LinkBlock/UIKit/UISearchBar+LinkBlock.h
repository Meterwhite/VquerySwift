//
//  UISearchBar+LinkBlock.h
//  LinkBlockProgram
//
//  Created by NOVO on 17/5/8.
//  Copyright © 2017年 NOVO. All rights reserved.
//

#import "LinkBlockDefine.h"

#define UISearchBarNew ([UISearchBar new])

@interface NSObject(UISearchBarLinkBlock)
@property LB_BK       UISearchBar* (^searchBarText)(NSString* text);
@property LB_BK       UISearchBar* (^searchBarPlaceholder)(NSString* placeholder);
@property LB_BK       UISearchBar* (^searchBarDelegate)(id<UISearchBarDelegate> delegate);
@property LB_BK       UISearchBar* (^searchBarShowsBookmarkButton)(BOOL showsBookmarkButton);
@property LB_BK       UISearchBar* (^searchBarShowsCancelButton)(BOOL showsCancelButton);
@property LB_BK       UISearchBar* (^searchBarShowsSearchResultsButton)(BOOL showsSearchResultsButton);
@property LB_BK       UISearchBar* (^searchBarBackgroundImage)(UIImage* backgroundImage);

#pragma mark - LinkBlock

/** Get TextField from search bar  */
@property LB_BK       UITextField* (^searchBarSearchField)(void);
/** Use to modify border color of searchBar  */
@property LB_BK       UISearchBar* (^searchBarBackgroundImageColor)(UIColor* color);
@property LB_BK       UISearchBar* (^searchBarPlaceholderColor)(UIColor* color);
@end
