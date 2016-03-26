//: Playground - noun: a place where people can play

import UIKit

class WidgetClass {
    var name: String?
    var isBaseClass = true
}

var myWidget = WidgetClass()      // initializer syntax

struct WidgetSize {
    var width: Double
    var height: Double
}

var newWidgetSize = WidgetSize(width: 10, height: 20)      // memberwise initializer
