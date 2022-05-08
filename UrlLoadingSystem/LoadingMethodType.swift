//
//  LoadingMethodType.swift
//  UrlLoadingSystem
//
//  Created by Dongdong Zhang on 2022/5/8.
//

import Foundation

protocol LoadingMethodStrategy {
  associatedtype Model: Decodable
  func strategy(url: String) -> LoadingMethod<Model>
}

enum LoadingMethodType {
  case asyncApi
  case completionHandlerApi
  case combineApi
  case normalApi
}

extension LoadingMethodType: LoadingMethodStrategy {
  typealias Model = Profile

  func strategy(url: String) -> LoadingMethod<Profile> {
    switch self {
      case .asyncApi:
        return AsyncApi<Profile>(url: URL(string: url)!)
      case .completionHandlerApi:
        return CompletionHandlerApi<Profile>(url: URL(string: url)!)
      case .combineApi:
        return CombineApi<Profile>(url: URL(string: url)!)
      case .normalApi:
        return NormalApi<Profile>(url: URL(string: url)!)
    }
  }
}


