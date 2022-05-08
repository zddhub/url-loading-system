//
//  File.swift
//  UrlLoadingSystem
//
//  Created by Dongdong Zhang on 2022/5/7.
//

import Foundation
import Combine

protocol LoadingMethodProtocol {
  associatedtype Output: Decodable
  var model: CurrentValueSubject<Output?, Never> { get }
  func load()
}

class LoadingMethod<Model: Decodable>: LoadingMethodProtocol {
  var model: CurrentValueSubject<Model?, Never> {
    CurrentValueSubject<Model?, Never>(nil)
  }

  func load() {
    fatalError("Never run here")
  }

}
