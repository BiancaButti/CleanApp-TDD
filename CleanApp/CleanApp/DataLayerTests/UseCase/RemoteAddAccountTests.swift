//
//  DataLayerTests.swift
//  DataLayerTests
//
//  Created by Bianca on 29/08/23.
//

import XCTest
import Domain
import DataLayer

class RemoteAddAccountTests: XCTestCase {

    func test_add_should_call_httpClient_with_correct_url()  {
        let url = URL(string: "http://any-url.com")!
        let (sut, httpClientSpy) = makeSut(url: url)
        sut.add(addAccountModel: makeAddAccountModel()) { _ in}
        XCTAssertEqual(httpClientSpy.urls, [url])
    }
    
    func test_add_should_call_httpClient_with_correct_data()  {
        let (sut, httpClientSpy) = makeSut()
        let addAccountModel = makeAddAccountModel()
        sut.add(addAccountModel: addAccountModel) { _ in}
        XCTAssertEqual(httpClientSpy.data, addAccountModel.toData())
    }

    func test_add_should_complete_with_error_if_client_completes_with_error()  {
        let (sut, httpClientSpy) = makeSut()
        let exp = expectation(description: "waiting")
        sut.add(addAccountModel: makeAddAccountModel()) { result in
            
            switch result {
            case .success:
                XCTFail("Expected error receive \(result) instead")
            case .failure(let failure):
                XCTAssertEqual(failure, .unexpected)
            }
           
            exp.fulfill()
        }
        httpClientSpy.completeWithError(.noConnectivity)
        wait(for: [exp], timeout: 1)
    }
    
//    func test_add_should_complete_with_account_if_client_completes_with_data()  {
//        let (sut, httpClientSpy) = makeSut()
//        let exp = expectation(description: "waiting")
//        sut.add(addAccountModel: makeAddAccountModel()) { error in
//            XCTAssertEqual(error, .unexpected)
//            exp.fulfill()
//        }
//        httpClientSpy.completeWithError(.noConnectivity)
//        wait(for: [exp], timeout: 1)
//    }
}

extension RemoteAddAccountTests {
    
    func makeSut(url: URL = URL(string: "http://any-url.com")!) -> (sut: RemoteAddAccount, httpClientSpy: HttpClientSpy) {
        let httpClientSpy = HttpClientSpy()
        let sut = RemoteAddAccount(url: url, httpClient: httpClientSpy)
        return (sut, httpClientSpy)
    }
    
    func makeAddAccountModel() -> AddAccountModel {
        return AddAccountModel(name: "Bianca",
                               email: "bianca@mail.com",
                               password: "123456",
                               passwordConfirmation: "123456")
    }
    
    class HttpClientSpy: HttpPostClient {
        
        var urls = [URL]()
        var data: Data?
        var completion: ((Result<Data, HttpError>) -> Void)?
        
        func post(to url: URL, with data: Data?, completion: @escaping(Result<Data, HttpError>) -> Void) {
            self.urls.append(url)
            self.data = data
            self.completion = completion
        }
        
        func completeWithError(_ error: HttpError) {
            completion?(.failure(error))
        }
    }
    
}
