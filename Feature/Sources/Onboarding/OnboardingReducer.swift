import Foundation
import ComposableArchitecture

public struct OnboardingFeature: Reducer {
  public struct State: Equatable {
    let onboardingPages: [OnboardingPage] = .live

    public init() {}
  }

  public enum Action: Equatable {
    case didTapCloseButton
    case onboardingPage(OnboardingPageView.Action)
    case handleDismissOnboarding
    case delegate(Delegate)

    public enum Delegate {
      case dissmissOnboarding
    }
  }

  public init() {}

  public var body: some ReducerOf<Self> {
    Reduce { _, action in
      switch action {
      case .onboardingPage(.didTapStartButton):
        return .send(.handleDismissOnboarding)

      case .didTapCloseButton:
        return .send(.handleDismissOnboarding)

      case .handleDismissOnboarding:
        return .send(.delegate(.dissmissOnboarding))

      case .delegate:
        return .none
      }
    }
  }
}
