//: Playground - noun: a place where people can play

import UIKit
import AVFoundation
import PlaygroundSupport

var player = AVQueuePlayer()
let phone = Phone(player: player)

// Set assistant editor to phone view
PlaygroundPage.current.liveView = phone
// Make background match with Xcode default white
// NOTE: May appear different if Xcode editor is not default white
phone.superview?.backgroundColor = UIColor(red: 0.969, green: 0.969, blue: 0.969, alpha: 1)

//let url = URL(string: "https://p.scdn.co/mp3-preview/cf59f26b733e20af6a8fe225ad92be9943bde0bc?cid=null")
//let player = AVPlayer(url: url!)
//player.play()
