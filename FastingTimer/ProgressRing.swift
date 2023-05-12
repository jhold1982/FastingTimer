//
//  ProgressRing.swift
//  FastingTimer
//
//  Created by Justin Hold on 5/11/23.
//

import SwiftUI

struct ProgressRing: View {
	@EnvironmentObject var fastingManager: FastingManager
//	@State var progress = 0.0
	let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
		
	var body: some View {
		ZStack {
			// MARK: Placeholder Ring
			Circle()
				.stroke(lineWidth: 20)
				.foregroundColor(.gray)
				.opacity(0.1)
			
			// MARK: Color Ring
			Circle()
				.trim(from: 0.0, to: min(fastingManager.progress, 1.0))
				.stroke(AngularGradient(gradient: Gradient(colors: [
					.blue, .teal, .indigo, .teal, .blue
				]), center: .center), style: StrokeStyle(
					lineWidth: 15.0,
					lineCap: .round,
					lineJoin: .round
				))
				.rotationEffect(Angle(degrees: 270))
				.animation(.easeInOut(duration: 1.0), value: fastingManager.progress)
			
			VStack(spacing: 30) {
				if fastingManager.fastingState == .notStarted {
					// MARK: Upcoming Fast
					VStack(spacing: 5) {
						Text("Upcoming Fast")
							.opacity(0.7)
						Text("\(fastingManager.fastingPlan.fastingPeriod.formatted()) Hours")
							.font(.title).bold()
					}
				} else {
					// MARK: Elapsed Time
					VStack(spacing: 5) {
						Text("Elapsed Time (\(fastingManager.progress.formatted(.percent))")
							.opacity(0.7)
						Text(fastingManager.startTime, style: .timer)
							.font(.title).bold()
					}
					.padding(.top)
					// MARK: Remainging Time
					VStack(spacing: 5) {
						if !fastingManager.elapsed {
							Text("Remaining Time (\((1 - fastingManager.progress).formatted(.percent)))")
								.opacity(0.7)
						} else {
							Text("Extra Time")
								.opacity(0.7)
						}
						Text(fastingManager.endTime, style: .timer)
							.font(.title2).bold()
					}
				}
			}
		}
		.frame(width: 250, height: 250)
		.padding()
//		.onAppear {
//			fastingManager.progress = 1
//		}
		.onReceive(timer) { _ in
			fastingManager.track()
		}
    }
}

struct ProgressRing_Previews: PreviewProvider {
    static var previews: some View {
        ProgressRing()
			.environmentObject(FastingManager())
    }
}
