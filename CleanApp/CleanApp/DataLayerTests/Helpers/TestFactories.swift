//
//  TestFactories.swift
//  DataLayerTests
//
//  Created by Bianca on 30/08/23.
//

import Foundation

func makeInvalidData() -> Data {
    return Data("invalid_data".utf8)
}

func makeUrl() -> URL {
    return URL(string: "http://any-url.com")!
}
