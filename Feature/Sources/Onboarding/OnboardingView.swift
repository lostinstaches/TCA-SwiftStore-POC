import SwiftUI
import ComposableArchitecture

public struct OnboardingView: View {
  let store: StoreOf<OnboardingFeature>
  
  public init(store: StoreOf<OnboardingFeature>) {
    self.store = store
  }
  
  public var body: some View {
    WithViewStore(self.store, observe: { $0 }) { viewStore in
      ZStack {
        Color.white
          .ignoresSafeArea()
        
        VStack(spacing: 0) {
          Spacer()
          
          HStack(spacing: 0)
          {
            Spacer()
            
            Button(action: { viewStore.send(.didTapCloseButton) })
            {
              Text("Close")
                .frame(width: 50, height: 50)
            }
            .transaction { $0.disablesAnimations = true }
            
            Spacer()
          }
          
          TabView {
            ForEach(viewStore.onboardingPages.indices, id: \.self) { index in
              OnboardingPageView(self.store.scope(
                state: { OnboardingPageView.VM(onboardingPage: $0.onboardingPages[index], isLastPage: index == $0.onboardingPages.count - 1) },
                action: OnboardingFeature.Action.onboardingPage
              ))
            }
          }
          .tabViewStyle(.page(indexDisplayMode: .always))
        }
      }
      .ignoresSafeArea(.container, edges: .bottom)
    }
  }
}

public struct OnboardingPageView: View {
  public struct VM: Equatable {
    let onboardingPage: OnboardingPage
    let isLastPage: Bool
  }
  
  public enum Action: Equatable {
    case didTapStartButton
  }
  
  private let store: Store<VM, Action>
  
  init(_ store: Store<VM, Action>) {
    self.store = store
  }
  
  public var body: some View {
    WithViewStore(self.store, observe: { $0 }) { viewStore in
      ZStack {
        Color.green.opacity(0.8)
        
        VStack(spacing: 0) {
          Spacer()
          
          Rectangle()
            .foregroundStyle(.cyan.opacity(0.3))
            .frame(width: 322, height: 322)
          
          Spacer()
          
          VStack(spacing: 0) {
            Spacer()
            
            VStack(spacing: 0) {
              if viewStore.isLastPage {
                Spacer()
                
                Text("\(viewStore.onboardingPage.text)")
                  .foregroundStyle(Color.white)
                  .multilineTextAlignment(.center)
                
                Spacer()
                
                Button(action: { viewStore.send(.didTapStartButton) }) {
                  Text("Start")
                    .foregroundStyle(Color.white)
                    .frame(width: 104, height: 52)
                    .background(Color.yellow.opacity(0.7))
                    .cornerRadius(8)
                }
                
                Spacer()
              } else {
                Spacer()
                Text("\(viewStore.onboardingPage.title ?? "")")
                  .foregroundStyle(Color.white)
                
                Spacer()
                
                Text("\(viewStore.onboardingPage.text)")
                  .foregroundStyle(Color.white)
                  .multilineTextAlignment(.center)
                
                Spacer()
              }
            }
            .padding(.horizontal, 22)
            
            Spacer()
          }
          .frame(height: 235)
          .frame(maxWidth: .infinity)
          .background(Color.blue.opacity(0.8))
        }
      }
      .ignoresSafeArea()
    }
  }
}
