//
//  FileManager+documentsDirectory.swift
//  BucketListHWS
//
//  Created by Sharan Thakur on 08/01/24.
//

import Foundation

extension FileManager {
    static var documentsDirectory: URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths.first!
    }
}
