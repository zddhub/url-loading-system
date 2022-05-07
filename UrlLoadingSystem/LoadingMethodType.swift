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
  case combineApi
}

extension LoadingMethodType: LoadingMethodStrategy {
  func strategy(url: String) -> LoadingMethod {
    switch self {
      case .asyncApi:
        return AsyncApi(url: URL(string: url)!)
      case .combineApi:
        return CombineApi(url: URL(string: url)!)
    }
  }
}


