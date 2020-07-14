//
//  ViewController.swift
//  UZPlayerExample
//
//  Created by Nam Kennic on 3/17/20.
//  Copyright © 2020 Uiza. All rights reserved.
//

import UIKit
//import UZPlayer

class ViewController: UIViewController {
	
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		
		UZPlayerSDK.initWith(enviroment: .production)
		
		askForURL()
	}
/// UserDefaults.standard.string(forKey: "last_url") ?? "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4"
	func askForURL() {
//       let prefilled = "https://uz-test2live.uizacdn.net/865be795-836e-4f08-bbb6-34808374dced.smil/playlist.m3u8?cm=eyJlbnRpdHlfaWQiOiI4NjViZTc5NS04MzZlLTRmMDgtYmJiNi0zNDgwODM3NGRjZWQiLCJlbnRpdHlfc291cmNlIjoibGl2ZSIsImFwcF9pZCI6Ijk2NTU4YWI0YTZiMTRlOTA5ZWVkOThjMWNlNTBkNWVmIn0="
//		let prefilled = "https://1775190502.rsc.cdn77.org/live/56dfc759-9cac-40ac-8417-7928f4dd84ad/extras/master.m3u8?cm=eyJlbnRpdHlfaWQiOiI1NmRmYzc1OS05Y2FjLTQwYWMtODQxNy03OTI4ZjRkZDg0YWQiLCJlbnRpdHlfc291cmNlIjoibGl2ZSIsImFwcF9pZCI6ImQ2YjBmNDk1OTk2NzRlMWRiOWFlYWMwMzAxNzU2ODhiIn0="
		let prefilled = "https://bitdash-a.akamaihd.net/content/sintel/hls/playlist.m3u8"
        
		let alertController = UIAlertController(title: "", message: "Please enter videoURL", preferredStyle: .alert)
		alertController.addTextField { (textField) in
			textField.font = UIFont(name: "Avenir", size: 14)
			textField.keyboardType = .URL
			textField.clearButtonMode = .whileEditing
			textField.text = prefilled
            textField.frame.size.height = 153
		}
		alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak self] (action) in
			if let string = alertController.textFields?.first?.text, !string.isEmpty {
				UserDefaults.standard.set(string, forKey: "last_url")
				alertController.dismiss(animated: true, completion: nil)
				self?.presentFloatingPlayer(urlPath: string)
			}
			else {
				DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
					self?.askForURL()
				}
			}
		}))
		present(alertController, animated: true, completion: nil)
	}
	
	func presentFloatingPlayer(urlPath: String) {
		guard let url = URL(string: urlPath) else { return }
		let playerViewController = UZPlayerViewController()
        playerViewController.player.controlView.theme = UZTheme1()
        playerViewController.player.loadVideo(url: url)
        present(playerViewController, animated: true, completion: nil)
	}
	
	override open var prefersStatusBarHidden: Bool {
		return true
	}
	
	override open var shouldAutorotate: Bool {
		return false
	}
	
	override open var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation {
		return UIDevice.current.userInterfaceIdiom == .phone ? .portrait : UIApplication.shared.statusBarOrientation
	}
	
	override open var supportedInterfaceOrientations: UIInterfaceOrientationMask {
		return UIDevice.current.userInterfaceIdiom == .phone ? .portrait : .all
	}
	
}

