//
//  View.h
//  TouchExplorer
//
//  Created by Artem Rakhmatulin on 05/04/2020.
//  Copyright © 2020 Rakhmatulin Artem Timurovich IP. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface View : UIView

- (UILabel *)messageLabel;
- (UILabel *)tapsLabel;
- (UILabel *)touchesLabel;
- (UILabel *)gestureLabel;

@end

NS_ASSUME_NONNULL_END
