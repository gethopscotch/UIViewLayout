UIView Layout
=============

Writing your `-layoutSubviews` methods by modifying `CGRect`s is tedious and error prone. Instead, you can use more semantic methods for accomplishing your goals. For example:


```
- (void)layoutSubviews {
	[super layoutSubviews];
	
	[self.titleView sizeToFit];
	[self.titleView moveToHorizontalCenterOfView:self];
	
	[self.imageView sizeToFit];
	[self.imageView moveToHorizontalCenterOfView:self];
	[self.imageView moveBelowSiblingView:self.titleView margin:20];
}
```

Todo
----

- Installation instructions
