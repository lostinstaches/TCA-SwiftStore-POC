import SwiftUI
import ComposableArchitecture

public struct HomeView: View {
  let store: StoreOf<HomeFeature>
  
  public init(store: StoreOf<HomeFeature>){
    self.store = store
  }
  
  public var body: some View {
    WithViewStore(self.store, observe: { $0 }) { viewStore in
      VStack(spacing: 0) {
        Spacer()
        
        Button(action: { viewStore.send(.didToggleStatusButton) })
        {
          if viewStore.isPlaying {
            Text("Pause")
              .foregroundStyle(Color.blue)
              .frame(width: 60, height: 50)
          } else {
            Text("Play")
              .foregroundStyle(Color.blue)
              .frame(width: 60, height: 50)
          }
        }
        
        Spacer()
        
        IndicationView(viewModel: viewStore.indicationVM)
        
        Spacer()
      }
      .frame(width: UIScreen.main.bounds.width)
    }
    .frame(width: UIScreen.main.bounds.width)
    .edgesIgnoringSafeArea(.all)
  }
}

#Preview {
  HomeView(store: .init(initialState: .init()) {
    HomeFeature()
  })
}
