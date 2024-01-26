import SwiftUI
import Home
import Onboarding
import ComposableArchitecture

public struct AppFeatureView: View {
  let store: StoreOf<AppFeature>

  public init(store: StoreOf<AppFeature>) {
    self.store = store
  }

  public var body: some View {
    SwitchStore(self.store) { state in
      switch state {
      case .onboarding:
        CaseLet(\AppFeature.State.onboarding, action: AppFeature.Action.onboarding) { store in
          NavigationStack {
            OnboardingView(store: store)
          }
        }
      case .home:
        // All problem with lagging are solved if you ignore the store we pass form here
        // and just initiate a new store HomeView(store: .init(ini...)
        // Of course then we loose the ability for the app feature to listen the events that happens
        // to kids.
        CaseLet(\AppFeature.State.home, action: AppFeature.Action.home) { store in
          NavigationStack {
            HomeView(store: store)
          }
        }
      }
    }
  }
}
