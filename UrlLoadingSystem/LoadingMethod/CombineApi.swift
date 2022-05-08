//
//  CombineApi.swift
//  UrlLoadingSystem
//
//  Created by Dongdong Zhang on 2022/5/7.
//

import Foundation
import Combine

class CombineApi<Model: Decodable>: LoadingMethod<Model> {
  override var model: CurrentValueSubject<Model?, Never> {
    storedModel
  }

  private var storedModel = CurrentValueSubject<Model?, Never>(nil)

  private var cancellable: Set<AnyCancellable> = Set<AnyCancellable>()
  private var url: URL

  init(url: URL) {
    self.url = url
  }

  override func load() {
    URLSession.shared
      .dataTaskPublisher(for: url)
      .tryMap { (data: Data, response: URLResponse) in
        return data
      }
      .decode(type: Model.self, decoder: JSONDecoder())
      .receive(on: DispatchQueue.main)
      .sink {_ in } receiveValue: { model in
        self.model.send(model)
      }
      .store(in: &cancellable)
  }  
}
