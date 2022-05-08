//
//  NormalApi.swift
//  UrlLoadingSystem
//
//  Created by Dongdong Zhang on 2022/5/8.
//

import Foundation
import Combine

class NormalApi<Model: Decodable>: LoadingMethod<Model> {
  override var model: CurrentValueSubject<Model?, Never> {
    storedModel
  }

  private var storedModel = CurrentValueSubject<Model?, Never>(nil)

  private var url: URL

  init(url: URL) {
    self.url = url
  }

  override func load() {
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
    var loadingMethod: LoadingMethod<Model>
    private var data: Data? = nil

    init(_ loadingMethod: LoadingMethod<Model>) {
      self.loadingMethod = loadingMethod
    }

    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
      guard error == nil, let data = data, let model = try? JSONDecoder().decode(Model.self, from: data) else {
        self.data = nil
        return
      }

      self.loadingMethod.model.send(model)
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
