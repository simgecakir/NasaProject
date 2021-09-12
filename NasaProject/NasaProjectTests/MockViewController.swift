//
//  MockViewController.swift
//  NasaProjectTests
//
//  Created by Simge Çakır on 12.09.2021.
//

import Foundation
@testable import NasaProject
@testable import NetworkAPI

final class MockViewController: BaseViewModelDelegate{
    
    var isInvokedShowLoading = false
    
    func reloadData() {
    }
    
    func loadingView(isShown: Bool) {
        isInvokedShowLoading = isShown ? true : false
    }
    
    func showPhotoDetail(photo: Photo) {
    }
}
