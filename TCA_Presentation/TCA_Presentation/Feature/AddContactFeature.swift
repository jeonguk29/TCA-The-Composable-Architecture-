//
//  AddContactFeature.swift
//  TCA_Presentation
//
//  Created by 정정욱 on 11/4/24.
//

/*
 새로운 연락처 이름을 입력할 수 있는 피처에 대한 리듀서와 뷰를 보관합니다. 이 피처에는 종료를 위한 "취소" 버튼과 탭하면 피처를 종료 하고 부모의 연락처 목록에 연락처를 추가하는 "저장" 버튼이 있습니다.
 */

import ComposableArchitecture


@Reducer
struct AddContactFeature {
  @ObservableState
  struct State: Equatable {
    var contact: Contact
  }
  enum Action {
    case cancelButtonTapped
    case saveButtonTapped
    case setName(String)
  }
  var body: some ReducerOf<Self> {
    Reduce { state, action in
      switch action {
      case .cancelButtonTapped:
        return .none
        
      case .saveButtonTapped:
        return .none
        
      case let .setName(name):
        state.contact.name = name
        return .none
      }
    }
  }
}
