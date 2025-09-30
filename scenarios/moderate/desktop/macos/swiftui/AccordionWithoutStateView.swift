import SwiftUI
struct AccordionWithoutStateView: View {
    @State private var expandedItems: Set<Int> = []
    let faqItems = [
        FAQItem(
        ),
        FAQItem(
        ),
        FAQItem(
            question: "What are the WCAG guidelines?",
        ),
        FAQItem(
        )
    ]
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                // Main Content Card
                VStack(alignment: .leading, spacing: 20) {
                    // Title
                    Text("Frequently Asked Questions")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.primary)
                    // Description
                    Text("Click on questions to expand and view answers.")
                        .font(.body)
                        .foregroundColor(.secondary)
                    // FAQ Accordion
                    VStack(spacing: 10) {
                        ForEach(Array(faqItems.enumerated()), id: \.offset) { index, item in
                            FAQItemView(
                                item: item,
                                isExpanded: expandedItems.contains(index),
                                onToggle: {
                                    toggleItem(at: index)
                                }
                            )
                        }
                    }
                }
                .padding()
                .background(Color(NSColor.controlBackgroundColor))
                .cornerRadius(12)
                .shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 2)
                VStack(alignment: .leading, spacing: 15) {
                    }
                    .font(.caption)
                    .foregroundColor(.secondary)
                    Text("How to Fix:")
                        .font(.headline)
                        .fontWeight(.bold)
                        .foregroundColor(.primary)
                        .padding(.top, 10)
                    VStack(alignment: .leading, spacing: 8) {
                    }
                    .font(.caption)
                    .foregroundColor(.secondary)
                }
                .padding()
                .background(Color(NSColor.controlBackgroundColor).opacity(0.5))
                .cornerRadius(8)
            }
            .padding()
        }
        .onAppear {
        }
    }
    private func toggleItem(at index: Int) {
        if expandedItems.contains(index) {
            expandedItems.remove(index)
        } else {
            expandedItems.insert(index)
        }
    }
    }
}
struct FAQItem {
    let question: String
    let answer: String
}
struct FAQItemView: View {
    let item: FAQItem
    let isExpanded: Bool
    let onToggle: () -> Void
    var body: some View {
        VStack(spacing: 0) {
            Button(action: onToggle) {
                HStack {
                    Text(item.question)
                        .font(.headline)
                        .fontWeight(.bold)
                        .foregroundColor(.primary)
                        .multilineTextAlignment(.leading)
                    Spacer()
                    Image(systemName: isExpanded ? "chevron.up" : "chevron.down")
                        .foregroundColor(.secondary)
                        .font(.caption)
                }
                .padding()
                .background(Color(NSColor.controlBackgroundColor).opacity(0.5))
            }
            .buttonStyle(.plain)
            if isExpanded {
                VStack(alignment: .leading, spacing: 0) {
                    Divider()
                    Text(item.answer)
                        .font(.body)
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.leading)
                        .padding()
                        .background(Color(NSColor.controlBackgroundColor))
                }
            } else {
                EmptyView()
            }
        }
        .background(Color(NSColor.controlBackgroundColor))
        .cornerRadius(8)
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(Color(NSColor.separatorColor), lineWidth: 1)
        )
    }
}
#Preview {
    AccordionWithoutStateView()
        .frame(width: 600, height: 700)
}
