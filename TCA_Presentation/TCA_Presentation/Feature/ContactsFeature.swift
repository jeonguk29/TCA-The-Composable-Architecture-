//
//  ContactsFeature.swift
//  TCA_Presentation
//
//  Created by 정정욱 on 11/4/24.
//

import Foundation
import ComposableArchitecture


struct Contact: Equatable, Identifiable {
  let id: UUID
  var name: String
}


@Reducer
struct ContactsFeature {
  @ObservableState
  struct State: Equatable {
    @Presents var addContact: AddContactFeature.State?
    var contacts: IdentifiedArrayOf<Contact> = []
  }
  enum Action {
    case addButtonTapped
    case addContact(PresentationAction<AddContactFeature.Action>)
  }
  var body: some ReducerOf<Self> {
    Reduce { state, action in
      switch action {
      case .addButtonTapped:
        state.addContact = AddContactFeature.State(
          contact: Contact(id: UUID(), name: "")
        )
        return .none
        
      case .addContact(.presented(.cancelButtonTapped)):
        state.addContact = nil
        return .none
        
      case .addContact(.presented(.saveButtonTapped)):
        guard let contact = state.addContact?.contact
        else { return .none }
        state.contacts.append(contact)
        state.addContact = nil
        return .none
        
      case .addContact:
        return .none
      }
    }
    .ifLet(\.$addContact, action: \.addContact) {
      AddContactFeature()
    }
  }
}
/*
 리듀서 연산자 를 활용하여 리듀서를 통합합니다 .ifLet(_:action:destination:fileID:filePath:line:column:)
 이렇게 하면 자식 액션이 시스템에 들어오면 자식 리듀서를 실행하고 모든 액션에서 부모 리듀서를 실행하는 새로운 리듀서가 생성됩니다. 또한 자식 피처가 해제될 때 효과 취소를 자동으로 처리하고, 그 외 많은 작업을 처리합니다.
 */
