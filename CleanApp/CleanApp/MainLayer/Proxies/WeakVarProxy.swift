//
//  WeakVarProxy.swift
//  MainLayer
//
//  Created by Bianca on 23/11/23.
//

import Foundation
import PresentationLayer

final class WeakVarProxy<T: AnyObject> {
    private weak var instance: T?
    
    init(_ instance: T) {
        self.instance = instance
    }
}

extension WeakVarProxy: AlertView where T: AlertView {
    func showMessage(viewModel: PresentationLayer.AlertViewModel) {
        instance?.showMessage(viewModel: viewModel)
    }
    
}

extension WeakVarProxy: LoadingView where T: LoadingView {
    func display(viewModel: PresentationLayer.LoadingViewModel) {
        instance?.display(viewModel: viewModel)
    }
}
