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
		
		guard let url = URL(string: "https://1775190502.rsc.cdn77.org/live/b938c0a6-e9bc-4b25-9e66-dbf81d755c25/master.m3u8?cm=eyJlbnRpdHlfaWQiOiJiOTM4YzBhNi1lOWJjLTRiMjUtOWU2Ni1kYmY4MWQ3NTVjMjUiLCJlbnRpdHlfc291cmNlIjoibGl2ZSIsImFwcF9pZCI6ImI5NjNiNDY1YzM0ZTRmZmI5YTcxOTIyNDQyZWUwZGNhIn0=") else { return }
		
		player.controlView.theme = UZTheme1()
		player.loadVideo(UZVideoItem(name: nil, thumbnailURL: nil, linkPlay: UZVideoLinkPlay(definition: "", url: url), subtitleURLs: nil))
	}
	
//	func presentFloatingPlayer() {
//		guard let url = URL(string: "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4") else { return }
//		let floatingPlayerViewController = UZFloatingPlayerViewController()
//		floatingPlayerViewController.present(with: UZVideoItem(name: nil, thumbnailURL: nil, isLive: false, linkPlay: UZVideoLinkPlay(definition: "", url: url), subtitleURLs: nil), playlist: nil).player.controlView.theme = UZTheme2()
//		present(floatingPlayerViewController, animated: true, completion: nil)
//	}
	
}

