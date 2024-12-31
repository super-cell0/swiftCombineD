//
//  BaseViewModel.swift
//  ps
//
//  Created by chen on 2024/11/14.
//

import Foundation
import Combine

enum PageStatus {
    case none
    case loading(PageRefreshLoadingStatus)
    case loaded(PageRefreshLoadedStatus)
    case error(Error)
}

enum PageRefreshLoadingStatus {
    case plain
    case refresh
    case loadMore
}

enum PageRefreshLoadedStatus {
    case empty
    case completion
    case completionWithNoMore
}

class BaseViewModel {
    
    let pageStatus = CurrentValueSubject<PageStatus, Never>(.none)
    let isLoading = CurrentValueSubject<Bool, Never>(false)
    let isSubmitting = CurrentValueSubject<Bool, Never>(false)
    let onMessage = PassthroughSubject<String, Never>()
    let onError = PassthroughSubject<Error, Never>()
    let onFinished = PassthroughSubject<Void, Never>()
    var subscriptions = Set<AnyCancellable>()
    
}
