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
  private let googleImageName = "google"
  private let action: () -> Void
  private let icon: UIImageView

  // MARK: - Button attribute wrappers

  @ObservedObject private var styleWrapper: GIDSignInButtonStyleWrapper
  /// The `GIDSignInButtonStyle` for the button.
  public var style: GIDSignInButtonStyle {
    set {
      styleWrapper.wrapped = newValue
    }
    get {
      return styleWrapper.wrapped
    }
  }

  @ObservedObject private var colorSchemeWrapper: GIDSignInButtonColorSchemeWrapper
  /// The `GIDSignInButtonColorScheme` for the button.
  public var colorScheme: GIDSignInButtonColorScheme {
    set {
      colorSchemeWrapper.wrapped = newValue
    }
    get {
      return colorSchemeWrapper.wrapped
    }
  }

  @ObservedObject private var stateWrapper: GIDSignInButtonStateWrapper
  /// The `GIDSignInButtonState` for the button.
  public var state: GIDSignInButtonState {
    set {
      stateWrapper.wrapped = newValue
    }
    get {
      return stateWrapper.wrapped
    }
  }

  /// Creates an instance of the Google Sign-In button for use in SwiftUI
  /// - parameter style: The button style to use.
  /// - parameter colorScheme: The color scheme for the button.
  /// - parameter state: The button's state to use.
  /// - parameter action: A closure to use as the button's action upon press.
  public init(
    style: GIDSignInButtonStyle = .standard,
    colorScheme: GIDSignInButtonColorScheme = .light,
    state: GIDSignInButtonState = .normal,
    action: @escaping () -> Void
  ) {
    self.styleWrapper = GIDSignInButtonStyleWrapper(wrapped: style)
    self.colorSchemeWrapper = GIDSignInButtonColorSchemeWrapper(wrapped: colorScheme)
    self.stateWrapper = GIDSignInButtonStateWrapper(wrapped: state)
    self.action = action
    self.icon = UIImageView()
  }

  public var body: some View {
    switch style {
    case .iconOnly:
      Button(title, action: self.action)
        .cornerRadius(CGFloat(kCornerRadius))
        .disabled(self.state == GIDSignInButtonState.disabled)
        .buttonStyle(IconConfiguration())
    case .standard:
      Button(title, action: self.action)
        .cornerRadius(CGFloat(kCornerRadius))
        .disabled(self.state == GIDSignInButtonState.disabled)
        .buttonStyle(StandardConfiguration())
    case .wide:
      Button(title, action: self.action)
        .cornerRadius(CGFloat(kCornerRadius))
        .disabled(self.state == GIDSignInButtonState.disabled)
        .buttonStyle(WideConfiguration())
    default:
      fatalError("Unknown case provided for `GIDSignInButtonStyle`.")
    }
  }

  private func loadIconImage() {
    guard let bundle = Bundle.gidFrameworkPath(), let path = bundle.path(
      forResource: googleImageName,
      ofType: "png") else {
        return
      }
    let image = UIImage(contentsOfFile: path)

    switch state {
    case .disabled:
      // Create a blurred image instead
      icon.image = image
    default:
      icon.image = image
    }
  }
}

@available(iOS 13.0, *)
private struct IconConfiguration: ButtonStyle {
  func makeBody(configuration: Configuration) -> some View {
    configuration.label
      .padding()
  }
}

@available(iOS 13.0, *)
private struct StandardConfiguration: ButtonStyle {
  func makeBody(configuration: Configuration) -> some View {
    configuration.label
      .padding()
  }
}

@available(iOS 13.0, *)
private struct WideConfiguration: ButtonStyle {
  func makeBody(configuration: Configuration) -> some View {
    configuration.label
      .padding()
  }
}

private extension Bundle {
  class func gidFrameworkPath() -> Bundle? {
    if let path = Bundle.main.path(
      forResource: "GoogleSignIn_GoogleSignIn",
      ofType: "bundle"
    ) {
      return Bundle(path: path)
    } else if let otherPath = Bundle(for: GIDSignIn.self).path(
      forResource: "GoogleSignIn_GoogleSignIn",
      ofType: "bundle") {
      return Bundle(path: otherPath)
    } else {
      return nil
    }
  }
}
