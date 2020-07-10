//
//  MediaSegment.swift
//  UZPlayerExample
//
//  Created by Nam Nguyen on 7/10/20.
//  Copyright © 2020 Nam Kennic. All rights reserved.
//
import Foundation

open class MediaSegment {
    var mediaPlaylist: MediaPlaylist?
    open var duration: Float?
    open var sequence: Int = 0
    open var subrangeLength: Int?
    open var subrangeStart: Int?
    open var title: String?
    open var discontinuity: Bool = false
    open var path: String?

    public init() {

    }

    open func getMediaPlaylist() -> MediaPlaylist? {
        return self.mediaPlaylist
    }
}
