//
//  Result.swift
//  Hive
//
//  Created by Vipul Negi on 10/04/23.
//

import Foundation

typealias Pages = [Page]

struct Result: Codable {
    let query: Query?
}

struct Query: Codable {
    let pages: [Int: Page]?
}

struct Page: Codable {
    let pageid: Int?
    let title, extract: String?
    let thumbnail: Thumbnail?
}

struct Thumbnail: Codable {
    let source: String?
    let width, height: CGFloat?
}
