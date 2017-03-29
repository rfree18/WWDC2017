//: Playground - noun: a place where people can play

import UIKit
import AVFoundation
import PlaygroundSupport


// Need to initiate AVQueuePlayer here in order to get audio to play in Playgrounds
// Will create a singleton wrapper class if time permits
var player = AVQueuePlayer()
let phone = Phone(player: player)

// Set assistant editor to phone view
PlaygroundPage.current.liveView = phone
// Make background match with Xcode default white
// NOTE: May appear different if Xcode editor is not default white
phone.superview?.backgroundColor = UIColor(red: 0.969, green: 0.969, blue: 0.969, alpha: 1)