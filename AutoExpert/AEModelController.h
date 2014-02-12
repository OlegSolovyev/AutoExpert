//
//  AEModelController.h
//  AutoExpert
//
//  Created by Oleg Solovyev on 03/02/14.
//  Copyright (c) 2014 Opensoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AEDataViewController;

@interface AEModelController : NSObject <UIPageViewControllerDataSource>

- (AEDataViewController *)viewControllerAtIndex:(NSUInteger)index storyboard:(UIStoryboard *)storyboard;
- (NSUInteger)indexOfViewController:(AEDataViewController *)viewController;

@end
