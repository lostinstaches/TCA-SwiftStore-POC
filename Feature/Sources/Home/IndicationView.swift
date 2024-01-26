import SwiftUI
import ComposableArchitecture

public struct IndicationView: View {
  public struct ViewModel: Equatable {
    let activeSquareIndex: Int
  }

  private let viewModel: ViewModel

  init(viewModel: ViewModel) {
    self.viewModel = viewModel
  }

  public var body: some View {
    HStack{
      ForEach(0..<4) { i in fourOnFourSquare(i) }
    }
    .frame(height: 75)
    .padding(.horizontal, 12)
  }

  @ViewBuilder
  func fourOnFourSquare(_ index: Int) -> some View {
    (index == viewModel.activeSquareIndex ? Color.yellow.opacity(0.8) : Color.blue.opacity(0.8))
      .frame(width: 75, height: 75)
      .cornerRadius(5)
      .frame(maxWidth: .infinity)
  }
}
