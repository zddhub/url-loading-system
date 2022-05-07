//
//  File.swift
//  UrlLoadingSystem
//
//  Created by Dongdong Zhang on 2022/5/7.
//

import Foundation
import Combine

protocol LoadingMethod {
  var model: CurrentValueSubject<Profile?, Never> { get }
  func load()
}
