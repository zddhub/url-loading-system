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

  func loadData(_ type: LoadingMethodType) {
    self.model = nil
    let loadingMethod = type.strategy(url: url)
    loadingMethod.load()
    loadingMethod.model.sink(receiveValue: { model in
      DispatchQueue.main.async {
        self.model = model
      }
    })
    .store(in: &cancellable)
  }
}
