//: Playground - noun: a place where people can play

import UIKit
import PlaygroundSupport

let phone = Phone()

// Set assistant editor to phone view
PlaygroundPage.current.liveView = phone
// Make background match with Xcode default white
// NOTE: May appear different if Xcode editor is not default white
phone.superview?.backgroundColor = UIColor(red: 0.969, green: 0.969, blue: 0.969, alpha: 1)