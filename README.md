# Unobtrusive

Add a polite configurable message to you your users.

![ScreenShot](/Unobtrusive.png)

Still very young!

## How to add
- Add UIView to your View Controller Scene (or XIB).
- Pin the top, left and right edges edges of the screen
- Pin the bottom to any element underneath
- Set class of UIView to `UnobtrusiveView` in the Custom Class panel (this will fix red flags for missing constraints)
- Create an outlet for the view in the scene's view controller
- Add the following code to be called any time, but probably in `viewWillAppear`

```
[self.unobtrusiveView setLabelWithText:@"I'd love to ask you somthing."];

[self.unobtrusiveView.label setTextColor: [UIColor whiteColor]];
[self.unobtrusiveView setBackgroundColor: self.view.tintColor];

[self.unobtrusiveView.button setTitle:@"  Yes 👍  " forState:UIControlStateNormal];

[self.unobtrusiveView.button sizeToFit];
[self.unobtrusiveView.button layoutIfNeeded];

[self.unobtrusiveView.button setBackgroundColor:[UIColor whiteColor]];
[self.unobtrusiveView.button.layer setCornerRadius: 5];
[self.unobtrusiveView.button.layer setMasksToBounds:YES];


self.unobtrusiveView.tapGoCallback = ^{
    // what to do if they tap the button
    // the view will dismiss itself
};

self.unobtrusiveView.tapDismissCallback = ^{
    // if the user taps the notification it will dismiss it
    // add any code here to track that event
};
```
