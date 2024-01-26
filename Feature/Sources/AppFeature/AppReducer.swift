import ComposableArchitecture
import Onboarding
import Home
import Foundation

@Reducer
public struct AppFeature {
  public enum State: Equatable {
    case onboarding(OnboardingFeature.State)
    case home(HomeFeature.State)
    
    public init() {
        self = .onboarding(OnboardingFeature.State())
    }
  }

  public enum Action {
    case onboarding(OnboardingFeature.Action)
    case home(HomeFeature.Action)
  }

  public init() {}

  public var body: some ReducerOf<Self> {
    Reduce { state, action in
      switch action {
      case .onboarding(.delegate(.dissmissOnboarding)):
        state = .home(HomeFeature.State())
        return .none

      case .onboarding:
        return .none

      case .home:
        return .none
      }
    }
    .ifCaseLet(\.onboarding, action: \.onboarding) {
      OnboardingFeature()
    }
    .ifCaseLet(\.home, action: \.home) {
      HomeFeature()
    }
  }
}
