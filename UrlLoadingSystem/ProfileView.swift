//
//  ProfileView.swift
//  UrlLoadingSystem
//
//  Created by Dongdong Zhang on 2022/5/7.
//

import SwiftUI

struct ProfileView: View {
  @ObservedObject var viewModel: ProfileViewModel
  @State private var loadingMethodType: LoadingMethodType = .normalApi

  init(url: String) {
    viewModel = ProfileViewModel(url: url)
  }

  var body: some View {
    VStack {
      profile
      controllerPanel
    }
    .background(Color(UIColor.systemGroupedBackground).edgesIgnoringSafeArea(.all))
    .onAppear {
      viewModel.loadData(loadingMethodType)
    }
    .onChange(of: loadingMethodType) { newValue in
      viewModel.loadData(newValue)
    }
  }

  private var profile: some View {
    Group {
      if !viewModel.isFetching {
        profileCard
      } else {
        Text("loading ...")
          .padding()
      }
    }
  }

  private var profileCard: some View {
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
    .background(.background)
    .cornerRadius(8)
    .shadow(
      color: .primary.opacity(0.20),
      radius: 2,
      x: 0.0,
      y: 1.0
    )
    .padding()
  }

  private var controllerPanel: some View {
    Form {
      Text("Loading method")
      Picker("Method", selection: $loadingMethodType) {
        Text("Async API").tag(LoadingMethodType.asyncApi)
        Text("Completion Handler API").tag(LoadingMethodType.completionHandlerApi)
        Text("Combine API").tag(LoadingMethodType.combineApi)
        Text("Normal API").tag(LoadingMethodType.normalApi)
      }
      .pickerStyle(.wheel)
    }
    .padding(0)
  }
}

struct ProfileView_Previews: PreviewProvider {
  static var previews: some View {
    ProfileView(url: "https://zddhub.com/assets/profile.json")
  }
}
