//
//  NormalApi.swift
//  UrlLoadingSystem
//
//  Created by Dongdong Zhang on 2022/5/8.
//

import Foundation
import Combine

class NormalApi: LoadingMethod {
  var model = CurrentValueSubject<Profile?, Never>(nil)

  private var url: URL

  init(url: URL) {
    self.url = url
  }

  func load() {
    let session = URLSession(configuration: URLSessionConfiguration.default)
    let task = session.dataTask(with: url)
    task.delegate = coordinator

    task.resume()
  }

  private lazy var coordinator: Coordinator = makeCoordinator()

  func makeCoordinator() -> Coordinator {
    Coordinator(self)
  }

  class Coordinator: NSObject, URLSessionDataDelegate {
    var loadingMethod: LoadingMethod
    private var data: Data? = nil

    init(_ loadingMethod: LoadingMethod) {
      self.loadingMethod = loadingMethod
    }

    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
      guard error == nil, let data = data, let model = try? JSONDecoder().decode(Profile.self, from: data) else {
        self.data = nil
        return
      }

      DispatchQueue.main.async {
        self.loadingMethod.model.send(model)
      }
      self.data = nil
    }

    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
      if self.data == nil {
        self.data = data
      } else {
        self.data?.append(data)
      }
    }
  }
}
