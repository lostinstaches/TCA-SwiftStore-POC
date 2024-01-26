import Foundation
import ComposableArchitecture
import AVFoundation

public struct HomeFeature: Reducer {
  public struct State: Equatable {
    var isPlaying = false
    var activeSquareIndex = 0

    public init() {}
  }

  public enum Action: Equatable {
    case didToggleStatusButton
    case didTick
    case handleMetronomeStart(isFirstTick: Bool)
  }

  private enum CancelID {
    case metronomeTick
  }

  enum DebounceID {
      case metronomeTick
  }

  @Dependency(\.continuousClock) var clock

  private var audioPlayer: AVAudioPlayer?
  private var basicAudioPlayerVolume: Float = 1.0
  public init() {
    if let path = Bundle.module.path(forResource: "sound", ofType: "wav") {
      do {
        audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
        audioPlayer?.prepareToPlay()
      } catch {
        print("Error: Couldn't load the audio file")
      }
    }
  }

  public var body: some ReducerOf<Self> {
    Reduce { state, action in
      switch action {
      case .didToggleStatusButton:
        state.isPlaying.toggle()

        if state.isPlaying {
          return .send(.handleMetronomeStart(isFirstTick: true))
        } else {
          // Stop the metronome
          state.activeSquareIndex = 0
          return .cancel(id: CancelID.metronomeTick)
        }

      case .handleMetronomeStart(let isFirstTick):
        let interval = 60.0 / 120.0
        // Start the metronome
        return .run { send in
          if isFirstTick  {
            // Perform the initial tick immidiately
            await send(.didTick)
          }
          // Start the repeating action
          for await _ in self.clock.timer(interval: .seconds(interval)) {
            await send(.didTick)
          }
        }
        .cancellable(id: CancelID.metronomeTick)

      case .didTick:
        let numberOfBeats = 4
        state.activeSquareIndex = (state.activeSquareIndex + 1) % numberOfBeats
        guard let audioPlayer else { return .none }
        audioPlayer.stop()
        // Otherwise new sound could not be played at high BPM
        audioPlayer.currentTime = 0
        // Reset volume if previous was emphasis, could nt do it at emphasis, cause volume wouldnt be changed
        audioPlayer.volume = basicAudioPlayerVolume
        audioPlayer.play()
        return .none
      }
    }
  }
}

public extension HomeFeature.State {
  var indicationVM: IndicationView.ViewModel {
    .init(activeSquareIndex: self.activeSquareIndex)
  }
}
