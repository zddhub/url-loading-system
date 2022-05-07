//
//  ProfileViewModel.swift
//  UrlLoadingSystem
//
//  Created by Dongdong Zhang on 2022/5/7.
//

import Foundation
import Combine

class ProfileViewModel: ObservableObject {
  var url: String
  var name: String {
    model?.name ?? ""
  }
  var email: String {
    model?.email ?? ""
  }
  var blog: String {
    model?.blog ?? ""
  }

  @Published private var model: Profile?
  private var cancellable: Set<AnyCancellable> = Set<AnyCancellable>()

  init(url: String) {
    self.url = url
  }

  func loadData() {
    URLSession.shared
      .dataTaskPublisher(for: URL(string: url)!)
      .tryMap { (data: Data, response: URLResponse) in
        return data
      }
      .decode(type: Profile.self, decoder: JSONDecoder())
      .receive(on: DispatchQueue.main)
      .sink {_ in } receiveValue: { model in
        self.model = model
      }
      .store(in: &cancellable)

  }
}
