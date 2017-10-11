//
//  GameViewController.swift
//  test
//
//  Created by Anderson, Todd W. on 2/11/17.
//  Copyright © 2017 Anderson, Todd W. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit
import GoogleMobileAds


class GameViewController: UIViewController, GADInterstitialDelegate {

    var scene: SKScene? = nil;
    var interstitial: GADInterstitial!
    var maze: [[UInt8]]?
    
    //called when the vuew loads (when the splash screen ends)
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /*//initializes the menu scene where you start
        scene = MenuScene(controller: self)
        (scene as? MenuScene)?.controller = self
        let view = self.view as! SKView
        view.ignoresSiblingOrder = true
        view.showsFPS = true
        view.showsNodeCount = true
        scene?.scaleMode = .aspectFill
        //sets the menu scene as the actie scene
        view.presentScene(scene!, transition: SKTransition.fade(with: UIColor.white, duration: 1.0))*/
        
        //initiates the game scene and starts the game
        super.viewDidLoad()
        interstitial = GADInterstitial(adUnitID: "ca-app-pub-3940256099942544/4411468910")
        let request = GADRequest()
        interstitial.load(request)
        maze = loadMaze()
        startLevel()
    }

    override var shouldAutorotate: Bool {
        return true
    }
    //the only supported orientation is portrait
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
    func startLevel() {
        //initiates game scene
        scene = GameScene(size: CGSize(width: 2048, height: 1536), tile: UIDevice.current.width /*Double(UIScreen.main.bounds.width) / 2.5*/, controller: self, maze: maze!, level: loadInteger(key: "level"), x: loadInteger(key: "x"), y: loadInteger(key: "y"))
        let view = self.view as! SKView
        view.ignoresSiblingOrder = true
        view.showsFPS = true
        view.showsNodeCount = true
        scene?.scaleMode = .aspectFill
        //sets game scene as the active scene
        view.presentScene(scene!, transition: SKTransition.fade(with: UIColor.black, duration: 1.0))
    }
    
    private func saveInteger(key: String, value: Int) {
        //saves an Intege in the system under a key that is used for retrieval
        UserDefaults.standard.set(value, forKey: key)
    }
    private func saveMaze(value: [[UInt8]]) {
        //saves the maze (only ever called once) under the key "maze"
        UserDefaults.standard.set(NSArray(array: value), forKey: "maze")
    }
    
    func loadMaze() -> [[UInt8]] {
        //checks if the maze has been created yet and loads it if it has or generates and saves it if it hasnt, returns the maze
        let maze: [[UInt8]]? = UserDefaults.standard.array(forKey: "maze") as? [[UInt8]]
        let count = maze?.count
        let _ = maze?.count
        if (count != nil) {
            return maze!
        }
        else {
            let maze = MazeGenerator.init().getMaze()
            saveMaze(value: maze)
            return maze
        }
        
    }
    
    func loadInteger(key: String) -> Int {
        //loads an integer from a key that said integer is stored under
        let int: Int? = UserDefaults.standard.integer(forKey: key)
        if (int != 0) {
            return int!
        }
        //if not found it return a default value determined by the key
        switch key {
            case "level": return 1
            case "x", "y": return 500
            default: return 1
            // put other default values here
        }
    }
    
    //called when a level has been completed ups the level and saves the players last location
    func completeLevel(x: Int, y: Int) {
        saveInteger(key: "level", value: loadInteger(key: "level") + 1)
        saveInteger(key: "x", value: x)
        saveInteger(key: "y", value: y)
        startLevel()
    }
    
    //called when the player fails a level, this starts the level over again
    func failLevel() {
        playAd()
        startLevel()
    }
    
    func playAd() {
        if (interstitial.isReady && arc4random_uniform(4) == 0) {
            interstitial.present(fromRootViewController: self)
        }
    }
    
    func createAndLoadInterstitial() -> GADInterstitial {
        var interstitial = GADInterstitial(adUnitID: "ca-app-pub-4200805572467087/5572345095")
        interstitial.delegate = self
        interstitial.load(GADRequest())
        return interstitial
    }
    
    // Tells the delegate the interstitial had been animated off the screen.
    func interstitialDidDismissScreen(_ ad: GADInterstitial) {
        interstitial = createAndLoadInterstitial()
    }
    
    /// Tells the delegate an ad request succeeded.
    func interstitialDidReceiveAd(_ ad: GADInterstitial) {
        print("interstitialDidReceiveAd")
    }
    
    /// Tells the delegate an ad request failed.
    func interstitial(_ ad: GADInterstitial, didFailToReceiveAdWithError error: GADRequestError) {
        print("interstitial:didFailToReceiveAdWithError: \(error.localizedDescription)")
    }
    
    /// Tells the delegate that an interstitial will be presented.
    func interstitialWillPresentScreen(_ ad: GADInterstitial) {
        print("interstitialWillPresentScreen")
    }
    
    /// Tells the delegate the interstitial is to be animated off the screen.
    func interstitialWillDismissScreen(_ ad: GADInterstitial) {
        print("interstitialWillDismissScreen")
    }
    
    
    /// Tells the delegate that a user click will open another app
    /// (such as the App Store), backgrounding the current app.
    func interstitialWillLeaveApplication(_ ad: GADInterstitial) {
        print("interstitialWillLeaveApplication")
    }
}
