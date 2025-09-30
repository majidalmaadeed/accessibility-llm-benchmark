import SwiftUI

struct FlashingAdvertisement: View {
    @State private var currentAdIndex = 0
    @State private var isAnimating = false
    @State private var showAd = true
    @State private var adTimer: Timer?
    @State private var flashTimer: Timer?
    @State private var isFlashing = false
    @State private var selectedCategory = "all"
    @State private var searchText = ""
    @State private var showFilters = false
    @State private var selectedProduct: Product?
    @State private var cartItems: [Product] = []
    @State private var showCart = false
    
    let categories = ["all", "electronics", "clothing", "books", "home", "sports"]
    let advertisements = [
        Advertisement(
            id: 1,
            title: "MEGA SALE!",
            subtitle: "Up to 70% OFF",
            description: "Limited time offer on all electronics",
            imageURL: "https://images.unsplash.com/photo-1607082349566-187342175e2f?w=400",
            backgroundColor: Color.red,
            textColor: Color.white,
            isFlashing: true
        ),
        Advertisement(
            id: 2,
            title: "NEW ARRIVALS",
            subtitle: "Fresh Collection",
            description: "Check out our latest fashion items",
            imageURL: "https://images.unsplash.com/photo-1441986300917-64674bd600d8?w=400",
            backgroundColor: Color.blue,
            textColor: Color.white,
            isFlashing: false
        ),
        Advertisement(
            id: 3,
            title: "FREE SHIPPING",
            subtitle: "On Orders Over $50",
            description: "No minimum order required",
            imageURL: "https://images.unsplash.com/photo-1556742049-0cfed4f6a45d?w=400",
            backgroundColor: Color.green,
            textColor: Color.white,
            isFlashing: true
        ),
        Advertisement(
            id: 4,
            title: "FLASH DEAL",
            subtitle: "24 Hours Only",
            description: "Don't miss out on these amazing prices",
            imageURL: "https://images.unsplash.com/photo-1607082349566-187342175e2f?w=400",
            backgroundColor: Color.orange,
            textColor: Color.white,
            isFlashing: true
        )
    ]
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                // Header
                VStack(spacing: 12) {
                    HStack {
                        Text("ShopApp")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                        
                        Spacer()
                        
                        Button(action: {
                            showCart = true
                        }) {
                            ZStack {
                                Image(systemName: "cart")
                                    .font(.title2)
                                    .foregroundColor(.blue)
                                
                                if !cartItems.isEmpty {
                                    Text("\(cartItems.count)")
                                        .font(.caption2)
                                        .foregroundColor(.white)
                                        .padding(4)
                                        .background(Color.red)
                                        .clipShape(Circle())
                                        .offset(x: 8, y: -8)
                                }
                            }
                        }
                    }
                    
                    // Search Bar
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                        
                        TextField("Search products...", text: $searchText)
                            .textFieldStyle(PlainTextFieldStyle())
                    }
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(10)
                }
                .padding()
                .background(Color.white)
                .shadow(color: .black.opacity(0.1), radius: 2, x: 0, y: 2)
                
                // Flashing Advertisement Banner
                if showAd {
                    AdvertisementBanner(
                        advertisement: advertisements[currentAdIndex],
                        isFlashing: isFlashing,
                        onDismiss: {
                            showAd = false
                        },
                        onTap: {
                            // Handle ad tap
                        }
                    )
                    .onAppear {
                        startAdRotation()
                        startFlashing()
                    }
                    .onDisappear {
                        stopAdRotation()
                        stopFlashing()
                    }
                }
                
                // Category Filter
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 12) {
                        ForEach(categories, id: \.self) { category in
                            Button(action: {
                                selectedCategory = category
                            }) {
                                Text(category.capitalized)
                                    .font(.subheadline)
                                    .padding(.horizontal, 16)
                                    .padding(.vertical, 8)
                                    .background(selectedCategory == category ? Color.blue : Color.gray.opacity(0.2))
                                    .foregroundColor(selectedCategory == category ? .white : .primary)
                                    .cornerRadius(20)
                            }
                        }
                    }
                    .padding(.horizontal)
                }
                .padding(.vertical, 8)
                
                // Filter Controls
                HStack {
                    Button(action: {
                        showFilters.toggle()
                    }) {
                        HStack(spacing: 4) {
                            Image(systemName: "line.horizontal.3.decrease.circle")
                            Text("Filters")
                        }
                        .font(.subheadline)
                        .foregroundColor(.blue)
                    }
                    
                    Spacer()
                    
                    Text("\(filteredProducts.count) products")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                .padding(.horizontal)
                .padding(.vertical, 8)
                
                // Products Grid
                ScrollView {
                    LazyVGrid(columns: [
                        GridItem(.flexible()),
                        GridItem(.flexible())
                    ], spacing: 16) {
                        ForEach(filteredProducts) { product in
                            ProductCard(
                                product: product,
                                onTap: {
                                    selectedProduct = product
                                },
                                onAddToCart: {
                                    addToCart(product)
                                }
                            )
                        }
                    }
                    .padding()
                }
            }
            .navigationBarHidden(true)
            .sheet(isPresented: $showFilters) {
                FilterView()
            }
            .sheet(item: $selectedProduct) { product in
                ProductDetailView(
                    product: product,
                    onAddToCart: {
                        addToCart(product)
                    }
                )
            }
            .sheet(isPresented: $showCart) {
                CartView(items: $cartItems)
            }
        }
    }
    
    var filteredProducts: [Product] {
        var products = sampleProducts
        
        if selectedCategory != "all" {
            products = products.filter { $0.category == selectedCategory }
        }
        
        if !searchText.isEmpty {
            products = products.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
        }
        
        return products
    }
    
    private func startAdRotation() {
        adTimer = Timer.scheduledTimer(withTimeInterval: 3.0, repeats: true) { _ in
            withAnimation(.easeInOut(duration: 0.5)) {
                currentAdIndex = (currentAdIndex + 1) % advertisements.count
            }
        }
    }
    
    private func stopAdRotation() {
        adTimer?.invalidate()
        adTimer = nil
    }
    
    private func startFlashing() {
        flashTimer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { _ in
            withAnimation(.easeInOut(duration: 0.1)) {
                isFlashing.toggle()
            }
        }
    }
    
    private func stopFlashing() {
        flashTimer?.invalidate()
        flashTimer = nil
    }
    
    private func addToCart(_ product: Product) {
        if !cartItems.contains(where: { $0.id == product.id }) {
            cartItems.append(product)
        }
    }
}

struct AdvertisementBanner: View {
    let advertisement: Advertisement
    let isFlashing: Bool
    let onDismiss: () -> Void
    let onTap: () -> Void
    
    var body: some View {
        ZStack {
            // Background with flashing effect
            Rectangle()
                .fill(advertisement.backgroundColor)
                .opacity(isFlashing ? 0.8 : 1.0)
                .animation(.easeInOut(duration: 0.1), value: isFlashing)
            
            // Content
            HStack(spacing: 16) {
                // Image
                AsyncImage(url: URL(string: advertisement.imageURL)) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                } placeholder: {
                    Rectangle()
                        .fill(Color.white.opacity(0.3))
                        .overlay(
                            Image(systemName: "photo")
                                .foregroundColor(.white)
                        )
                }
                .frame(width: 80, height: 80)
                .clipped()
                .cornerRadius(8)
                
                // Text Content
                VStack(alignment: .leading, spacing: 4) {
                    Text(advertisement.title)
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(advertisement.textColor)
                        .opacity(isFlashing ? 0.6 : 1.0)
                        .animation(.easeInOut(duration: 0.1), value: isFlashing)
                    
                    Text(advertisement.subtitle)
                        .font(.headline)
                        .foregroundColor(advertisement.textColor)
                        .opacity(isFlashing ? 0.8 : 1.0)
                        .animation(.easeInOut(duration: 0.1), value: isFlashing)
                    
                    Text(advertisement.description)
                        .font(.subheadline)
                        .foregroundColor(advertisement.textColor)
                        .opacity(0.9)
                }
                
                Spacer()
                
                // Action Button
                Button(action: onTap) {
                    Text("Shop Now")
                        .font(.headline)
                        .fontWeight(.bold)
                        .foregroundColor(advertisement.backgroundColor)
                        .padding(.horizontal, 20)
                        .padding(.vertical, 10)
                        .background(Color.white)
                        .cornerRadius(20)
                        .opacity(isFlashing ? 0.7 : 1.0)
                        .animation(.easeInOut(duration: 0.1), value: isFlashing)
                }
            }
            .padding()
            
            // Dismiss Button
            VStack {
                HStack {
                    Spacer()
                    Button(action: onDismiss) {
                        Image(systemName: "xmark")
                            .font(.title3)
                            .foregroundColor(advertisement.textColor)
                            .padding(8)
                            .background(Color.white.opacity(0.2))
                            .clipShape(Circle())
                    }
                }
                Spacer()
            }
            .padding()
        }
        .frame(height: 120)
        .onTapGesture {
            onTap()
        }
    }
}

struct ProductCard: View {
    let product: Product
    let onTap: () -> Void
    let onAddToCart: () -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            // Product Image
            AsyncImage(url: URL(string: product.imageURL)) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            } placeholder: {
                Rectangle()
                    .fill(Color.gray.opacity(0.3))
                    .overlay(
                        Image(systemName: "photo")
                            .foregroundColor(.gray)
                    )
            }
            .frame(height: 150)
            .clipped()
            .cornerRadius(8)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(product.name)
                    .font(.headline)
                    .lineLimit(2)
                
                Text(product.brand)
                    .font(.caption)
                    .foregroundColor(.secondary)
                
                HStack {
                    ForEach(0..<5) { index in
                        Image(systemName: index < Int(product.rating) ? "star.fill" : "star")
                            .foregroundColor(.yellow)
                            .font(.caption)
                    }
                    
                    Text("(\(product.reviewCount))")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                
                HStack {
                    Text("$\(product.price, specifier: "%.2f")")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.blue)
                    
                    if product.originalPrice > product.price {
                        Text("$\(product.originalPrice, specifier: "%.2f")")
                            .font(.caption)
                            .strikethrough()
                            .foregroundColor(.secondary)
                    }
                    
                    Spacer()
                }
                
                // Add to Cart Button
                Button(action: onAddToCart) {
                    HStack {
                        Image(systemName: "cart.badge.plus")
                            .font(.caption)
                        Text("Add to Cart")
                            .font(.caption)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 8)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(6)
                }
            }
            .padding(.horizontal, 4)
        }
        .background(Color.white)
        .cornerRadius(12)
        .shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 2)
        .onTapGesture {
            onTap()
        }
    }
}

struct ProductDetailView: View {
    let product: Product
    let onAddToCart: () -> Void
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    // Large Product Image
                    AsyncImage(url: URL(string: product.imageURL)) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                    } placeholder: {
                        Rectangle()
                            .fill(Color.gray.opacity(0.3))
                            .overlay(
                                Image(systemName: "photo")
                                    .foregroundColor(.gray)
                                    .font(.largeTitle)
                            )
                    }
                    .frame(height: 300)
                    .clipped()
                    .cornerRadius(12)
                    
                    VStack(alignment: .leading, spacing: 12) {
                        Text(product.name)
                            .font(.title2)
                            .fontWeight(.bold)
                        
                        Text(product.brand)
                            .font(.headline)
                            .foregroundColor(.secondary)
                        
                        HStack {
                            ForEach(0..<5) { index in
                                Image(systemName: index < Int(product.rating) ? "star.fill" : "star")
                                    .foregroundColor(.yellow)
                            }
                            
                            Text("\(product.rating, specifier: "%.1f") (\(product.reviewCount) reviews)")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                        
                        HStack {
                            Text("$\(product.price, specifier: "%.2f")")
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundColor(.blue)
                            
                            if product.originalPrice > product.price {
                                Text("$\(product.originalPrice, specifier: "%.2f")")
                                    .font(.title2)
                                    .strikethrough()
                                    .foregroundColor(.secondary)
                            }
                            
                            Spacer()
                        }
                        
                        Text(product.description)
                            .font(.body)
                            .foregroundColor(.primary)
                        
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Features:")
                                .font(.headline)
                            
                            ForEach(product.features, id: \.self) { feature in
                                HStack {
                                    Image(systemName: "checkmark.circle.fill")
                                        .foregroundColor(.green)
                                    Text(feature)
                                        .font(.subheadline)
                                }
                            }
                        }
                        
                        Button(action: onAddToCart) {
                            HStack {
                                Image(systemName: "cart.badge.plus")
                                Text("Add to Cart")
                            }
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                        }
                    }
                    .padding()
                }
            }
            .navigationTitle("Product Details")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {
                        dismiss()
                    }
                }
            }
        }
    }
}

struct CartView: View {
    @Binding var items: [Product]
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationView {
            VStack {
                if items.isEmpty {
                    VStack(spacing: 16) {
                        Image(systemName: "cart")
                            .font(.system(size: 60))
                            .foregroundColor(.gray)
                        
                        Text("Your cart is empty")
                            .font(.title2)
                            .fontWeight(.medium)
                        
                        Text("Add some items to get started")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    .padding()
                    
                    Spacer()
                } else {
                    List {
                        ForEach(items) { item in
                            HStack {
                                AsyncImage(url: URL(string: item.imageURL)) { image in
                                    image
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                } placeholder: {
                                    Rectangle()
                                        .fill(Color.gray.opacity(0.3))
                                }
                                .frame(width: 60, height: 60)
                                .clipped()
                                .cornerRadius(8)
                                
                                VStack(alignment: .leading) {
                                    Text(item.name)
                                        .font(.headline)
                                    
                                    Text("$\(item.price, specifier: "%.2f")")
                                        .font(.subheadline)
                                        .foregroundColor(.blue)
                                }
                                
                                Spacer()
                                
                                Button(action: {
                                    items.removeAll { $0.id == item.id }
                                }) {
                                    Image(systemName: "trash")
                                        .foregroundColor(.red)
                                }
                            }
                        }
                    }
                    
                    VStack {
                        HStack {
                            Text("Total:")
                                .font(.headline)
                            Spacer()
                            Text("$\(items.map { $0.price }.reduce(0, +), specifier: "%.2f")")
                                .font(.headline)
                                .foregroundColor(.blue)
                        }
                        .padding()
                        
                        Button(action: {
                            // Checkout
                        }) {
                            Text("Checkout")
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(8)
                        }
                        .padding(.horizontal)
                    }
                }
            }
            .navigationTitle("Shopping Cart")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {
                        dismiss()
                    }
                }
            }
        }
    }
}

struct FilterView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var priceRange: ClosedRange<Double> = 0...1000
    @State private var selectedBrands: Set<String> = []
    @State private var selectedRating: Double = 0
    @State private var inStockOnly = false
    
    let brands = ["Apple", "Samsung", "Sony", "Nike", "Adidas", "Puma"]
    
    var body: some View {
        NavigationView {
            Form {
                Section("Price Range") {
                    VStack {
                        HStack {
                            Text("$\(Int(priceRange.lowerBound))")
                            Spacer()
                            Text("$\(Int(priceRange.upperBound))")
                        }
                        .font(.caption)
                        .foregroundColor(.secondary)
                        
                        RangeSlider(range: $priceRange, in: 0...2000, step: 50)
                    }
                }
                
                Section("Brands") {
                    ForEach(brands, id: \.self) { brand in
                        HStack {
                            Text(brand)
                            Spacer()
                            if selectedBrands.contains(brand) {
                                Image(systemName: "checkmark")
                                    .foregroundColor(.blue)
                            }
                        }
                        .contentShape(Rectangle())
                        .onTapGesture {
                            if selectedBrands.contains(brand) {
                                selectedBrands.remove(brand)
                            } else {
                                selectedBrands.insert(brand)
                            }
                        }
                    }
                }
                
                Section("Rating") {
                    VStack {
                        HStack {
                            Text("Minimum Rating")
                            Spacer()
                            Text("\(selectedRating, specifier: "%.1f") stars")
                                .foregroundColor(.secondary)
                        }
                        
                        Slider(value: $selectedRating, in: 0...5, step: 0.5)
                    }
                }
                
                Section("Availability") {
                    Toggle("In Stock Only", isOn: $inStockOnly)
                }
            }
            .navigationTitle("Filters")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Clear") {
                        priceRange = 0...1000
                        selectedBrands.removeAll()
                        selectedRating = 0
                        inStockOnly = false
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Apply") {
                        dismiss()
                    }
                }
            }
        }
    }
}

// Data Models
struct Advertisement: Identifiable {
    let id: Int
    let title: String
    let subtitle: String
    let description: String
    let imageURL: String
    let backgroundColor: Color
    let textColor: Color
    let isFlashing: Bool
}

struct Product: Identifiable, Hashable {
    let id = UUID()
    let name: String
    let brand: String
    let price: Double
    let originalPrice: Double
    let rating: Double
    let reviewCount: Int
    let imageURL: String
    let category: String
    let description: String
    let features: [String]
    let isOnSale: Bool
    let dateAdded: Date
    let popularity: Int
}

let sampleProducts = [
    Product(
        name: "Wireless Headphones Pro",
        brand: "TechBrand",
        price: 199.99,
        originalPrice: 249.99,
        rating: 4.5,
        reviewCount: 128,
        imageURL: "https://images.unsplash.com/photo-1505740420928-5e560c06d30e?w=300",
        category: "electronics",
        description: "High-quality wireless headphones with noise cancellation and premium sound quality.",
        features: ["Noise Cancellation", "30-hour battery", "Quick Charge", "Bluetooth 5.0"],
        isOnSale: true,
        dateAdded: Date().addingTimeInterval(-86400),
        popularity: 95
    ),
    Product(
        name: "Running Shoes",
        brand: "SportBrand",
        price: 129.99,
        originalPrice: 129.99,
        rating: 4.8,
        reviewCount: 89,
        imageURL: "https://images.unsplash.com/photo-1542291026-7eec264c27ff?w=300",
        category: "sports",
        description: "Comfortable running shoes with advanced cushioning technology.",
        features: ["Breathable Material", "Shock Absorption", "Lightweight", "Durable"],
        isOnSale: false,
        dateAdded: Date().addingTimeInterval(-172800),
        popularity: 88
    ),
    Product(
        name: "Smart Watch",
        brand: "TechBrand",
        price: 299.99,
        originalPrice: 399.99,
        rating: 4.3,
        reviewCount: 156,
        imageURL: "https://images.unsplash.com/photo-1523275335684-37898b6baf30?w=300",
        category: "electronics",
        description: "Advanced smartwatch with fitness tracking and health monitoring.",
        features: ["Heart Rate Monitor", "GPS", "Water Resistant", "Sleep Tracking"],
        isOnSale: true,
        dateAdded: Date().addingTimeInterval(-259200),
        popularity: 82
    ),
    Product(
        name: "Coffee Maker",
        brand: "HomeBrand",
        price: 89.99,
        originalPrice: 89.99,
        rating: 4.6,
        reviewCount: 203,
        imageURL: "https://images.unsplash.com/photo-1495474472287-4d71bcdd2085?w=300",
        category: "home",
        description: "Programmable coffee maker with multiple brewing options.",
        features: ["Programmable Timer", "Auto Shut-off", "12-cup Capacity", "Easy Clean"],
        isOnSale: false,
        dateAdded: Date().addingTimeInterval(-345600),
        popularity: 91
    ),
    Product(
        name: "Programming Book",
        brand: "BookBrand",
        price: 49.99,
        originalPrice: 59.99,
        rating: 4.7,
        reviewCount: 92,
        imageURL: "https://images.unsplash.com/photo-1481627834876-b7833e8f5570?w=300",
        category: "books",
        description: "Comprehensive guide to modern programming techniques and best practices.",
        features: ["500+ Pages", "Code Examples", "Online Resources", "Updated Content"],
        isOnSale: true,
        dateAdded: Date().addingTimeInterval(-432000),
        popularity: 85
    ),
    Product(
        name: "T-Shirt",
        brand: "FashionBrand",
        price: 24.99,
        originalPrice: 24.99,
        rating: 4.2,
        reviewCount: 67,
        imageURL: "https://images.unsplash.com/photo-1521572163474-6864f9cf17ab?w=300",
        category: "clothing",
        description: "Comfortable cotton t-shirt in various colors and sizes.",
        features: ["100% Cotton", "Machine Washable", "Multiple Colors", "Various Sizes"],
        isOnSale: false,
        dateAdded: Date().addingTimeInterval(-518400),
        popularity: 78
    )
]

struct FlashingAdvertisement_Previews: PreviewProvider {
    static var previews: some View {
        FlashingAdvertisement()
    }
}

