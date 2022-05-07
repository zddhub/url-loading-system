//
//  AsyncApi.swift
//  UrlLoadingSystem
//
//  Created by Dongdong Zhang on 2022/5/8.
//

import Foundation
import Combine

class AsyncApi: LoadingMethod {
  var model = CurrentValueSubject<Profile?, Never>(nil)

  private var url: URL

  init(url: URL) {
    self.url = url
  }

  func load() {
    Task {
      do {
        let (data, response) = try await URLSession.shared.data(from: url)

        guard let httpResponse = response as? HTTPURLResponse,
              (200...299).contains(httpResponse.statusCode) else {
          print ("Service error \(String(describing: response))")
          return
        }

        if let mimeType = httpResponse.mimeType, mimeType == "application/json",
           let model = try? JSONDecoder().decode(Profile.self, from: data) {
          self.model.send(model)
        }
      } catch {
        print(error.localizedDescription)
      }
    }
  }
}
