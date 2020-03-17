//
//  ViewController.swift
//  UZPlayerExample
//
//  Created by Nam Kennic on 3/17/20.
//  Copyright © 2020 Nam Kennic. All rights reserved.
//

import UIKit
import UZPlayer

class ViewController: UIViewController {

	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		
		// http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4
		guard let url = URL(string: "http://sample.vodobox.com/planete_interdite/planete_interdite_alternate.m3u8") else { return }
		let playerViewController = UZPlayerViewController()
		playerViewController.player.controlView.theme = UZTheme1()
		playerViewController.player.loadVideo(url: url)
		present(playerViewController, animated: true, completion: nil)
	}

}

