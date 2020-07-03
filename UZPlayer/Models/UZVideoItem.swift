//
//  UZVideoItem.swift
//  UizaSDK
//
//  Created by Nam Kennic on 7/28/16.
//  Copyright © 2016 Nam Kennic. All rights reserved.
//

import UIKit
import AVFoundation

/**
Link Play info
*/
public struct UZVideoLinkPlay {
	/// Definition (etc 480, 720, 1080)
	public var definition: String
	/// Linkplay URL
	public var url: URL
	
	/// An instance of NSDictionary that contains keys for specifying options for the initialization of the AVURLAsset. See AVURLAssetPreferPreciseDurationAndTimingKey and AVURLAssetReferenceRestrictionsKey above.
	public var options: [String: AnyHashable]?
	
	/// `AVURLAsset` of this linkPlay
    public var avURLAsset: AVURLAsset {
		return AVURLAsset(url: url, options: options)
    }
	
	/**
	Video recource item with defination name and specifying options
	
	- parameter url:        video url
	- parameter definition: url deifination
	- parameter options:    specifying options for the initialization of the AVURLAsset
	
	you can add http-header or other options which mentions in https://developer.apple.com/reference/avfoundation/avurlasset/initialization_options
	
	to add http-header init options like this
	```
	let header = ["User-Agent":"UZPlayer"]
	let definiton.options = ["AVURLAssetHTTPHeaderFieldsKey":header]
	```
	*/
	public init(definition: String, url: URL, options: [String: AnyHashable]? = nil) {
		self.url        = url
		self.definition = definition
		self.options    = options
	}
}

extension UZVideoLinkPlay: Equatable {
	
	public static func == (lhs: UZVideoLinkPlay, rhs: UZVideoLinkPlay) -> Bool {
		return lhs.url == rhs.url
	}
	
}

/**
Class chứa các thông tin về video item
*/
public struct UZVideoItem {
	public var name: String?
	public var thumbnailURL: URL?
    public var extLinkPlay: UZVideoLinkPlay?
    public var extIsTimeshift: Bool = false
    public var timeshiftSupport: Bool = false
    
	public var linkPlay: UZVideoLinkPlay? {
		didSet {
			guard let url = linkPlay?.url else { return }
            if url.absoluteString.contains(".m3u8") {
                let manifest = MasterManifest().parse(url)
                if let timeshift = manifest.timeshift {
                    timeshiftSupport = true
                    isLive = true
                    if timeshift.hasPrefix("extras/") {
                        print("start extras/")
                        do{
                            let plName = try timeshift.replace("extras/", replacement: "")
                            let extLink = try url.absoluteString.replace(plName, replacement: timeshift)
                            guard let extUrl = URL(string: extLink) else { return }
                            extLinkPlay = UZVideoLinkPlay(definition: linkPlay?.definition ?? "", url: extUrl)
                            extIsTimeshift = true
                        } catch {
                            print("not parse extras/ in timeshift link")
                        }
                    } else {
                        print("not start extras/")
                        do {
                           let extLink = try url.absoluteString.replace("extras/\(timeshift)", replacement:timeshift)
                           guard let extUrl = URL(string: extLink) else { return }
                           extLinkPlay = UZVideoLinkPlay(definition: linkPlay?.definition ?? "", url: extUrl)
                            extIsTimeshift = false
                       } catch {
                           print("not parse extras/ in timeshift link")
                       }
                    }
                    isTimeshiftOn = !extIsTimeshift
                } else {
                    timeshiftSupport = false
                }
            }
			guard let cmParam = url.params()["cm"] as? String else { return }
			guard let dictionary = cmParam.base64Decoded.toDictionary() else { return }
			
			appId = dictionary["app_id"] as? String
			entityId = dictionary["entity_id"] as? String
			entitySource = dictionary["entity_source"] as? String
			isLive = entitySource?.lowercased() == "live"
		}
	}
	public var subtitleURLs: [URL]?
	
    public var isTimeshiftOn: Bool = false
    
	public fileprivate(set) var appId: String?
	public fileprivate(set) var entityId: String?
	public fileprivate(set) var entitySource: String?
	public fileprivate(set) var isLive: Bool = false
	
	/** Object description */
	public var description: String {
		return "[\(name ?? "")] url:\(linkPlay?.url.absoluteString ?? "")"
	}
	
	public init(name: String?, thumbnailURL: URL?, linkPlay: UZVideoLinkPlay, subtitleURLs: [URL]? = nil) {
		self.name = name
		self.thumbnailURL = thumbnailURL
		self.subtitleURLs = subtitleURLs
		defer {
			self.linkPlay = linkPlay
		}
	}
	
}

extension UZVideoItem: Equatable {
	
	public static func == (lhs: UZVideoItem, rhs: UZVideoItem) -> Bool {
		return lhs.linkPlay == rhs.linkPlay
	}
	
}
