//
//  CombineApi.swift
//  UrlLoadingSystem
//
//  Created by Dongdong Zhang on 2022/5/7.
//

import Foundation
import Combine

class CombineApi: LoadingMethod {
  var model = CurrentValueSubject<Profile?, Never>(nil)

  private var cancellable: Set<AnyCancellable> = Set<AnyCancellable>()
  private var url: URL

  init(url: URL) {
    self.url = url
  }

  func load() {
    URLSession.shared
      .dataTaskPublisher(for: url)
      .tryMap { (data: Data, response: URLResponse) in
        return data
      }
      .decode(type: Profile.self, decoder: JSONDecoder())
      .receive(on: DispatchQueue.main)
      .sink {_ in } receiveValue: { model in
        self.model.send(model)
      }
      .store(in: &cancellable)
  }  
}
