import SwiftUI
import AppFeature

@main
struct Test_SCA_SwitchStoreApp: App {
  var body: some Scene {
    WindowGroup {
      AppFeatureView(store: .init(initialState: .init()) {
        AppFeature()
      })
    }
  }
}
