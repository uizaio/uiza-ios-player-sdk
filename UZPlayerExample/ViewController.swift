//
//  ViewController.swift
//  UZPlayerExample
//
//  Created by Nam Kennic on 3/17/20.
//  Copyright © 2020 Uiza. All rights reserved.
//

import UIKit
//import UZPlayer

class ViewController: UZPlayerViewController {
	
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		
		guard let url = URL(string: "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4") else { return }
		
		player.controlView.theme = UZTheme1()
		player.loadVideo(url: url)
	}
	
//	func presentFloatingPlayer() {
//		guard let url = URL(string: "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4") else { return }
//		let floatingPlayerViewController = UZFloatingPlayerViewController()
//		floatingPlayerViewController.present(with: UZVideoItem(name: nil, thumbnailURL: nil, isLive: false, linkPlay: UZVideoLinkPlay(definition: "", url: url), subtitleURLs: nil), playlist: nil).player.controlView.theme = UZTheme2()
//		present(floatingPlayerViewController, animated: true, completion: nil)
//	}
	
}

