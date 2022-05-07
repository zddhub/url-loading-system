//
//  ProfileView.swift
//  UrlLoadingSystem
//
//  Created by Dongdong Zhang on 2022/5/7.
//

import SwiftUI

struct ProfileView: View {
  var viewModel: ProfileViewModel

  var body: some View {
    HStack {
      Image(uiImage: UIImage.init(systemName: "circle")!)
        .resizable()
        .frame(width: 120, height: 120)
        .cornerRadius(80)
        .background(.white)
        .clipShape(Circle())
        .padding(8)

      VStack(alignment: .leading) {
        Text(viewModel.name)
          .font(.title)

        HStack {
          Image(systemName: "mail")
          Text("\(viewModel.email)")
        }

        HStack {
          Image(systemName: "link")
          Text("\(viewModel.blog)")
        }
      }
    }
    .frame(maxWidth: .infinity, alignment: .leading)
    .background(Color(UIColor.systemGroupedBackground).edgesIgnoringSafeArea(.all))
    .cornerRadius(8)
    .padding()
  }
}

struct ProfileView_Previews: PreviewProvider {
  static var previews: some View {
    ProfileView(viewModel: ProfileViewModel(
      name: "zddhub",
      email: "zddhub@gmail.com",
      blog: "www.zddhub.com")
    )
  }
}
