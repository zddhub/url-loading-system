//
//  LoadingMethodType.swift
//  UrlLoadingSystem
//
//  Created by Dongdong Zhang on 2022/5/8.
//

import Foundation

protocol LoadingMethodStrategy {
  func strategy(url: String) -> LoadingMethod
}

enum LoadingMethodType {
  case asyncApi
  case completionHandlerApi
  case combineApi
  case normalApi
}

extension LoadingMethodType: LoadingMethodStrategy {
  func strategy(url: String) -> LoadingMethod {
    switch self {
      case .asyncApi:
        return AsyncApi(url: URL(string: url)!)
      case .completionHandlerApi:
        return CompletionHandlerApi(url: URL(string: url)!)
      case .combineApi:
        return CombineApi(url: URL(string: url)!)
      case .normalApi:
        return NormalApi(url: URL(string: url)!)
    }
  }
}


