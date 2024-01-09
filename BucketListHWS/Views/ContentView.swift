//
//  ContentView.swift
//  BucketListHWS
//
//  Created by Sharan Thakur on 08/01/24.
//

import LocalAuthentication
import SwiftUI

struct ContentView: View {
    @Environment(\.scenePhase) var scenePhase
    
    @State private var isUnlocked = false
    @State private var showAlert = false
    
    var body: some View {
        NavigationStack {
            if isUnlocked {
                MainView()
            } else {
                Image(systemName: "lock.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 50)
                    .padding(.bottom)
                Text("Unlock your app before using all its features!")
                    .bold()
                
                Spacer()
                
                Button("Unlock with Biometrics", action: authenticate)
                .tint(.pink)
                .buttonStyle(.borderedProminent)
                .padding(.bottom, 50)
            }
        }
        .alert("No Biometrics", isPresented: $showAlert) {
            Button("Okay") {
                showAlert = false
            }
        } message: {
            Text("No biometrics supported")
        }
        .onChange(of: scenePhase) {
            switch scenePhase {
            case .background, .inactive:
                isUnlocked = false
            case .active:
                break
            @unknown default:
                fatalError()
            }
        }
        .preferredColorScheme(.dark)
    }
    
    private func authenticate() {
        let context = LAContext()
        var error: NSError?
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "Please authenticate yourself to unlock your places"
            
            Task {
                do {
                    let success = try await context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason)
                    
                    isUnlocked = success
                } catch {
                    print(error.localizedDescription)
                }
            }
        } else {
            showAlert = true
            print("No biometrics!")
        }
    }
}

#Preview {
    ContentView()
}
