//
//  LoadingViewSpy.swift
//  PresentationLayerTests
//
//  Created by Bianca on 08/09/23.
//

import Foundation
import PresentationLayer

class LoadingViewSpy: LoadingView {
    var emit: ((LoadingViewModel) -> Void)?
    
    func observe(completion: @escaping (LoadingViewModel) -> Void) {
        self.emit = completion
    }
    
    func display(viewModel: LoadingViewModel) {
        self.emit?(viewModel)
    }
}
