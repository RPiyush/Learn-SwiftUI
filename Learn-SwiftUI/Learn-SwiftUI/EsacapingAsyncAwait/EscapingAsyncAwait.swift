//
//  EscapingAsyncAwait.swift
//  Learn-SwiftUI
//
//  Created by Piyush Rathi on 07/10/25.
//

/*
🧠 How It Works
- withCheckedContinuation (or withCheckedThrowingContinuation) suspends the async function.
- When your callback fires, you resume the continuation with a result or error.
- Swift then resumes the suspended async function safely.
 
 ✅ In short:
 Use withCheckedContinuation or withCheckedThrowingContinuation to wrap old escaping completion methods so you can use them with async/await seamlessly.
*/

import SwiftUI

struct EscapingAsyncAwait: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }

    func callMethod() {
        Task {
            do {
                let data = try await fetchDataAsync()
                print(data)
            } catch {
                print("Error: \(error)")
            }
        }
    }
    
    func fetchData(completion: @escaping (String?, Error?) -> Void) {
        DispatchQueue.global().asyncAfter(deadline: .now() + 2) {
            completion("Success ✅", nil)
        }
    }
    
    func fetchDataAsync() async throws -> String {
        try await withCheckedThrowingContinuation { continuation in
            fetchData { data, error in
                if let data = data {
                    continuation.resume(returning: data)
                } else {
                    continuation.resume(throwing: error ?? URLError(.badServerResponse))
                }
            }
        }
    }
    
//    func loadMessage() async -> String {
//        await withCheckedContinuation { continuation in
//            fetchMessage { msg in
//                continuation.resume(returning: msg)
//            }
//        }
//    }
}

#Preview {
    EscapingAsyncAwait()
}
