//
//  ProfileView.swift
//  UrlLoadingSystem
//
//  Created by Dongdong Zhang on 2022/5/7.
//

import SwiftUI

struct ProfileView: View {
  @ObservedObject var viewModel: ProfileViewModel
  @State private var loadingMethodType: LoadingMethodType = .asyncApi

  @Environment(\.colorScheme) var colorScheme

  init(url: String) {
    viewModel = ProfileViewModel(url: url)
  }

  var body: some View {
    VStack {
      profileCard
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

  private var shadowColor: Color {
    if colorScheme == .dark {
      return .secondary
    } else {
      return .primary.opacity(0.20)
    }
  }

  private var backgroundColor: Color {
    if colorScheme == .light {
      return Color(UIColor.systemBackground)
    } else {
      return Color(UIColor.secondarySystemBackground)
    }
  }

  private var profileCard: some View {
    HStack {
      Image(uiImage: viewModel.avatar)
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
          Link("\(viewModel.blog)", destination: viewModel.blogUrl!)
        }
      }
    }
    .frame(maxWidth: .infinity, alignment: .leading)
    .background(backgroundColor)
    .cornerRadius(8)
    .shadow(
      color: shadowColor,
      radius: 4,
      x: 0.0,
      y: 1.0
    )
    .padding()
  }

  private var controllerPanel: some View {
    Form {
      Text("Loading method")
      Picker("Method", selection: $loadingMethodType) {
        Text("Combine API").tag(LoadingMethodType.combineApi)
        Text("Async API").tag(LoadingMethodType.asyncApi)
        Text("Completion Handler API").tag(LoadingMethodType.completionHandlerApi)
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
      .preferredColorScheme(.light)

    ProfileView(url: "https://zddhub.com/assets/profile.json")
      .preferredColorScheme(.dark)
  }
}
