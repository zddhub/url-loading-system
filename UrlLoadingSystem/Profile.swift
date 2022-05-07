//
//  Profile.swift
//  UrlLoadingSystem
//
//  Created by Dongdong Zhang on 2022/5/7.
//

import Foundation

struct Profile: Decodable {
  let name: String
  let avatar: String
  let email: String
  let blog: String
}
