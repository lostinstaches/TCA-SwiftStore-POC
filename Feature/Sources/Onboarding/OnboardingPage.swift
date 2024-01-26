import Foundation

struct OnboardingPage: Equatable {
  let title: String?
  let text: String
}

extension Array where Element == OnboardingPage {
  static let live: [OnboardingPage] = [
    .init(title: "Welcome", text: "This is an example app that demonstrates a problem with SwitchStore."),
    .init(title: "Problem?", text: "More prominently you can see the problem when running in simulator!"),
    .init(title: "Details", text: "It takes forever to launch the app, and move from Onboarding feature to home feature."),
    .init(title: nil, text: "Press start, try it yourself."),
  ]
}
