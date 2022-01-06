/*
 * Copyright 2021 Google LLC
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

import SwiftUI
import GoogleSignIn

/// A Google Sign In button to be used in SwiftUI.
@available(iOS 13.0, *)
public struct GIDSwiftUISignInButton: View {
  private let title = "Sign In with Google"
  private let action: () -> Void

  // MARK: - Button attribute wrappers
  @ObservedObject private var styleWrapper: GIDSignInButtonStyleWrapper
  public var style: GIDSignInButtonStyle {
    set {
      styleWrapper.wrapped = newValue
    }
    get {
      return styleWrapper.wrapped
    }
  }
  @ObservedObject private var colorSchemeWrapper: GIDSignInButtonColorSchemeWrapper
  public var colorScheme: GIDSignInButtonColorScheme {
    set {
      colorSchemeWrapper.wrapped = newValue
    }
    get {
      return colorSchemeWrapper.wrapped
    }
  }
  @ObservedObject private var stateWrapper: GIDSignInButtonStateWrapper
  public var state: GIDSignInButtonState {
    set {
      stateWrapper.wrapped = newValue
    }
    get {
      return stateWrapper.wrapped
    }
  }

  init(style: GIDSignInButtonStyle,
       colorScheme: GIDSignInButtonColorScheme,
       state: GIDSignInButtonState,
       action: @escaping () -> Void) {
    self.styleWrapper = GIDSignInButtonStyleWrapper(wrapped: style)
    self.colorSchemeWrapper = GIDSignInButtonColorSchemeWrapper(wrapped: colorScheme)
    self.stateWrapper = GIDSignInButtonStateWrapper(wrapped: state)
    self.action = action
  }

  public var body: some View {
    Button(title, action: self.action)
      .cornerRadius(CGFloat(kCornerRadius))
      .disabled(self.state == GIDSignInButtonState.disabled)
  }
}

