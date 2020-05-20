//
//  UZLiveServices.swift
//  UZPlayer
//
//  Created by Nam Nguyễn on 5/20/20.
//  Copyright © 2020 Nam Kennic. All rights reserved.
//

import UIKit

public class UZLiveServices: UZAPIConnector {
	static let viewAPIEndpoint = "https://development-api.uizadev.io/v1/analytics/live_viewers"
	
	public func loadViews(video: UZVideoItem, completionBlock: ((_ views: Int, _ error: Error?) -> Void)? = nil) {
		guard let url = URL(string: Self.viewAPIEndpoint) else { return }
		
		let params: Parameters = ["entity_id": video.entityId ?? "", "app_id" : video.appId ?? ""]
		get(url: url, params: params) { (data, error) in
			let views = data?.value(forKey: "views") as? Int
			DispatchQueue.main.async {
				completionBlock?(views ?? 0, error)
			}

		}
	}
	
}
