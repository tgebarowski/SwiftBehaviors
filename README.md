# Swift Behaviors

This repository is a collection of small uncoupled objects indented to provide different functionality that can be shared between iOS apps.
It is based on principles described in Behaviors in iOS Apps by *Krzysztof Zabłocki*, objc.io #13 (http://www.objc.io/issue-13/behaviors.html), but ported to Swift.

All behaviors inherit from SwiftBehavior object, which provides lifetime binding to owner object (for more details see article in objc.io)
For behaviors that require access to UIView properties (e.g. animations), which are not available in awakeFromNib, ViewBehavior object has been defined.
This behavior provides targetView IBOutlet and two methods that can be overriden:

 * targetViewDidSet(target: UIView)
 * targetViewDidLoad(target: UIView)

The whole idea is to attach a targetView IBOutlet to a UIView that we want to be sure that is loaded when targetViewDidLoad method is called.
With this approach by overriding targetViewDidLoad behaviors that modify UIView properties may be created.

All behaviors that are available in this repository are written in Swift and can be used by simply dropping NSObject into your Interface Builder
 scene and setting its custom class to specific behavior class available in this repository. After setting behavior dependent IBOutlets without almost any line of
 code you will be able to provide certain animations or effects in your iOS apps.

## View based behaviors

### Sonar UIButton

Behavior providing sonar like animation when pressing and holding UIButton. Note that, Single SonarButtonBehavior can provide animation behavior for several buttons.

![Sonar Buttons effect](https://github.com/tgebarowski/SwiftBehaviors/blob/master/img/SonarButtons.gif)

#### How to use it ?

Drop NSObject into your scene in Interface Builder, set its custom class to SonarButtonBehavior.
Set behavior object IBOutlets:

 * *owner* to UIButton which will be animated with Sonar animation
 * *targetView* to containing UIView

Set UIButton actions:

 * *Touch Down* to behavior's buttonPressed:
 * *Touch Up* inside to behavior's buttonReleased:

### Translucent Modal

The intention of BlurredViewBehavior was to create iOS 7 and 8 compatible translucency effect for modal views.
The behavior relies on UIVisualEffectView  on iOS 8 and UIImage category providing similar effect on iOS 7.

By simply dropping BlurredViewBehavior you can make translucent modal views without a single line of code on both iOS 7 and iOS 8.

![Translucent Modal View effect](https://github.com/tgebarowski/SwiftBehaviors/blob/master/img/TranslucentView.gif)

#### How to use it ?

Drop NSObject into your scene in Interface Builder, set its custom class to BlurredViewBehavior.

Set behavior object IBOutlets:

 * *owner* to your UIViewController
 * *targetVC* to your UIViewController
 * *targetView* to UIView that will simulate translucent effect

In Interface Builder in your UIViewController Attributes Inspector set Presentation to Over Current Context
 and preferrably Transition Style to Cross Dissolve.

### Exclusive UIButtons

This is a simple behavior that protects a group of UIButtons from being selected at the same time.

![Exclusive Buttons effect](https://github.com/tgebarowski/SwiftBehaviors/blob/master/img/ExclusiveButtons.gif)

#### How to use it ?

Drop NSObject into your scene in Interface Builder, set its custom class to ExclusiveButtons.

Set behavior object IBOutlets:

 * *owner* to your UIViewController
 * *targetView* to UIView that will be monitored for being loaded. This is important because UIButtons' targets are added after view is loaded.

### Beating Circle

Behavior adding to a center of indicated UIView an animated beating circle. The animation is started when the target UIVew is loaded.

![Beating Circle effect](https://github.com/tgebarowski/SwiftBehaviors/blob/master/img/BeatingCircle.gif)

#### How to use it ?

Drop NSObject into your scene in Interface Builder, set its custom class to BeatingCircleBehavior.

Set behavior object IBOutlets:

 * *owner* to your UIViewController
 * *targetView* to UIView to which an animated circle will be added as a subview, centered vertically and horizontally.

Note: Behavior can be configured using Interface Builder Attributes Inspector.

### Fade In UIView effect

Simple behavior which adds fade in effect to arbitrary UIView.

![Fade In effect](https://github.com/tgebarowski/SwiftBehaviors/blob/master/img/FadeIn.gif)

#### How to use it ?

Drop NSObject into your scene in Interface Builder, set its custom class to FadeInAnimationBehavior.

Set behavior object IBOutlets:

 * *owner* to your UIViewController
 * *targetView* to UIView for which fade in effect is added

Note: This behavior can be configured using Attributes Inspector (Duration and initial animation Delay)

## Transitions

### UITableView/UICollectionView cell expansion transition

This behavior can be added to provide transition from UITableView or UICollectionView to another UIViewController.
It adds cell expansion effect as indicated on animation below.

![Transition Expand effect](https://github.com/tgebarowski/SwiftBehaviors/blob/master/img/TransitionExpand.gif)

#### How to use it ?

Drop NSObject into your scene in Interface Builder, set its custom class to TableViewCellExpansionBehavior or CollectionViewCellExpansionBehavior depending on the type of animated cell.

Set behavior object IBOutlets:

 * *owner* to your UIViewController

Set UINavigationController delegate to point to TableViewCellExpansionBehavior or CollectionViewCellExpansionBehavior

If you have your own UINavigationControllerDelegate you may still use it by setting behavior's collectionViewDelegate IBOutlet to your own delegate.

Note: The multiplexer pattern that could be applied here and described in objc.io article is not possible in pure Swift due to lack of forwardInvocation:(NSInvocation *) equivalent.
Due to this limitation Transition Cell Expansion Behavior has to provide a bit limited approach towards delegating UINavigationControllerDelegate.
