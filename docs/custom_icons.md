# Custom icons

### Introduction

Fries has introduced custom icons recently, you can use them in either SVGs or Android XMLs.
These allows for easier custom icons, because instead of using tools to convert vectors into dart icon fonts,
you can just include the vector files in the assets and use them easily.

### Using custom icons

As stated before, you either need an **xml** file or **svg** file for the icon.
If you use an android xml be sure to remove any android color references (you can replace those with just #ffffff, tinting is done via code).

The icon has to be added into the assets/ folder, and that's it! Easy no?

For actually using it inside the app ui you need to modify one of the pages data (data/ folder) by modifying the "icon" attribute.
Instead of using Icons.blabla (which uses IconData), use "assets/\<icon-name\>.svg" or "assets/\<icon-name\>.xml".

#### Example:
```
"foo": {
    "title": "Example setting",
    "subtitle": "A quick example to show case custom icons",
    "icon": "assets/MyCustomIcons.svg",
    ...
}
```

And that's it, once you compile the app you will see the custom icon appear in the modified page.

### Inner working

But how does it work internally? Well, there is a custom class called [SmartIcon](../lib/ui/smart_icon.dart)
that handles everything. The class structure is similar to the normal flutter [Icon](https://api.flutter.dev/flutter/widgets/Icon-class.html) class,
but instead the iconData paramater is dynamic and call allow various types of icons.

If iconData is of type [IconData](https://api.flutter.dev/flutter/widgets/IconData-class.html), if instead it's a String,
it starts parsing the custom icon. If the passed string ends with .svg, then we'll use a
[SvgPicture](https://pub.dev/documentation/flutter_svg/latest/svg/SvgPicture-class.html) and load the svg accordingly,
else if it ends with .xml we'll use an [AvdPicture](https://pub.dev/documentation/flutter_svg/latest/avd/AvdPicture-class.html) and same thing as the svg one, just for drawables.

If the conditions don't match the ones just described, then the class will throw a TypeError,
indicating that it can't load the iconData (if instead iconData is null, it will just render an empty box).

SmartIcon also supports custom icons and size for complete customization.

### Limitations

As of now XML support isn't complete and it doesn't render correctly properties like "fillType" with "evenOdd" (even tho the same thing applies with svgs).
So we really suggest you either use a svg file or be sure to not use any fillType attribute in your xmls.