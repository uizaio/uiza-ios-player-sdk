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
		
		UZPlayerSDK.initWith(enviroment: .development)
		UZPlayerSDK.showRestfulInfo = true
		
		askForURL()
	}
	/// "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4"
	func askForURL() {
		let prefilled = 
        "https://1775190502.rsc.cdn77.org/live/4e6dfc96-c1a1-4659-ad28-956f7b8340ff/master.m3u8?cm=eyJlbnRpdHlfaWQiOiI0ZTZkZmM5Ni1jMWExLTQ2NTktYWQyOC05NTZmN2I4MzQwZmYiLCJlbnRpdHlfc291cmNlIjoibGl2ZSIsImFwcF9pZCI6ImYxOWE0ZmQzYmFhMjQ0YmZhMThhODZjMDE0NDEzYWU4In0="
		
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
		floatingPlayerViewController.present(with: UZVideoItem(name: nil, thumbnailURL: nil, linkPlay: UZVideoLinkPlay(definition: "", url: url), subtitleURLs: nil), playlist: nil).player.controlView.theme = UZTheme1()
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

