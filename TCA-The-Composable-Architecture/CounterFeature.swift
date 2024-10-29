//
//  CounterFeature.swift
//  TCA-The-Composable-Architecture
//
//  Created by 정정욱 on 10/29/24.
//

import ComposableArchitecture
import SwiftUI

@Reducer
struct CounterFeature {
  @ObservableState
  struct State {
    var count = 0
    var fact: String?
    var isLoading = false
    var isTimerRunning = false
  }
  
  enum Action {
    case decrementButtonTapped
    case factButtonTapped
    case factResponse(String)
    case incrementButtonTapped
    case timerTick
    case toggleTimerButtonTapped
  }
  
  enum CancelID { case timer }
  
  var body: some ReducerOf<Self> {
    Reduce { state, action in
      switch action {
      case .decrementButtonTapped:
        state.count -= 1
        state.fact = nil
        return .none
        
      case .factButtonTapped:
        state.fact = nil
        state.isLoading = true
        return .run { [count = state.count] send in
          let (data, _) = try await URLSession.shared
            .data(from: URL(string: "http://numbersapi.com/\(count)")!)
          let fact = String(decoding: data, as: UTF8.self)
          await send(.factResponse(fact))
        }
        
      case let .factResponse(fact):
        state.fact = fact
        state.isLoading = false
        return .none
        
      case .incrementButtonTapped:
        state.count += 1
        state.fact = nil
        return .none
        
      case .timerTick:
        state.count += 1
        state.fact = nil
        return .none
        
      case .toggleTimerButtonTapped:
        state.isTimerRunning.toggle()
        if state.isTimerRunning {
          return .run { send in
            while true {
              try await Task.sleep(for: .seconds(1))
              await send(.timerTick)
            }
          }
          .cancellable(id: CancelID.timer)
            // "타이머 시작" 버튼을 탭하여 타이머를 시작한 다음 "타이머 중지"를 누르면 정상적으로 멈추지 않았지만 
            // 우리는 ID를 제공하여 모든 효과를 취소 가능으로 표시한 다음, 나중에 .를 사용하여 해당 효과를 취소할 수 있습니다
        } else {
          return .cancel(id: CancelID.timer)
        }
      }
    }
  }
}
