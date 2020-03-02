//: A UIKit based Playground for presenting user interface
  
import UIKit
import PlaygroundSupport
import ListMovsFeature

let router = ListMovsRouter()
let viewController = router.makeUI()

PlaygroundPage.current.liveView = viewController

