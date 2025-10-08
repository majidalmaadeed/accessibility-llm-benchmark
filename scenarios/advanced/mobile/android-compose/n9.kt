package com.accessibility.benchmark.compose

import androidx.compose.foundation.background
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.lazy.LazyColumn
import androidx.compose.foundation.lazy.items
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material.*
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.*
import androidx.compose.runtime.*
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp

data class CartItem(
    val id: String,
    val name: String,
    val price: Double,
    val quantity: Int,
    val imageUrl: String? = null,
    val description: String = "",
    val inStock: Boolean = true
)

data class PromoCode(
    val code: String,
    val discount: Double,
    val type: DiscountType
)

enum class DiscountType {
    PERCENTAGE, FIXED_AMOUNT
}

@Composable
fun ShoppingCartSystem() {
    var cartItems by remember { mutableStateOf(getSampleCartItems()) }
    var promoCode by remember { mutableStateOf("") }
    var appliedPromoCode by remember { mutableStateOf<PromoCode?>(null) }
    var showPromoDialog by remember { mutableStateOf(false) }
    var showCheckoutDialog by remember { mutableStateOf(false) }
    var shippingMethod by remember { mutableStateOf("Standard") }
    var paymentMethod by remember { mutableStateOf("Credit Card") }
    
    val subtotal = cartItems.sumOf { it.price * it.quantity }
    val shippingCost = when (shippingMethod) {
        "Standard" -> 5.99
        "Express" -> 12.99
        "Overnight" -> 24.99
        else -> 0.0
    }
    val tax = (subtotal + shippingCost) * 0.08
    val discount = appliedPromoCode?.let { promo ->
        when (promo.type) {
            DiscountType.PERCENTAGE -> subtotal * (promo.discount / 100)
            DiscountType.FIXED_AMOUNT -> promo.discount
        }
    } ?: 0.0
    val total = subtotal + shippingCost + tax - discount
    
    Column(
        modifier = Modifier
            .fillMaxSize()
            .padding(16.dp)
    ) {
        // Header
        Row(
            modifier = Modifier.fillMaxWidth(),
            horizontalArrangement = Arrangement.SpaceBetween,
            verticalAlignment = Alignment.CenterVertically
        ) {
            Text(
                text = "Shopping Cart",
                fontSize = 24.sp,
                fontWeight = FontWeight.Bold
            )
            
            Text(
                text = "${cartItems.size} items",
                fontSize = 16.sp,
                color = MaterialTheme.colors.onSurface.copy(alpha = 0.6f)
            )
        }
        
        Spacer(modifier = Modifier.height(16.dp))
        
        // Cart Items
        LazyColumn(
            verticalArrangement = Arrangement.spacedBy(8.dp),
            modifier = Modifier.weight(1f)
        ) {
            items(cartItems) { item ->
                CartItemCard(
                    item = item,
                    onQuantityChange = { newQuantity ->
                        cartItems = cartItems.map { 
                            if (it.id == item.id) it.copy(quantity = newQuantity) else it 
                        }
                    },
                    onRemove = {
                        cartItems = cartItems.filter { it.id != item.id }
                    }
                )
            }
        }
        
        Spacer(modifier = Modifier.height(16.dp))
        
        // Promo Code Section
        Card(
            modifier = Modifier.fillMaxWidth(),
            elevation = 2.dp
        ) {
            Column(
                modifier = Modifier.padding(16.dp)
            ) {
                Text(
                    text = "Promo Code",
                    fontSize = 16.sp,
                    fontWeight = FontWeight.Bold,
                    modifier = Modifier.padding(bottom = 8.dp)
                )
                
                Row(
                    modifier = Modifier.fillMaxWidth(),
                    verticalAlignment = Alignment.CenterVertically
                ) {
                    OutlinedTextField(
                        value = promoCode,
                        onValueChange = { promoCode = it },
                        modifier = Modifier.weight(1f),
                        placeholder = { Text("Enter promo code") },
                        enabled = appliedPromoCode == null
                    )
                    
                    Spacer(modifier = Modifier.width(8.dp))
                    
                    Button(
                        onClick = { 
                            if (promoCode.isNotEmpty()) {
                                appliedPromoCode = PromoCode(promoCode, 10.0, DiscountType.PERCENTAGE)
                            }
                        },
                        enabled = promoCode.isNotEmpty() && appliedPromoCode == null
                    ) {
                        Text("Apply")
                    }
                }
                
                if (appliedPromoCode != null) {
                    Row(
                        modifier = Modifier
                            .fillMaxWidth()
                            .padding(top = 8.dp),
                        horizontalArrangement = Arrangement.SpaceBetween,
                        verticalAlignment = Alignment.CenterVertically
                    ) {
                        Text(
                            text = "Applied: ${appliedPromoCode!!.code}",
                            color = Color.Green,
                            fontSize = 14.sp
                        )
                        TextButton(onClick = { 
                            appliedPromoCode = null
                            promoCode = ""
                        }) {
                            Text("Remove")
                        }
                    }
                }
            }
        }
        
        Spacer(modifier = Modifier.height(16.dp))
        
        // Order Summary
        Card(
            modifier = Modifier.fillMaxWidth(),
            elevation = 4.dp,
            backgroundColor = MaterialTheme.colors.primary.copy(alpha = 0.1f)
        ) {
            Column(
                modifier = Modifier.padding(16.dp)
            ) {
                Text(
                    text = "Order Summary",
                    fontSize = 18.sp,
                    fontWeight = FontWeight.Bold,
                    modifier = Modifier.padding(bottom = 12.dp)
                )
                
                OrderSummaryRow("Subtotal", subtotal)
                OrderSummaryRow("Shipping", shippingCost)
                OrderSummaryRow("Tax", tax)
                
                if (discount > 0) {
                    OrderSummaryRow("Discount", -discount, Color.Green)
                }
                
                Divider(modifier = Modifier.padding(vertical = 8.dp))
                
                OrderSummaryRow("Total", total, fontWeight = FontWeight.Bold)
                
                Spacer(modifier = Modifier.height(16.dp))
                
                // Shipping Options
                Text(
                    text = "Shipping Method",
                    fontSize = 14.sp,
                    fontWeight = FontWeight.Medium,
                    modifier = Modifier.padding(bottom = 8.dp)
                )
                
                Row(
                    modifier = Modifier.fillMaxWidth(),
                    horizontalArrangement = Arrangement.SpaceBetween
                ) {
                    listOf("Standard", "Express", "Overnight").forEach { method ->
                        Row(
                            verticalAlignment = Alignment.CenterVertically
                        ) {
                            RadioButton(
                                selected = shippingMethod == method,
                                onClick = { shippingMethod = method }
                            )
                            Text(
                                text = method,
                                fontSize = 12.sp
                            )
                        }
                    }
                }
                
                Spacer(modifier = Modifier.height(16.dp))
                
                // Checkout Button
                Button(
                    onClick = { showCheckoutDialog = true },
                    modifier = Modifier.fillMaxWidth(),
                    enabled = cartItems.isNotEmpty()
                ) {
                    Text(
                        text = "Proceed to Checkout - $${String.format("%.2f", total)}",
                        fontSize = 16.sp,
                        fontWeight = FontWeight.Bold
                    )
                }
            }
        }
    }
    
    // Checkout Dialog
    if (showCheckoutDialog) {
        CheckoutDialog(
            onDismiss = { showCheckoutDialog = false },
            onConfirm = { 
                // Process checkout
                showCheckoutDialog = false
            },
            total = total,
            paymentMethod = paymentMethod,
            onPaymentMethodChange = { paymentMethod = it }
        )
    }
}

@Composable
fun CartItemCard(
    item: CartItem,
    onQuantityChange: (Int) -> Unit,
    onRemove: () -> Unit
) {
    Card(
        modifier = Modifier.fillMaxWidth(),
        elevation = 2.dp
    ) {
        Row(
            modifier = Modifier
                .fillMaxWidth()
                .padding(16.dp),
            verticalAlignment = Alignment.CenterVertically
        ) {
            // Product Image
            Box(
                modifier = Modifier
                    .size(80.dp)
                    .background(Color.Gray, shape = RoundedCornerShape(8.dp)),
                contentAlignment = Alignment.Center
            ) {
                Icon(
                    Icons.Default.Image,
                    contentDescription = null,
                    tint = Color.White
                )
            }
            
            Spacer(modifier = Modifier.width(16.dp))
            
            // Product Info
            Column(
                modifier = Modifier.weight(1f)
            ) {
                Text(
                    text = item.name,
                    fontSize = 16.sp,
                    fontWeight = FontWeight.Bold
                )
                
                if (item.description.isNotEmpty()) {
                    Text(
                        text = item.description,
                        fontSize = 14.sp,
                        color = MaterialTheme.colors.onSurface.copy(alpha = 0.6f)
                    )
                }
                
                Text(
                    text = "$${String.format("%.2f", item.price)}",
                    fontSize = 16.sp,
                    fontWeight = FontWeight.Bold,
                    color = MaterialTheme.colors.primary
                )
                
                if (!item.inStock) {
                    Text(
                        text = "Out of Stock",
                        fontSize = 12.sp,
                        color = Color.Red
                    )
                }
            }
            
            // Quantity Controls
            Column(
                horizontalAlignment = Alignment.CenterHorizontally
            ) {
                Text(
                    text = "Quantity",
                    fontSize = 12.sp,
                    color = MaterialTheme.colors.onSurface.copy(alpha = 0.6f)
                )
                
                Row(
                    verticalAlignment = Alignment.CenterVertically
                ) {
                    IconButton(
                        onClick = { 
                            if (item.quantity > 1) {
                                onQuantityChange(item.quantity - 1)
                            }
                        },
                        enabled = item.quantity > 1
                    ) {
                        Icon(Icons.Default.Remove, contentDescription = null)
                    }
                    
                    Text(
                        text = item.quantity.toString(),
                        fontSize = 16.sp,
                        fontWeight = FontWeight.Bold,
                        modifier = Modifier.padding(horizontal = 16.dp)
                    )
                    
                    IconButton(
                        onClick = { onQuantityChange(item.quantity + 1) },
                        enabled = item.inStock
                    ) {
                        Icon(Icons.Default.Add, contentDescription = null)
                    }
                }
            }
            
            Spacer(modifier = Modifier.width(16.dp))
            
            // Remove Button
            IconButton(onClick = onRemove) {
                Icon(
                    Icons.Default.Delete,
                    contentDescription = null,
                    tint = Color.Red
                )
            }
        }
    }
}

@Composable
fun OrderSummaryRow(
    label: String,
    amount: Double,
    color: Color = MaterialTheme.colors.onSurface,
    fontWeight: FontWeight = FontWeight.Normal
) {
    Row(
        modifier = Modifier.fillMaxWidth(),
        horizontalArrangement = Arrangement.SpaceBetween
    ) {
        Text(
            text = label,
            fontSize = 14.sp,
            color = color,
            fontWeight = fontWeight
        )
        Text(
            text = "$${String.format("%.2f", amount)}",
            fontSize = 14.sp,
            color = color,
            fontWeight = fontWeight
        )
    }
}

@Composable
fun CheckoutDialog(
    onDismiss: () -> Unit,
    onConfirm: () -> Unit,
    total: Double,
    paymentMethod: String,
    onPaymentMethodChange: (String) -> Unit
) {
    AlertDialog(
        onDismissRequest = onDismiss,
        title = { Text("Complete Purchase") },
        text = {
            Column {
                Text(
                    text = "Total: $${String.format("%.2f", total)}",
                    fontSize = 18.sp,
                    fontWeight = FontWeight.Bold,
                    modifier = Modifier.padding(bottom = 16.dp)
                )
                
                Text(
                    text = "Payment Method",
                    fontSize = 16.sp,
                    fontWeight = FontWeight.Medium,
                    modifier = Modifier.padding(bottom = 8.dp)
                )
                
                listOf("Credit Card", "PayPal", "Apple Pay", "Google Pay").forEach { method ->
                    Row(
                        verticalAlignment = Alignment.CenterVertically
                    ) {
                        RadioButton(
                            selected = paymentMethod == method,
                            onClick = { onPaymentMethodChange(method) }
                        )
                        Text(method)
                    }
                }
            }
        },
        confirmButton = {
            Button(onClick = onConfirm) {
                Text("Confirm Purchase")
            }
        },
        dismissButton = {
            TextButton(onClick = onDismiss) {
                Text("Cancel")
            }
        }
    )
}

fun getSampleCartItems(): List<CartItem> {
    return listOf(
        CartItem("1", "Wireless Headphones", 99.99, 1, description = "High-quality wireless headphones with noise cancellation"),
        CartItem("2", "Smartphone Case", 24.99, 2, description = "Protective case for your smartphone"),
        CartItem("3", "USB-C Cable", 15.99, 1, description = "Fast charging USB-C cable"),
        CartItem("4", "Bluetooth Speaker", 79.99, 1, description = "Portable Bluetooth speaker with great sound quality", inStock = false)
    )
}
