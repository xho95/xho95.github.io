Tint Color

Views have a tintColor property that specifies the color of key elements within the view. Each subclass of UIView defines its own appearance and behavior for tintColor. For example, this property determines the color of the outline, divider, and icons on a stepper:

image: ../Art/uistepper_intro.png

The tintColor property is a quick and simple way to skin your app with a custom color. Setting a tint color for a view automatically sets that tint color for all of its subviews. However, you can manually override this property for any of those subviews and its descendants. In other words, each view inherits its superview’s tint color if its own tint color is nil. If the highest level view in the view hierarchy has a nil value for tint color, it defaults to the system blue color.

