import SwiftUI

struct ThemePicker: View {
    @AppStorage("selectedTheme") private var selectedThemeRawValue: String = Theme.bubblegum.rawValue
    let themes = Theme.allCases

    // Computed property to easily convert between Theme and its rawValue
    private var selectedTheme: Theme {
        get {
            Theme(rawValue: selectedThemeRawValue) ?? .primary
        }
        set {
            selectedThemeRawValue = newValue.rawValue
        }
    }

    var body: some View {
        VStack(spacing: 10) {
            Text("Select Your Theme")
                .font(.title2)
                .bold()
                .padding()
                .padding(.top)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(themes) { theme in
                        ThemeBubble(theme: theme, isSelected: theme.rawValue == selectedThemeRawValue)
                            .onTapGesture {
                                withAnimation {
                                    // Update the rawValue directly
                                    self.selectedThemeRawValue = theme.rawValue
                                }
                            }
                    }
                }
                .padding(.horizontal)
            }
            .frame(height: 180)
            .padding(.bottom)
            Spacer()
        }
        .navigationTitle("Theme")
        .frame(maxWidth: .infinity)
        .padding()
        .background(LinearGradient(gradient: Gradient(colors: [selectedTheme.mainColor, selectedTheme.accentColor]), startPoint: .top, endPoint: .bottom))
        .cornerRadius(20)
        .padding()
        .shadow(radius: 10)
    }
}


struct ThemeBubble: View {
    let theme: Theme
    var isSelected: Bool

    var body: some View {
        VStack {
            Circle()
                .fill(theme.mainColor)
                .frame(width: 100, height: 100)
                .overlay(isSelected ? Image(systemName: "checkmark.circle").foregroundColor(.white) : nil)
            Text(theme.name)
                .font(.headline)
                .foregroundColor(.primary)
        }
        .padding(.vertical, 5)
        .accessibility(label: Text(theme.name))
    }
}

// Example Usage
struct ThemePickerPreview: View {
    // This is no longer needed because ThemePicker now uses @AppStorage directly
    // @State private var selectedTheme: Theme = .bubblegum

    var body: some View {
        NavigationStack {
            ThemePicker() // Updated to use @AppStorage directly
        }
    }
}

struct ThemePicker_Previews: PreviewProvider {
    static var previews: some View {
        ThemePickerPreview()
    }
}
