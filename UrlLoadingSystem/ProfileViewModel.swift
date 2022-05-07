//
//  ProfileViewModel.swift
//  UrlLoadingSystem
//
//  Created by Dongdong Zhang on 2022/5/7.
//

import Foundation

class ProfileViewModel {
  var name: String
  var email: String
  var blog: String

  init(name: String, email: String, blog: String) {
    self.name = name
    self.email = email
    self.blog = blog
  }
}
