//
//  ContentView.swift
//  FastingTimer
//
//  Created by Justin Hold on 5/11/23.
//

import SwiftUI

struct ContentView: View {
	@StateObject var fastingManager = FastingManager()
	var title: String {
		switch fastingManager.fastingState {
		case .notStarted:
			return "Let's get started"
		case .fasting:
			return "You are now fasting"
		case .feeding:
			return "You are now feeding"
		}
	}
    var body: some View {
		ZStack {
			// MARK: Background color
			Color(#colorLiteral(red: 0.09974687546, green: 0.01124025509, blue: 0.243082583, alpha: 1))
				.ignoresSafeArea()
			
			content
		}
    }
	var content: some View {
		ZStack {
			VStack(spacing: 40) {
				// MARK: Title
				Text(title)
					.font(.headline)
					.foregroundColor(.blue)
				// MARK: Fasting Plan
				Text(fastingManager.fastingPlan.rawValue)
					.fontWeight(.semibold)
					.padding(.horizontal, 24)
					.padding(.vertical, 8)
					.background(.thinMaterial)
					.cornerRadius(20)
				Spacer()
			}
			.padding()
			VStack(spacing: 40) {
				// MARK: Progress Ring
				ProgressRing()
					.environmentObject(fastingManager)
				HStack(spacing: 60) {
					// MARK: Start Time
					VStack(spacing: 5) {
						Text(fastingManager.fastingState == .notStarted ? "Start" : "Started")
							.opacity(0.7)
						Text(
							fastingManager.startTime,
							format: .dateTime.weekday().hour().minute().second()
						).bold()
					}
					// MARK: End Time
					VStack(spacing: 5) {
						Text(fastingManager.fastingState == .notStarted ? "End" : "Ends")
							.opacity(0.7)
						Text(
							fastingManager.endTime,
							format: .dateTime.weekday().hour().minute().second()
						).bold()
					}
				}
				// MARK: Start Button
				Button {
					fastingManager.toggleFastingState()
				} label: {
					Text(fastingManager.fastingState == .fasting ? "End fast" : "Start fasting")
						.font(.title3)
						.fontWeight(.semibold)
						.padding(.horizontal, 24)
						.padding(.vertical, 8)
						.background(.thinMaterial)
						.cornerRadius(20)
				}
			}
			.padding()
		}
		.foregroundColor(.white)
	}
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
