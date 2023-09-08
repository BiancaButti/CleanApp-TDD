//
//  LoadingView.swift
//  PresentationLayer
//
//  Created by Bianca on 01/09/23.
//

import Foundation

public protocol LoadingView {
    func display(viewModel: LoadingViewModel)
}

public struct LoadingViewModel: Equatable {
    public var isLoading: Bool
    
    public init(isLoading: Bool) {
        self.isLoading = isLoading
    }
}
