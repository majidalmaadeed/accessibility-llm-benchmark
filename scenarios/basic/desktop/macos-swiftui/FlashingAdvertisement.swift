import SwiftUI

struct FlashingAdvertisement: View {
    @State private var flashCount = 0
    @State private var isFlashing = true
    @State private var flashColor = Color.red
    
    var body: some View {
        VStack(spacing: 0) {
            // FLASHING ADVERTISEMENT - FLASHING 5 TIMES PER SECOND
            HStack(spacing: 12) {
                Text("🔥")
                    .font(.title2)
                
                Text("FLASH SALE!")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                
                Text("Up to 50% OFF!")
                    .font(.headline)
                    .foregroundColor(.white)
                
                Text("Flashes: \(flashCount)")
                    .font(.caption)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(Color.black.opacity(0.2))
                    .cornerRadius(12)
                
                Button(isFlashing ? "⏸️" : "▶️") {
                    isFlashing.toggle()
                }
                .font(.title2)
                .foregroundColor(.white)
            }
            .padding()
            .background(flashColor)
            .onAppear {
                startFlashAnimation()
            }
            
            // Products Section
            ScrollView {
                VStack(spacing: 16) {
                    HStack {
                        Text("All Products")
                            .font(.title)
                            .fontWeight(.bold)
                        Spacer()
                        Text("6 products found")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                    .padding(.horizontal)
                    
                    LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 3), spacing: 16) {
                        // Product 1
                        VStack(alignment: .leading, spacing: 12) {
                            AsyncImage(url: URL(string: "https://via.placeholder.com/200x200")) { image in
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                            } placeholder: {
                                Rectangle()
                                    .fill(Color.gray)
                            }
                            .frame(height: 200)
                            .cornerRadius(8)
                            
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Wireless Headphones")
                                    .font(.headline)
                                    .fontWeight(.bold)
                                
                                HStack {
                                    Text("⭐⭐⭐⭐☆")
                                        .font(.caption)
                                    Text("4.5")
                                        .font(.caption)
                                        .foregroundColor(.gray)
                                }
                                
                                HStack {
                                    Text("$99.99")
                                        .font(.title2)
                                        .fontWeight(.bold)
                                        .foregroundColor(.green)
                                    
                                    Text("$149.99")
                                        .font(.subheadline)
                                        .foregroundColor(.gray)
                                        .strikethrough()
                                    
                                    Text("Save $50")
                                        .font(.caption)
                                        .fontWeight(.bold)
                                        .foregroundColor(.white)
                                        .padding(.horizontal, 4)
                                        .padding(.vertical, 2)
                                        .background(Color.green)
                                        .cornerRadius(4)
                                }
                                
                                Button("Add to Cart") {
                                    // Add to cart action
                                }
                                .padding(.horizontal, 12)
                                .padding(.vertical, 8)
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(8)
                            }
                        }
                        .padding()
                        .background(Color.white)
                        .cornerRadius(8)
                        .shadow(radius: 2)
                        
                        // Product 2
                        VStack(alignment: .leading, spacing: 12) {
                            AsyncImage(url: URL(string: "https://via.placeholder.com/200x200")) { image in
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                            } placeholder: {
                                Rectangle()
                                    .fill(Color.gray)
                            }
                            .frame(height: 200)
                            .cornerRadius(8)
                            
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Smart Watch")
                                    .font(.headline)
                                    .fontWeight(.bold)
                                
                                HStack {
                                    Text("⭐⭐⭐⭐⭐")
                                        .font(.caption)
                                    Text("4.8")
                                        .font(.caption)
                                        .foregroundColor(.gray)
                                }
                                
                                HStack {
                                    Text("$299.99")
                                        .font(.title2)
                                        .fontWeight(.bold)
                                        .foregroundColor(.green)
                                    
                                    Text("$399.99")
                                        .font(.subheadline)
                                        .foregroundColor(.gray)
                                        .strikethrough()
                                    
                                    Text("Save $100")
                                        .font(.caption)
                                        .fontWeight(.bold)
                                        .foregroundColor(.white)
                                        .padding(.horizontal, 4)
                                        .padding(.vertical, 2)
                                        .background(Color.green)
                                        .cornerRadius(4)
                                }
                                
                                Button("Add to Cart") {
                                    // Add to cart action
                                }
                                .padding(.horizontal, 12)
                                .padding(.vertical, 8)
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(8)
                            }
                        }
                        .padding()
                        .background(Color.white)
                        .cornerRadius(8)
                        .shadow(radius: 2)
                        
                        // Product 3
                        VStack(alignment: .leading, spacing: 12) {
                            ZStack {
                                AsyncImage(url: URL(string: "https://via.placeholder.com/200x200")) { image in
                                    image
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                } placeholder: {
                                    Rectangle()
                                        .fill(Color.gray)
                                }
                                .frame(height: 200)
                                .cornerRadius(8)
                                
                                Rectangle()
                                    .fill(Color.black.opacity(0.7))
                                    .overlay(
                                        Text("Out of Stock")
                                            .font(.caption)
                                            .fontWeight(.bold)
                                            .foregroundColor(.white)
                                            .padding(8)
                                    )
                                    .cornerRadius(8)
                            }
                            
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Bluetooth Speaker")
                                    .font(.headline)
                                    .fontWeight(.bold)
                                
                                HStack {
                                    Text("⭐⭐⭐⭐☆")
                                        .font(.caption)
                                    Text("4.3")
                                        .font(.caption)
                                        .foregroundColor(.gray)
                                }
                                
                                HStack {
                                    Text("$79.99")
                                        .font(.title2)
                                        .fontWeight(.bold)
                                        .foregroundColor(.green)
                                    
                                    Text("$99.99")
                                        .font(.subheadline)
                                        .foregroundColor(.gray)
                                        .strikethrough()
                                    
                                    Text("Save $20")
                                        .font(.caption)
                                        .fontWeight(.bold)
                                        .foregroundColor(.white)
                                        .padding(.horizontal, 4)
                                        .padding(.vertical, 2)
                                        .background(Color.green)
                                        .cornerRadius(4)
                                }
                                
                                Button("Add to Cart") {
                                    // Add to cart action
                                }
                                .padding(.horizontal, 12)
                                .padding(.vertical, 8)
                                .background(Color.gray)
                                .foregroundColor(.white)
                                .cornerRadius(8)
                                .disabled(true)
                            }
                        }
                        .padding()
                        .background(Color.white)
                        .cornerRadius(8)
                        .shadow(radius: 2)
                    }
                    .padding()
                }
            }
        }
        .onAppear {
            startFlashAnimation()
        }
    }
    
    private func startFlashAnimation() {
        Timer.scheduledTimer(withTimeInterval: 0.2, repeats: true) { timer in
            if isFlashing {
                flashCount += 1
                flashColor = flashColor == .red ? .orange : .red
            } else {
                timer.invalidate()
            }
        }
    }
}

#Preview {
    FlashingAdvertisement()
}
