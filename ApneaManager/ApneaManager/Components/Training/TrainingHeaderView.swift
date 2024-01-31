import SwiftUI

struct TrainingHeaderView: View {
    let roundsElapsed: Int
    let roundsRemaining: Int

    private var totalRounds: Int {
        roundsElapsed + roundsRemaining
    }

    private var progress: Double {
        guard totalRounds > 0 else { return 1 }
        return Double(roundsElapsed) / Double(totalRounds)
    }
    
    var body: some View {
        VStack {
            ProgressView(value: progress)
                .progressViewStyle(TrainingProgressViewStyle())
            
            HStack {
                VStack(alignment: .leading) {
                    Text("Rounds Elapsed")
                        .font(.caption)
                    Label("\(roundsElapsed)", systemImage: "hourglass.tophalf.fill")
                }
                Spacer()
                VStack(alignment: .trailing) {
                    Text("Rounds Remaining")
                        .font(.caption)
                    Label("\(roundsRemaining)", systemImage: "hourglass.bottomhalf.fill")
                        .labelStyle(.trailingIcon)
                }
            }
        }
        .padding([.top, .horizontal])
    }
}

// Preview
struct TrainingHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        TrainingHeaderView(roundsElapsed: 1, roundsRemaining: 16)
    }
}
