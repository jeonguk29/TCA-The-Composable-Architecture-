//
//  TCA_The_Composable_ArchitectureApp.swift
//  TCA-The-Composable-Architecture
//
//  Created by 정정욱 on 10/28/24.
//

import SwiftUI
import ComposableArchitecture

@main
struct TCA_The_Composable_ArchitectureApp: App {
    static let store = Store(initialState: CounterFeature.State()) {
        CounterFeature()
            ._printChanges()
    }
    
    var body: some Scene {
        /*
         이렇게 해줘야 실기기 시뮬에서 우리 앱을 통합 해줄 수 있음
         Store애플리케이션에 전원을 공급하는 는 한 번만 만들어야 한다는 점에 유의하는 것이 중요합니다.
         
         _printChanges : 리듀서가 처리하는 모든 작업을 콘솔에 인쇄하고 작업을 처리한 후 상태가 어떻게 변경되었는지 인쇄합니다.
         */
        WindowGroup {
            CounterView(store: TCA_The_Composable_ArchitectureApp.store)
        }
        
    }
}
