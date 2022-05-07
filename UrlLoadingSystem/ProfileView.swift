//
//  ProfileView.swift
//  UrlLoadingSystem
//
//  Created by Dongdong Zhang on 2022/5/7.
//

import SwiftUI

struct ProfileView: View {
  @ObservedObject var viewModel: ProfileViewModel

  init(url: String) {
    viewModel = ProfileViewModel(url: url)
  }

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
    .shadow(
      color: .primary.opacity(0.20),
      radius: 2,
      x: 0.0,
      y: 1.0
    )
    .padding()
    .onAppear {
      viewModel.loadData()
    }
  }
}

struct ProfileView_Previews: PreviewProvider {
  static var previews: some View {
    ProfileView(url: "https://zddhub.com/assets/profile.json")
  }
}
