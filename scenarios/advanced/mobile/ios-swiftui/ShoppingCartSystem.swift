import SwiftUI

struct ShoppingCartSystem: View {
    @State private var cartItems: [CartItem] = []
    @State private var promoCode: String = ""
    @State private var appliedPromo: PromoCode? = nil
    @State private var showPromoField: Bool = false
    @State private var isCheckingOut: Bool = false
    @State private var showCheckout: Bool = false
    @State private var selectedShipping: ShippingOption = .standard
    @State private var paymentMethod: PaymentMethod = .creditCard
    
    let shippingOptions = [
        ShippingOption(name: "Standard", price: 5.99, days: "5-7 business days"),
        ShippingOption(name: "Express", price: 12.99, days: "2-3 business days"),
        ShippingOption(name: "Overnight", price: 24.99, days: "Next business day")
    ]
    
    let paymentMethods = [
        PaymentMethod(name: "Credit Card", icon: "creditcard"),
        PaymentMethod(name: "PayPal", icon: "p.circle"),
        PaymentMethod(name: "Apple Pay", icon: "applelogo"),
        PaymentMethod(name: "Google Pay", icon: "g.circle")
    ]
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                if cartItems.isEmpty {
                    emptyCartView
                } else {
                    cartContentView
                }
            }
            .navigationTitle("Shopping Cart")
            .navigationBarTitleDisplayMode(.large)
            .onAppear {
                loadCartItems()
            }
        }
        .sheet(isPresented: $showCheckout) {
            CheckoutView(
                cartItems: cartItems,
                subtotal: subtotal,
                tax: tax,
                shipping: selectedShipping.price,
                discount: appliedPromo?.discount ?? 0,
                total: total,
                promoCode: appliedPromo,
                shippingOption: selectedShipping,
                paymentMethod: paymentMethod
            )
        }
    }
    
    private var emptyCartView: some View {
        VStack(spacing: 20) {
            Image(systemName: "cart")
                .font(.system(size: 60))
                .foregroundColor(.secondary)
            
            Text("Your cart is empty")
                .font(.title2)
                .fontWeight(.semibold)
            
            Text("Add some items to get started")
                .foregroundColor(.secondary)
            
            Button("Continue Shopping") {
                // Navigate to products
            }
            .buttonStyle(.borderedProminent)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
    private var cartContentView: some View {
        VStack(spacing: 0) {
            ScrollView {
                LazyVStack(spacing: 16) {
                    ForEach(cartItems) { item in
                        CartItemRow(item: item) { updatedItem in
                            updateCartItem(updatedItem)
                        } onRemove: {
                            removeCartItem(item.id)
                        }
                    }
                }
                .padding()
            }
            
            Divider()
            
            cartSummaryView
        }
    }
    
    private var cartSummaryView: some View {
        VStack(spacing: 16) {
            VStack(spacing: 12) {
                HStack {
                    Text("Subtotal")
                    Spacer()
                    Text("$\(String(format: "%.2f", subtotal))")
                }
                
                HStack {
                    Text("Tax")
                    Spacer()
                    Text("$\(String(format: "%.2f", tax))")
                }
                
                HStack {
                    Text("Shipping")
                    Spacer()
                    Text("$\(String(format: "%.2f", selectedShipping.price))")
                }
                
                if let promo = appliedPromo {
                    HStack {
                        Text("Discount (\(promo.code))")
                            .foregroundColor(.green)
                        Spacer()
                        Text("-$\(String(format: "%.2f", promo.discount))")
                            .foregroundColor(.green)
                    }
                }
                
                Divider()
                
                HStack {
                    Text("Total")
                        .font(.headline)
                        .fontWeight(.bold)
                    Spacer()
                    Text("$\(String(format: "%.2f", total))")
                        .font(.headline)
                        .fontWeight(.bold)
                }
            }
            
            VStack(spacing: 12) {
                if !showPromoField {
                    Button("Add Promo Code") {
                        showPromoField = true
                    }
                    .buttonStyle(.bordered)
                } else {
                    HStack {
                        TextField("Enter promo code", text: $promoCode)
                            .textFieldStyle(.roundedBorder)
                        
                        Button("Apply") {
                            applyPromoCode()
                        }
                        .buttonStyle(.borderedProminent)
                        .disabled(promoCode.isEmpty)
                        
                        Button("Cancel") {
                            showPromoField = false
                            promoCode = ""
                        }
                        .buttonStyle(.bordered)
                    }
                }
                
                if appliedPromo != nil {
                    Button("Remove Promo Code") {
                        removePromoCode()
                    }
                    .buttonStyle(.bordered)
                    .foregroundColor(.red)
                }
                
                Button(isCheckingOut ? "Processing..." : "Proceed to Checkout") {
                    proceedToCheckout()
                }
                .buttonStyle(.borderedProminent)
                .disabled(isCheckingOut)
                .frame(maxWidth: .infinity)
            }
        }
        .padding()
        .background(Color(.systemGray6))
    }
    
    // MARK: - Computed Properties
    
    private var subtotal: Double {
        cartItems.reduce(0) { $0 + ($1.price * Double($1.quantity)) }
    }
    
    private var tax: Double {
        subtotal * 0.08 // 8% tax rate
    }
    
    private var total: Double {
        let discount = appliedPromo?.discount ?? 0
        return subtotal + tax + selectedShipping.price - discount
    }
    
    // MARK: - Methods
    
    private func loadCartItems() {
        cartItems = [
            CartItem(
                id: UUID(),
                name: "Wireless Headphones",
                price: 99.99,
                quantity: 1,
                image: "headphones",
                description: "High-quality wireless headphones with noise cancellation"
            ),
            CartItem(
                id: UUID(),
                name: "Smart Watch",
                price: 299.99,
                quantity: 1,
                image: "applewatch",
                description: "Advanced smartwatch with health monitoring"
            ),
            CartItem(
                id: UUID(),
                name: "Phone Case",
                price: 24.99,
                quantity: 2,
                image: "case",
                description: "Protective phone case with wireless charging"
            )
        ]
    }
    
    private func updateCartItem(_ item: CartItem) {
        if let index = cartItems.firstIndex(where: { $0.id == item.id }) {
            cartItems[index] = item
        }
    }
    
    private func removeCartItem(_ id: UUID) {
        cartItems.removeAll { $0.id == id }
    }
    
    private func applyPromoCode() {
        let validPromos = [
            PromoCode(code: "SAVE10", discount: 10.0, description: "Save $10 on your order"),
            PromoCode(code: "WELCOME", discount: 15.0, description: "Welcome discount - Save $15"),
            PromoCode(code: "FREESHIP", discount: selectedShipping.price, description: "Free shipping on your order")
        ]
        
        if let promo = validPromos.first(where: { $0.code.uppercased() == promoCode.uppercased() }) {
            appliedPromo = promo
            showPromoField = false
            promoCode = ""
        } else {
            // Show error
        }
    }
    
    private func removePromoCode() {
        appliedPromo = nil
    }
    
    private func proceedToCheckout() {
        isCheckingOut = true
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            isCheckingOut = false
            showCheckout = true
        }
    }
}

struct CartItemRow: View {
    let item: CartItem
    let onUpdate: (CartItem) -> Void
    let onRemove: () -> Void
    
    @State private var quantity: Int
    
    init(item: CartItem, onUpdate: @escaping (CartItem) -> Void, onRemove: @escaping () -> Void) {
        self.item = item
        self.onUpdate = onUpdate
        self.onRemove = onRemove
        self._quantity = State(initialValue: item.quantity)
    }
    
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: item.image)
                .font(.system(size: 40))
                .foregroundColor(.blue)
                .frame(width: 60, height: 60)
                .background(Color(.systemGray6))
                .cornerRadius(8)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(item.name)
                    .font(.headline)
                    .fontWeight(.semibold)
                
                Text(item.description)
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .lineLimit(2)
                
                Text("$\(String(format: "%.2f", item.price))")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundColor(.blue)
            }
            
            Spacer()
            
            VStack(spacing: 8) {
                HStack(spacing: 8) {
                    Button(action: { decreaseQuantity() }) {
                        Image(systemName: "minus.circle")
                    }
                    .buttonStyle(.bordered)
                    .disabled(quantity <= 1)
                    
                    Text("\(quantity)")
                        .font(.headline)
                        .frame(minWidth: 30)
                    
                    Button(action: { increaseQuantity() }) {
                        Image(systemName: "plus.circle")
                    }
                    .buttonStyle(.bordered)
                }
                
                Button("Remove") {
                    onRemove()
                }
                .buttonStyle(.bordered)
                .foregroundColor(.red)
                .font(.caption)
            }
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 2)
    }
    
    private func increaseQuantity() {
        quantity += 1
        updateItem()
    }
    
    private func decreaseQuantity() {
        if quantity > 1 {
            quantity -= 1
            updateItem()
        }
    }
    
    private func updateItem() {
        var updatedItem = item
        updatedItem.quantity = quantity
        onUpdate(updatedItem)
    }
}

struct CheckoutView: View {
    let cartItems: [CartItem]
    let subtotal: Double
    let tax: Double
    let shipping: Double
    let discount: Double
    let total: Double
    let promoCode: PromoCode?
    let shippingOption: ShippingOption
    let paymentMethod: PaymentMethod
    
    @Environment(\.dismiss) private var dismiss
    @State private var isProcessing: Bool = false
    @State private var showSuccess: Bool = false
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    orderSummaryView
                    shippingInfoView
                    paymentInfoView
                    totalView
                }
                .padding()
            }
            .navigationTitle("Checkout")
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
        }
        .alert("Order Placed!", isPresented: $showSuccess) {
            Button("OK") {
                dismiss()
            }
        } message: {
            Text("Your order has been placed successfully. You will receive a confirmation email shortly.")
        }
    }
    
    private var orderSummaryView: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Order Summary")
                .font(.headline)
            
            ForEach(cartItems) { item in
                HStack {
                    Text("\(item.quantity)x \(item.name)")
                    Spacer()
                    Text("$\(String(format: "%.2f", item.price * Double(item.quantity)))")
                }
                .font(.subheadline)
            }
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(8)
    }
    
    private var shippingInfoView: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Shipping")
                .font(.headline)
            
            HStack {
                Text(shippingOption.name)
                Spacer()
                Text("$\(String(format: "%.2f", shipping))")
            }
            
            Text(shippingOption.days)
                .font(.caption)
                .foregroundColor(.secondary)
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(8)
    }
    
    private var paymentInfoView: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Payment Method")
                .font(.headline)
            
            HStack {
                Image(systemName: paymentMethod.icon)
                Text(paymentMethod.name)
                Spacer()
            }
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(8)
    }
    
    private var totalView: some View {
        VStack(spacing: 12) {
            VStack(spacing: 8) {
                HStack {
                    Text("Subtotal")
                    Spacer()
                    Text("$\(String(format: "%.2f", subtotal))")
                }
                
                HStack {
                    Text("Tax")
                    Spacer()
                    Text("$\(String(format: "%.2f", tax))")
                }
                
                HStack {
                    Text("Shipping")
                    Spacer()
                    Text("$\(String(format: "%.2f", shipping))")
                }
                
                if discount > 0 {
                    HStack {
                        Text("Discount")
                            .foregroundColor(.green)
                        Spacer()
                        Text("-$\(String(format: "%.2f", discount))")
                            .foregroundColor(.green)
                    }
                }
                
                Divider()
                
                HStack {
                    Text("Total")
                        .font(.headline)
                        .fontWeight(.bold)
                    Spacer()
                    Text("$\(String(format: "%.2f", total))")
                        .font(.headline)
                        .fontWeight(.bold)
                }
            }
            
            Button(isProcessing ? "Processing..." : "Place Order") {
                placeOrder()
            }
            .buttonStyle(.borderedProminent)
            .disabled(isProcessing)
            .frame(maxWidth: .infinity)
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(8)
    }
    
    private func placeOrder() {
        isProcessing = true
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            isProcessing = false
            showSuccess = true
        }
    }
}

// MARK: - Supporting Types

struct CartItem: Identifiable {
    let id: UUID
    let name: String
    let price: Double
    var quantity: Int
    let image: String
    let description: String
}

struct PromoCode {
    let code: String
    let discount: Double
    let description: String
}

struct ShippingOption {
    let name: String
    let price: Double
    let days: String
}

struct PaymentMethod {
    let name: String
    let icon: String
}

struct ShoppingCartSystem_Previews: PreviewProvider {
    static var previews: some View {
        ShoppingCartSystem()
    }
}
