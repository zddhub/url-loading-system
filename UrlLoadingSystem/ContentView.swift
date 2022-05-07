//
//  ContentView.swift
//  UrlLoadingSystem
//
//  Created by Dongdong Zhang on 2022/5/7.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
      ProfileView(url: "https://zddhub.com/assets/profile.json")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
