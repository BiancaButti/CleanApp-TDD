//
//  AlamofireAdapterTests.swift
//  DataLayerTests
//
//  Created by Bianca on 30/08/23.
//

import XCTest
import Alamofire

class AlamofireAdapter {
    private let session: Session
    
    init(session: Session = .default) {
        self.session = session
    }
    
    func post(to url: URL) {
        session.request(url).resume()
    }
}

class AlamofireAdapterTests: XCTestCase {
    func test_() {
        let url = makeUrl()
        let configuration = URLSessionConfiguration.default
        configuration.protocolClasses = [UrlProtocolStub.self]
        let session = Session(configuration: configuration)
        let sut = AlamofireAdapter(session: session)
        sut.post(to: url)
        XCTAssertEqual(url, UrlProtocolStub.url)
    }

}

class UrlProtocolStub: URLProtocol {
    
    static var url: URL?
    
    override open class func canInit(with request: URLRequest) -> Bool {
        return true
    }

    override open class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }

    override open func startLoading() {
        UrlProtocolStub.url = request.url
    }
    
    override open func stopLoading() {
        
    }
}
