//
//  UIView+Layout.m
//  UIViewLayout
//
//  Created by Sam and Jason in 2012-2014.
//  Copyright (c) 2014 Hopscotch. All rights reserved.
//

#import "UIView+Layout.h"

@implementation UIView (Layout)

#pragma mark - Initializers

+ (instancetype)newWithSuperview:(UIView *)superview
{
	UIView *view = [self new];
	[superview addSubview:view];
	
	return view;
}


#pragma mark - Properties

- (void)setOrigin:(CGPoint)position
{
	CGRect frame = self.frame;
	position.x = floorf(position.x);
	position.y = floorf(position.y);
	frame.origin = position;
	self.frame = frame;
}

- (void)setX:(CGFloat)xPosition
{
	CGRect frame = self.frame;
	frame.origin.x = floorf(xPosition);
	self.frame = frame;
}

- (void)setY:(CGFloat)yPosition
{
	CGRect frame = self.frame;
	frame.origin.y = floorf(yPosition);
	self.frame = frame;
}

- (void)setSize:(CGSize)size
{
	CGRect frame = self.frame;
	size.width = ceilf(size.width);
	size.height = ceilf(size.height);
	frame.size = size;
	self.frame = frame;
}

- (void)setWidth:(CGFloat)width
{
	CGRect frame = self.frame;
	frame.size.width = ceilf(width);
	self.frame = frame;
}

- (void)setHeight:(CGFloat)height
{
	CGRect frame = self.frame;
	frame.size.height = ceilf(height);
	self.frame = frame;
}


#pragma mark - Getters

- (CGPoint)origin
{
	return self.frame.origin;
}

- (CGFloat)x
{
	return [self origin].x;
}

- (CGFloat)y
{
	return [self origin].y;
}


- (CGFloat)maxX
{
	return CGRectGetMaxX(self.frame);
}


- (CGFloat)maxY
{
	return CGRectGetMaxY(self.frame);
}

- (CGSize)size
{
	return self.frame.size;
}

- (CGSize)boundsSize
{
	return self.bounds.size;
}

- (CGFloat)width
{
	return CGRectGetWidth(self.frame);
}

- (CGFloat)height
{
	return CGRectGetHeight(self.frame);
}


- (CGFloat)boundsWidth
{
	return CGRectGetWidth(self.bounds);
}

- (CGFloat)boundsHeight
{
	return CGRectGetHeight(self.bounds);
}


- (NSInteger)zIndexInSuperview
{
	return [[[self superview] subviews] indexOfObject:self];
}

#pragma mark - Positioning


- (void)addHorizontalPadding:(CGFloat)horizontalPadding verticalPadding:(CGFloat)verticalPadding
{
	CGRect frame = self.frame;
	frame.size.width += 2 * horizontalPadding;
	frame.size.height += 2 * verticalPadding;
	self.frame = frame;
}


- (void)moveToVerticalCenterOfView:(UIView *)superview
{
	self.y = superview.boundsSize.height/2 - self.boundsSize.height/2;
}

- (void)moveToHorizontalCenterOfView:(UIView *)superview
{
	self.x = superview.boundsSize.width / 2.0 - self.boundsSize.width / 2.0;
}


- (void)moveToCenterOfView:(UIView *)superview
{
	[self moveToHorizontalCenterOfView:superview];
	[self moveToVerticalCenterOfView:superview];
}


#pragma mark - Sibling views

- (void)moveBelowSiblingView:(UIView *)siblingView margin:(CGFloat)margin
{
	[self moveBelowAndAlignWithSiblingView:siblingView margin:margin alignment:NSTextAlignmentNatural];
}


- (void)moveBelowAndAlignWithSiblingView:(UIView *)siblingView margin:(CGFloat)margin alignment:(NSTextAlignment)alignment
{
	self.y = CGRectGetMaxY(siblingView.frame) + margin;
	
	
	switch (alignment) {
		case NSTextAlignmentLeft:
			self.x = siblingView.x;
			return;
		case NSTextAlignmentCenter: {
			CGPoint center = siblingView.center;
			center.y = self.center.y;
			self.center = center;
			return;
		}
		case NSTextAlignmentRight:
			self.x = CGRectGetMaxX(siblingView.frame) - self.boundsWidth;
			return;
			
		case NSTextAlignmentNatural:
		case NSTextAlignmentJustified:
			return;
	}
	
}


- (void)moveAboveSiblingView:(UIView *)siblingView margin:(CGFloat)margin
{
	[self moveAboveAndAlignWithSiblingView:siblingView margin:margin alignment:NSTextAlignmentNatural];
}

- (void)moveAboveAndAlignWithSiblingView:(UIView *)siblingView margin:(CGFloat)margin alignment:(NSTextAlignment)alignment
{
	self.y = CGRectGetMinY(siblingView.frame) - self.height - margin;
	
	
	switch (alignment) {
		case NSTextAlignmentLeft:
			self.x = siblingView.x;
			return;
		case NSTextAlignmentCenter: {
			CGPoint center = siblingView.center;
			center.y = self.center.y;
			self.center = center;
			return;
		}
		case NSTextAlignmentRight:
			self.x = CGRectGetMaxX(siblingView.frame) - self.width;
			return;
			
		case NSTextAlignmentNatural:
		case NSTextAlignmentJustified:
			return;
	}
	
}

- (void)moveToRightOfSiblingView:(UIView *)siblingView margin:(CGFloat)margin
{
	self.x = CGRectGetMaxX(siblingView.frame) + margin;
}

- (void)moveToLeftOfSiblingView:(UIView *)siblingView margin:(CGFloat)margin
{
	self.x = CGRectGetMinX(siblingView.frame) - self.boundsWidth - margin ;
}

- (void)alignVerticallyWithSiblingView:(UIView *)view
{
	CGPoint center = self.center;
	center.y = view.center.y;
	self.center = center;
}

- (void)alignHorizontallyWithSiblingView:(UIView *)view
{
	CGPoint center = self.center;
	center.x = view.center.x;
	self.center = center;
}


- (void)moveToBeVerticallyCenteredBetweenTopSiblingView:(UIView *)topSiblingView andBottomSiblingView:(UIView *)bottomSiblingView
{
	CGFloat minY = topSiblingView ? topSiblingView.maxY : 0;
	CGFloat maxY = bottomSiblingView ? bottomSiblingView.y : self.superview.height;
	
	CGFloat midY = (maxY - minY) / 2.0 + minY;
	CGPoint center = self.center;
	center.y = midY;
	self.center = center;
}

#pragma mark - Sizing

- (void)resizeToContainSubviews
{
	CGRect frame = CGRectZero;
	for (UIView *view in self.subviews) {
		frame = CGRectUnion(frame, view.frame);
	}
	
	self.size = frame.size;
}

- (void)forceLayoutAndSizeToFit
{
	[self setNeedsLayout];
	[self layoutIfNeeded];
	[self sizeToFit];
}


- (void)runLayoutBlock:(ActionBlock)layoutBlock commitLayout:(BOOL)commitLayout
{
	
	// if we're not committing the layout, preserve subview frames
	NSMapTable *viewToFrameMap = nil;
	if (!commitLayout) {
		viewToFrameMap = [NSMapTable weakToWeakObjectsMapTable];
		for (UIView *subview in self.subviews) {
			[viewToFrameMap setObject:[NSValue valueWithCGRect:subview.frame] forKey:subview];
		}
	}
	
	layoutBlock();
	
	
	// Restore subview frames if needed.
	if (!commitLayout) {
		for (UIView *mappedView in viewToFrameMap) {
			mappedView.frame = [[viewToFrameMap objectForKey:mappedView] CGRectValue];
		}
	}
}




#pragma mark - Finding views

- (BOOL)hasDescendentSubview:(UIView *)descendent
{
	UIView *superView = descendent.superview;
	while (superView != nil) {
		if (superView == self) {
			return YES;
		}
		
		superView = superView.superview;
	}
	
	return NO;
}

- (CGSize)sizeThatFits:(CGSize)size commitLayout:(BOOL)commitLayout
{
	return [self sizeThatFits:size];
}


#pragma mark - Hit testing


- (BOOL)pointInsideMinimumBounds:(CGPoint)point
{
	CGRect bounds = self.bounds;
	const CGFloat MinimumButtonLength = 44.0;
	CGFloat deltaX = self.width - MinimumButtonLength;
	CGFloat deltaY = self.height - MinimumButtonLength;
	deltaY = fminf(deltaY, 0);
	deltaX = fminf(deltaX, 0);
	bounds = CGRectInset(bounds, deltaX, deltaY);
	
	return CGRectContainsPoint(bounds, point);
}

@end
