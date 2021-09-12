//
//  NasaProjectTests.swift
//  NasaProjectTests
//
//  Created by Simge Çakır on 7.09.2021.
//

import XCTest
@testable import NasaProject

class NasaProjectTests: XCTestCase {

    var view: MockViewController!
    var viewModel: BaseViewModel!
    var service: MockPhotoService!

    override func setUp() {
        super.setUp()
        view = MockViewController()
        service = MockPhotoService()
        viewModel = BaseViewModel(service: service)
    }

    override func tearDown() {
        view = nil
        viewModel = nil
        service = nil
    }
    
    func test_fetchPhotos(){
        XCTAssertEqual(viewModel.numberOfItems, 0)
        viewModel.load()
        XCTAssertEqual(viewModel.numberOfItems, 25)
        XCTAssertEqual(viewModel.photo(indexPath: 1)?.camera.name, "FHAZ")
    }
    
}
