//
//  ViewController.swift
//  UZPlayerExample
//
//  Created by Nam Kennic on 3/17/20.
//  Copyright © 2020 Uiza. All rights reserved.
//

import UIKit
import UZPlayer

class ViewController: UIViewController {
	
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		
		UZPlayerSDK.initWith(enviroment: .production)
		
		askForURL()
	}
/// UserDefaults.standard.string(forKey: "last_url") ?? "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4"
	func askForURL() {
       let prefilled = "https://uz-test2live.uizacdn.net/865be795-836e-4f08-bbb6-34808374dced.smil/playlist.m3u8?cm=eyJlbnRpdHlfaWQiOiI4NjViZTc5NS04MzZlLTRmMDgtYmJiNi0zNDgwODM3NGRjZWQiLCJlbnRpdHlfc291cmNlIjoibGl2ZSIsImFwcF9pZCI6Ijk2NTU4YWI0YTZiMTRlOTA5ZWVkOThjMWNlNTBkNWVmIn0="
//		let prefilled = "https://vn-t11em6innm.uizacdn.net/live/4615fd4c-5beb-462d-9f72-a1bffd20e4c7/master.m3u8?cm=eyJlbnRpdHlfaWQiOiI0NjE1ZmQ0Yy01YmViLTQ2MmQtOWY3Mi1hMWJmZmQyMGU0YzciLCJlbnRpdHlfc291cmNlIjoibGl2ZSIsImFwcF9pZCI6ImU2YzY1ZThiOTc4NzQ4MDlhYzY2YWEwZWEwODEwMzRjIn0"
//		let prefilled = "https://bitdash-a.akamaihd.net/content/sintel/hls/playlist.m3u8"
        
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
		let floatingPlayerViewController = UZFloatingPlayerViewController()
        let videoItem = UZVideoItem(name: nil, thumbnailURL: nil, linkPlay: UZVideoLinkPlay(definition: "", url: url), subtitleURLs: nil)
		floatingPlayerViewController.present(with: videoItem, playlist: nil).player.controlView.theme = UZTheme1()
		floatingPlayerViewController.onDismiss = { [weak self] in
			self?.askForURL()
		}
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

