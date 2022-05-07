//
//  completionHandler.swift
//  UrlLoadingSystem
//
//  Created by Dongdong Zhang on 2022/5/8.
//

import Foundation
import Combine

class CompletionHandlerApi: LoadingMethod {
  var model = CurrentValueSubject<Profile?, Never>(nil)
  private var url: URL

  init(url: URL) {
    self.url = url
  }

  func load() {
    let task = URLSession.shared.dataTask(with: url) { data, response, error in
      if let error = error {
        print("Client error \(error)")
        return
      }

      guard let httpResponse = response as? HTTPURLResponse,
            (200...299).contains(httpResponse.statusCode) else {
        print ("Service error \(String(describing: response))")
        return
      }

      if let mimeType = httpResponse.mimeType, mimeType == "application/json",
         let data = data,
         let model = try? JSONDecoder().decode(Profile.self, from: data) {
         self.model.send(model)
      }
    }
    task.resume()
  }


}
