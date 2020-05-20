//
//  UZLogger.swift
//  UizaSDK
//
//  Created by Nam Kennic on 3/23/18.
//  Copyright © 2018 Nam Kennic. All rights reserved.
//

import UIKit

/**
Class for logging
*/
open class UZLogger: UZAPIConnector {
	static let logAPIEndpoint = "https://tracking-dev.uizadev.io/v1/events"
	
	public var currentVideo: UZVideoItem? = nil
	public var currentLinkPlay: URL? = nil {
		didSet {
			appId = nil
			entityId = nil
			entitySource = nil
			
			guard let url = currentLinkPlay else { return }
			guard let cmParam = url.params()["cm"] as? String else { return }
			guard let dictionary = cmParam.base64Decoded.toDictionary() else { return }
			
			appId = dictionary["app_id"] as? String
			entityId = dictionary["entity_id"] as? String
			entitySource = dictionary["entity_source"] as? String
		}
	}
	
	public var entityId: String? = nil
	public var entitySource: String? = nil
	public var appId: String? = nil
	
	/// Singleton instance
	static public let shared = UZLogger()
	private override init() {}
	
	open func log(event: String, params: Parameters? = nil) {
		let logParams: Parameters = ["entity_id": entityId ?? "",
									   "entity_source" : entitySource ?? "",
									   "app_id" : appId ?? ""]
		
		let modelId: String = UIDevice.current.hardwareModel()
		let modelName: String = UIDevice.current.hardwareName()
		let macAddress: String = UIDevice.current.identifierForVendor?.uuidString ?? ""
		let timestamp: String = "" // Date().toString(format: .isoDateTimeMilliSec)
		// Date().toString(format: .custom("yyyy-MM-dd'T'HH:mm:ss.SSSZ")) // 2018-03-15T14:19:04.637Z
		
//		print("timestamp: \(timestamp)")
		let defaultParams: Parameters! = ["event_type": event,
										  "timestamp": timestamp,
										  "modelId": modelId,
										  "modelName": modelName,
										  "macAddress": macAddress,
										  "uuid": macAddress,
										  "player_version": PLAYER_VERSION]
		
		var finalParams: Parameters! = defaultParams
		finalParams.appendFrom(logParams)
		
		if params != nil {
			finalParams.appendFrom(params!)
		}
		
		guard let url = URL(string: Self.logAPIEndpoint) else { return }
		post(url: url, params: finalParams)
	}
	
	open func logLiveCCU(streamName: String, host: String) {
	}
	
	open func trackingCategory(entityId: String, category: String) {
	}
	
}

