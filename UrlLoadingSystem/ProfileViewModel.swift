//
//  ProfileViewModel.swift
//  UrlLoadingSystem
//
//  Created by Dongdong Zhang on 2022/5/7.
//

import Foundation
import Combine

class ProfileViewModel: ObservableObject {
  private var url: String
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
  private lazy var loadingMethod: LoadingMethod = AsyncApi(url: URL(string: url)!)

  init(url: String) {
    self.url = url

    loadingMethod.model.sink(receiveValue: { model in
      self.model = model
    })
    .store(in: &cancellable)
  }

  func loadData() {
    loadingMethod.load()
  }
}
