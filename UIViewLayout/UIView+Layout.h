//
//  UIView+Layout.h
//  UIViewLayout
//
//  Created by Sam and Jason in 2012-2014.
//  Copyright (c) 2014 Hopscotch. All rights reserved.
//

@import UIKit;


/** Generic void block typedef. */
typedef void(^ActionBlock)();

@interface UIView (Layout)

/** Convenience property to get or set the view's frame's origin. The setter rounds the values given. */
@property (nonatomic) CGPoint origin;

/** Convenience property to get or set the view's frame's origin.x. The setter rounds the value given. */
@property (nonatomic) CGFloat x;

/** Convenience property to get or set the view's frame's origin.y. The setter rounds the value given. */
@property (nonatomic) CGFloat y;

/** Returns the maxX of the view's frame. */
@property (nonatomic, readonly) CGFloat maxX;

/** Returns the maxY of the view's frame. */
@property (nonatomic, readonly) CGFloat maxY;


/** The size of the view's frame. */
@property (nonatomic) CGSize size;

/** Returns or sets the normalized width of the view's frame. */
@property (nonatomic) CGFloat width;

/** Returns or sets the normalized height of the view's frame. */
@property (nonatomic) CGFloat height;


/** Returns the normalized width of the bounds. Use this when determining sizes, as frame may be invalid (if the view has a transform. */
@property (nonatomic, readonly) CGFloat boundsWidth;

/** Returns the normalized height of the bounds. Use this when determining sizes, as frame may be invalid (if the view has a transform. */
@property (nonatomic, readonly) CGFloat boundsHeight;

/** Returns the receiver's zIndex in its superview. 0 means it is the bottom-most subview of its siblings. */
@property (nonatomic, readonly) NSInteger zIndexInSuperview;

#pragma mark - Initializing

/** Creates a new UIView and sets its superview. */
+ (instancetype)newWithSuperview:(UIView *)superview;


/** Vertically centers the view in the given superview. */
- (void)moveToVerticalCenterOfView:(UIView *)superview;

/** Horizontally centers the view in the given superview. */
- (void)moveToHorizontalCenterOfView:(UIView *)superview;

/** Centers self vertically and horizontally in the given superview. */
- (void)moveToCenterOfView:(UIView *)superview;


#pragma mark - Sibling views

/**
 Positions self vertically relative to the sibling view, letting you position self e.g., 20pts below the bottom of sibling view.
 
 @param siblingView The view below which you are positioning self.
 @param margin A vertical margin, in points, between the bottom of `siblingView` and the yOrigin of self. Pass 0 to have self be directly below `siblingView`.
*/
- (void)moveBelowSiblingView:(UIView *)siblingView margin:(CGFloat)margin;


/**
 Positions self vertically relative to the sibling view, and also positions horizontally to the view with the given alignment.
 
 This lets you move below a view, but also align with it, either at siblingView's left or right margin, or centering below it.
 
 @param siblingView The view below which you are positiong and aligning self.
 @param margin A vertical margin, in points, between the bottom of siblingView and the yOrigin of self.
 @param alignment Horizontal alignment relative to siblingView. Use this to align self to the left edge, center, or right edge of siblingView. Pass NSTextAlignmentNatural for no alignment.
*/
- (void)moveBelowAndAlignWithSiblingView:(UIView *)siblingView margin:(CGFloat)margin alignment:(NSTextAlignment)alignment;

/**
 Positions self vertically relative to the sibling view, and also positions horizontally to the view with the given alignment.
 
 This lets you move above a view, but also align with it, either at siblingView's left or right margin, or centering below it.
 
 @param siblingView The view below which you are positiong and aligning self.
 @param margin A vertical margin, in points, between the bottom of siblingView and the yOrigin of self.
 @param alignment Horizontal alignment relative to siblingView. Use this to align self to the left edge, center, or right edge of siblingView. Pass NSTextAlignmentNatural for no alignment.
*/
- (void)moveAboveAndAlignWithSiblingView:(UIView *)siblingView margin:(CGFloat)margin alignment:(NSTextAlignment)alignment;


/**
 Positions self vertically relative to the sibling view, letting you position self e.g., 20pts above the bottom of sibling view.
 
 @param siblingView The view above which you are positioning self.
 @param margin A vertical margin, in points, between the top of `siblingView` and the Max Y of self. Pass 0 to have self be directly above `siblingView`.
*/
- (void)moveAboveSiblingView:(UIView *)siblingView margin:(CGFloat)margin;


/**
 Positions self horizontally relative to the sibling view, letting you position self e.g., 20pts right of sibling view.
 
 @param siblingView The view above which you are positioning self.
 @param margin A horizontal margin, in points, between the left of `siblingView` and the xOrigin of self. Pass 0 to have self be directly to the right of `siblingView`.
*/
- (void)moveToRightOfSiblingView:(UIView *)siblingView margin:(CGFloat)margin;

/**
 Positions self horizontally relative to the sibling view, letting you position self e.g., 20pts left of sibling view.
 
 @param siblingView The view to the left which you are positioning self.
 @param margin A horizontal margin, in points, between the left of `siblingView` and the xOrigin of self. Pass 0 to have self be directly to the right of `siblingView`.
*/
- (void)moveToLeftOfSiblingView:(UIView *)siblingView margin:(CGFloat)margin;

/** Give your view the same vertical center as its sibling  */
- (void) alignVerticallyWithSiblingView:(UIView *)view;

/** Give your view the same horizontal center as its sibling  */
- (void) alignHorizontallyWithSiblingView:(UIView *)view;


/**
 Moves the receiver to be vertically centred between two sibling views. Passing nil for either sibling view causes the centring to happen with respect to the top or bottom of the receiver's superview.
 
 @param topSiblingView The top sibling view used as an anchor to centre against. The receiver will be centred relative to this view's maxY. If this view is nil, then the top of the superview (i.e., y = 0) will be used instead.
 
 @param bottomSiblingView The bottom sibling view used as an anchor to centre against. The receiver will be centred relative to this view's minY. If this view is nil, then the bottom of the superview (i.e., y = self.superview.height) will be used instead.
*/
- (void)moveToBeVerticallyCenteredBetweenTopSiblingView:(UIView *)topSiblingView andBottomSiblingView:(UIView *)bottomSiblingView;

#pragma mark - Sizing

/** Ensures that the view has called -layoutSubviews before calling -sizeToFit. */
- (void)forceLayoutAndSizeToFit;

/**
 This method performs the given layoutBlock and then optionally lets you rollback those layout changes.
 This is useful if you're implementing  -sizeThatFits:commitLayout: so your layout code and size calculating can be done in a simpler way.
 
 You write your layout code like you normally would for -layoutSubviews, and in the end you calculate the size for your view.
 By telling this method commitLayout = NO, you are saying it should undo any frame changes made to your subviews in layoutBlock.
 
 @note If not committing the layout, frames (and only frames) will be restored for direct subviews (not subviews of subviews).
 
 @param layoutBlock A Block object where you should perform layout changes to your subviews and calculate your view's size.
 @param commitLayout If this flag is NO, then all subview frames are recorded before layoutBlock is run, and then the recorded frames are set back to the subviews afterwards. In effect, this reverses any frame (and only frame) changes made in layoutBlock.
*/
- (void)runLayoutBlock:(ActionBlock)layoutBlock commitLayout:(BOOL)commitLayout;

/**
 Adds padding to the view on each side so adding 10 horizontal padding will increase the width by 10 * 2 = 20.
 The views contents need to be centered for this to work.
*/
- (void)addHorizontalPadding:(CGFloat)horizontalPadding verticalPadding:(CGFloat)verticalPadding;


/** Resize the view so that it stretches to contain all its subviews.
 You should call this on a container view after you've finished laying out all its subviews.
 Will not take into account subviews of subviews.
*/
- (void)resizeToContainSubviews;

/**
 For when you need to do a bunch of layout to calculate the appropriate size that fits.
 Override this method when you desire this behavior in your view.
*/
- (CGSize)sizeThatFits:(CGSize)size commitLayout:(BOOL)commitLayout;

#pragma mark - Finding views

/** Returns whether or not the receiver contains the given view somewhere in its subview tree. */
- (BOOL)hasDescendentSubview:(UIView *)descendent;



#pragma mark - Hit testing

/** Checks if the point is inside the minimum allowable tap size if the bounds is too small.
 
 Use this method if you want to have a minimum 44x44pt tappable area for your view. This method acts as if the bounds is at least 44pts square.
 
 You should call this after a call to [super pointInside:withEvent:] has already failed.
*/
- (BOOL)pointInsideMinimumBounds:(CGPoint)point;


@end
