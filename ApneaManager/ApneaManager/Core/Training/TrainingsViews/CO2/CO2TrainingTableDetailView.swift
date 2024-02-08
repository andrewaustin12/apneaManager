import SwiftUI

struct CO2TrainingTableDetailView: View {
    @Environment(\.presentationMode) var presentationMode
    var co2Table: [Cycle]

    var body: some View {
        NavigationView {
            List(co2Table.indices, id: \.self) { index in
                VStack(alignment: .leading, spacing: 4) {
                    Text("Round \(index + 1)")
                        .font(.title3)
                        .bold()
                        .foregroundColor(.primary)
                    
                    HStack {
                        VStack(alignment: .leading, spacing: 2) {
                            Text("Apnea")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                            Text("\(formattedTime(seconds: co2Table[index].hold))")
                                .font(.headline)
                        }
                        
                        Spacer()
                        
                        VStack(alignment: .leading, spacing: 2) {
                            Text("Breathe")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                            Text("\(formattedTime(seconds: co2Table[index].rest))")
                                .font(.headline)
                        }
                    }
                    //.padding(8)
                    .background(Color(.systemBackground))
                    .cornerRadius(10)
                }
                .padding(.horizontal, 16)
                .background(Color(.systemBackground))
            }
            .listStyle(.plain)
            .navigationTitle("CO2 Training Table")
            .toolbar{
                Button("Dismiss") {
                    presentationMode.wrappedValue.dismiss()
                }
                .position(x: 16, y: 16)
            }
        }
    }
    
    private func formattedTime(seconds: Int) -> String {
        let minutes = seconds / 60
        let remainingSeconds = seconds % 60

        if minutes > 0 && remainingSeconds == 0 {
            return "\(minutes)m"
        } else if minutes > 0 {
            return "\(minutes)m \(remainingSeconds)s"
        } else {
            return "\(remainingSeconds)s"
        }
    }
}

#Preview {
    CO2TrainingTableDetailView(co2Table: [
        Cycle(hold: 30, rest: 60),
        Cycle(hold: 30, rest: 55),
        Cycle(hold: 30, rest: 50)
    ])
}
