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
		
		UZPlayerSDK.initWith(enviroment: .development)
		UZPlayerSDK.showRestfulInfo = true
		
		askForURL()
	}
	/// "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4"
//    UserDefaults.standard.string(forKey: "last_url") ??
//    ?cm=eyJlbnRpdHlfaWQiOiI0ZTZkZmM5Ni1jMWExLTQ2NTktYWQyOC05NTZmN2I4MzQwZmYiLCJlbnRpdHlfc291cmNlIjoibGl2ZSIsImFwcF9pZCI6ImYxOWE0ZmQzYmFhMjQ0YmZhMThhODZjMDE0NDEzYWU4In0=
	func askForURL() {
		let prefilled = "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4"
		
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
        print("extIsTimeshift = \(videoItem.extIsTimeshift)")
        print("linkPlay = \(videoItem.linkPlay?.url.absoluteString ?? "")")
          print("extLinkPlay = \(videoItem.extLinkPlay?.url.absoluteString ?? "")")
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

