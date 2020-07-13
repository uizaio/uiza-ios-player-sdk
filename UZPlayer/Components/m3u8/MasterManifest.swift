//
//  MasterManifest.swift
//  UZPlayerExample
//
//  Created by Nam Nguyen on 7/1/20.
//  Copyright © 2020 Nam Kennic. All rights reserved.
//

import Foundation

open class MasterManifest {

    public init() {}
    
    /**
     * Parses the master manifest found at the URL and all the referenced media playlist manifests recursively.
     */
     open func parse(_ url: URL) -> MasterPlaylist {
        let reader = URLBufferedReader(uri: url)
        let masterPlaylist = MasterPlaylist()
        defer {
            reader.close()
        }
        while let line = reader.readLine() {
            if line.isEmpty {
                     // Skip empty lines
            } else if line.hasPrefix("#EXT") {
                // Tags
                if line.hasPrefix("#EXTM3U") {
                         // Ok Do nothing
                } else if line.hasPrefix("#EXT-X-VERSION"){
                    do {
                        let version = try line.replace("#EXT-X-VERSION:", replacement: "")
                            masterPlaylist.version = Int(version)
                        } catch {
                            DLog("Failed to parse VERSION on master playlist. Line = \(line)")
                    }
                } else if line.hasPrefix("#EXT-X-UZ-TIMESHIFT"){
                     do {
                        let timeshift = try line.replace("#EXT-X-UZ-TIMESHIFT:", replacement: "")
                         masterPlaylist.timeshift = timeshift
                     } catch {
                          DLog("Failed to parse TIMESHIFT on master playlist. Line = \(line)")
                     }
                } else {
                     // URI - must be
                 }
             }
        }
        return masterPlaylist
     }
}
