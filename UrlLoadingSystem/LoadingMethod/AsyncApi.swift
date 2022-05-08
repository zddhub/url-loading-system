//
//  AsyncApi.swift
//  UrlLoadingSystem
//
//  Created by Dongdong Zhang on 2022/5/8.
//

import Foundation
import Combine

class AsyncApi<Model: Decodable>: LoadingMethod<Model> {
  override var model: CurrentValueSubject<Model?, Never> {
    storedModel
  }

  private var storedModel = CurrentValueSubject<Model?, Never>(nil)

  private var url: URL

  init(url: URL) {
    self.url = url
  }

  override func load() {
    Task {
      do {
        let (data, response) = try await URLSession.shared.data(from: url)

        guard let httpResponse = response as? HTTPURLResponse,
              (200...299).contains(httpResponse.statusCode) else {
          print ("Service error \(String(describing: response))")
          return
        }

        if let mimeType = httpResponse.mimeType, mimeType == "application/json",
           let model = try? JSONDecoder().decode(Model.self, from: data) {
          self.model.send(model)
        }
      } catch {
        print(error.localizedDescription)
      }
    }
  }
}
