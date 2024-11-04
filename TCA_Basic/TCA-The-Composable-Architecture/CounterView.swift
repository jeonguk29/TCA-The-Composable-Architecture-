//
//  CounterView.swift
//  TCA-The-Composable-Architecture
//
//  Created by 정정욱 on 10/29/24.
//

import SwiftUI
import ComposableArchitecture

struct CounterView: View {
  let store: StoreOf<CounterFeature>
  
  var body: some View {
    VStack {
      Text("\(store.count)")
        .font(.largeTitle)
        .padding()
        .background(Color.black.opacity(0.1))
        .cornerRadius(10)
      HStack {
        Button("-") {
          store.send(.decrementButtonTapped)
        }
        .font(.largeTitle)
        .padding()
        .background(Color.black.opacity(0.1))
        .cornerRadius(10)
        
        Button("+") {
          store.send(.incrementButtonTapped)
        }
        .font(.largeTitle)
        .padding()
        .background(Color.black.opacity(0.1))
        .cornerRadius(10)
      }
      Button(store.isTimerRunning ? "Stop timer" : "Start timer") {
        store.send(.toggleTimerButtonTapped)
      }
      .font(.largeTitle)
      .padding()
      .background(Color.black.opacity(0.1))
      .cornerRadius(10)
      
      Button("Fact") {
        store.send(.factButtonTapped)
      }
      .font(.largeTitle)
      .padding()
      .background(Color.black.opacity(0.1))
      .cornerRadius(10)
      
      if store.isLoading {
        ProgressView()
      } else if let fact = store.fact {
        Text(fact)
          .font(.largeTitle)
          .multilineTextAlignment(.center)
          .padding()
      }
    }
  }
}

#Preview {
  CounterView(
    store: Store(initialState: CounterFeature.State()) {
        CounterFeature()
      // CounterFeature()
    }
  )
}
/*
 예를 들어, 미리보기에서 리듀서를 주석 처리하면 스토어에 상태 변형이나 효과를 수행하지 않는 리듀서가 제공됩니다. 이를 통해 로직이나 동작에 대해 걱정하지 않고도 기능의 디자인을 미리 볼 수 있습니다.CounterFeature
 */
