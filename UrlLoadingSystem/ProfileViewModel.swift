//
//  ProfileViewModel.swift
//  UrlLoadingSystem
//
//  Created by Dongdong Zhang on 2022/5/7.
//

import Foundation
import Combine
import UIKit

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

  var avatar: UIImage {
    guard let _ = avatarData else {
      return UIImage.init(systemName: "person.crop.circle")!
    }
    return UIImage(data: avatarData!) ?? UIImage.init(systemName: "person.crop.circle")!
  }

  @Published private var avatarData: Data?

  @Published var isFetching = false

  @Published private var model: Profile? {
    didSet {
      if oldValue?.avatar != model?.avatar {
        loadAvatar()
      }
    }
  }
  private var cancellable: Set<AnyCancellable> = Set<AnyCancellable>()

  init(url: String) {
    self.url = url
  }

  func loadData(_ type: LoadingMethodType) {
    self.isFetching = true
    self.model = nil
    let loadingMethod = type.strategy(url: url)
    loadingMethod.load()
    loadingMethod.model.sink(receiveValue: { model in
      DispatchQueue.main.async {
        self.model = model
        self.isFetching = false
      }
    })
    .store(in: &cancellable)
  }

  private func loadAvatar() {
    guard let avatarUrl = URL(string: model?.avatar ?? "") else {
      return
    }

    self.avatarData = nil

    let request = URLRequest(url: avatarUrl, cachePolicy: URLRequest.CachePolicy.reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 5.0)

    URLSession.shared
      .dataTaskPublisher(for: request)
      .tryMap { (data: Data, response: URLResponse) in
        return data
      }
      .receive(on: DispatchQueue.main)
      .sink { _ in
      } receiveValue: { data in
        self.avatarData = data
      }
      .store(in: &cancellable)
  }
}
