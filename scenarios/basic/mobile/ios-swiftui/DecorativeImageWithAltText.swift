import SwiftUI

struct DecorativeImageWithAltText: View {
    @State private var selectedCategory = "all"
    @State private var searchText = ""
    @State private var sortBy = "popularity"
    @State private var showFilters = false
    @State private var selectedProduct: Product?
    @State private var cartItems: [Product] = []
    @State private var showCart = false
    @State private var wishlistItems: [Product] = []
    @State private var showWishlist = false
    
    let categories = ["all", "electronics", "clothing", "books", "home", "sports"]
    let sortOptions = ["popularity", "price", "rating", "newest"]
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                // Header with Search and Cart
                VStack(spacing: 12) {
                    HStack {
                        // Logo
                        HStack(spacing: 8) {
                            Image(systemName: "bag.fill")
                                .font(.title2)
                                .foregroundColor(.blue)
                            
                            Text("ShopApp")
                                .font(.title2)
                                .fontWeight(.bold)
                        }
                        
                        Spacer()
                        
                        // Cart and Wishlist
                        HStack(spacing: 16) {
                            Button(action: {
                                showWishlist = true
                            }) {
                                ZStack {
                                    Image(systemName: "heart")
                                        .font(.title2)
                                        .foregroundColor(.blue)
                                    
                                    if !wishlistItems.isEmpty {
                                        Text("\(wishlistItems.count)")
                                            .font(.caption2)
                                            .foregroundColor(.white)
                                            .padding(4)
                                            .background(Color.red)
                                            .clipShape(Circle())
                                            .offset(x: 8, y: -8)
                                    }
                                }
                            }
                            
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
                
                // Sort and Filter Controls
                HStack {
                    Picker("Sort by", selection: $sortBy) {
                        ForEach(sortOptions, id: \.self) { option in
                            Text(option.capitalized).tag(option)
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
                    
                    Spacer()
                    
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
                                },
                                onAddToWishlist: {
                                    addToWishlist(product)
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
                    },
                    onAddToWishlist: {
                        addToWishlist(product)
                    }
                )
            }
            .sheet(isPresented: $showCart) {
                CartView(items: $cartItems)
            }
            .sheet(isPresented: $showWishlist) {
                WishlistView(items: $wishlistItems)
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
        
        switch sortBy {
        case "price":
            products = products.sorted { $0.price < $1.price }
        case "rating":
            products = products.sorted { $0.rating > $1.rating }
        case "newest":
            products = products.sorted { $0.dateAdded > $1.dateAdded }
        default:
            products = products.sorted { $0.popularity > $1.popularity }
        }
        
        return products
    }
    
    private func addToCart(_ product: Product) {
        if !cartItems.contains(where: { $0.id == product.id }) {
            cartItems.append(product)
        }
    }
    
    private func addToWishlist(_ product: Product) {
        if !wishlistItems.contains(where: { $0.id == product.id }) {
            wishlistItems.append(product)
        }
    }
}

struct ProductCard: View {
    let product: Product
    let onTap: () -> Void
    let onAddToCart: () -> Void
    let onAddToWishlist: () -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            // Product Image with decorative elements
            ZStack {
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
                
                // Decorative corner accent
                VStack {
                    HStack {
                        Spacer()
                        Image(systemName: "sparkles")
                            .font(.caption)
                            .foregroundColor(.yellow)
                            .padding(4)
                            .background(Color.white.opacity(0.8))
                            .clipShape(Circle())
                    }
                    Spacer()
                }
                .padding(8)
                
                // Sale badge (decorative)
                if product.isOnSale {
                    VStack {
                        HStack {
                            Text("SALE")
                                .font(.caption2)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .padding(.horizontal, 6)
                                .padding(.vertical, 2)
                                .background(Color.red)
                                .cornerRadius(4)
                            Spacer()
                        }
                        Spacer()
                    }
                    .padding(8)
                }
            }
            
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
                
                // Action Buttons
                HStack(spacing: 8) {
                    Button(action: onAddToCart) {
                        HStack(spacing: 4) {
                            Image(systemName: "cart.badge.plus")
                                .font(.caption)
                            Text("Add")
                                .font(.caption)
                        }
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(6)
                    }
                    
                    Button(action: onAddToWishlist) {
                        Image(systemName: "heart")
                            .font(.caption)
                            .padding(6)
                            .background(Color.gray.opacity(0.2))
                            .foregroundColor(.blue)
                            .cornerRadius(6)
                    }
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
    let onAddToWishlist: () -> Void
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    // Large Product Image with decorative elements
                    ZStack {
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
                        
                        // Decorative elements
                        VStack {
                            HStack {
                                Spacer()
                                Image(systemName: "star.fill")
                                    .font(.title3)
                                    .foregroundColor(.yellow)
                                    .padding(8)
                                    .background(Color.white.opacity(0.9))
                                    .clipShape(Circle())
                            }
                            Spacer()
                            HStack {
                                Image(systemName: "heart.circle.fill")
                                    .font(.title3)
                                    .foregroundColor(.pink)
                                    .padding(8)
                                    .background(Color.white.opacity(0.9))
                                    .clipShape(Circle())
                                Spacer()
                            }
                        }
                        .padding(16)
                    }
                    
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
                        
                        HStack(spacing: 16) {
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
                            
                            Button(action: onAddToWishlist) {
                                HStack {
                                    Image(systemName: "heart")
                                    Text("Wishlist")
                                }
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.gray.opacity(0.2))
                                .foregroundColor(.primary)
                                .cornerRadius(8)
                            }
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

struct WishlistView: View {
    @Binding var items: [Product]
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationView {
            VStack {
                if items.isEmpty {
                    VStack(spacing: 16) {
                        Image(systemName: "heart")
                            .font(.system(size: 60))
                            .foregroundColor(.gray)
                        
                        Text("Your wishlist is empty")
                            .font(.title2)
                            .fontWeight(.medium)
                        
                        Text("Add some items to your wishlist")
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
                }
            }
            .navigationTitle("Wishlist")
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

struct DecorativeImageWithAltText_Previews: PreviewProvider {
    static var previews: some View {
        DecorativeImageWithAltText()
    }
}

