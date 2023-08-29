//
//  HttpPostClient.swift
//  DataLayer
//
//  Created by Bianca on 29/08/23.
//

import Foundation

public protocol HttpPostClient {
    func post(to url: URL, with data: Data?)
}
