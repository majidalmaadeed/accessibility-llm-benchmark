import { Component, OnInit } from '@angular/core';

interface CartItem {
  id: number;
  name: string;
  price: number;
  quantity: number;
  image: string;
  inStock: boolean;
  maxQuantity: number;
}

interface PromoCode {
  discount: number;
  type: 'percentage' | 'shipping' | 'fixed';
  description: string;
}

interface ShippingOption {
  id: string;
  name: string;
  price: number;
  days: string;
}

@Component({
  selector: 'app-shopping-cart-system',
  templateUrl: './shopping-cart-system.component.html',
  styleUrls: ['./shopping-cart-system.component.css']
})
export class ShoppingCartSystemComponent implements OnInit {
  cartItems: CartItem[] = [
    {
      id: 1,
      name: 'Wireless Bluetooth Headphones',
      price: 99.99,
      quantity: 1,
      image: 'https://via.placeholder.com/80x80/4caf50/fff?text=🎧',
      inStock: true,
      maxQuantity: 5
    },
    {
      id: 2,
      name: 'Smart Fitness Watch',
      price: 199.99,
      quantity: 2,
      image: 'https://via.placeholder.com/80x80/2196f3/fff?text=⌚',
      inStock: true,
      maxQuantity: 3
    },
    {
      id: 3,
      name: 'USB-C Charging Cable',
      price: 19.99,
      quantity: 1,
      image: 'https://via.placeholder.com/80x80/ff9800/fff?text=🔌',
      inStock: false,
      maxQuantity: 10
    }
  ];

  promoCode: string = '';
  appliedPromo: PromoCode | null = null;
  shippingOption: string = 'standard';
  showPromoForm: boolean = false;
  isCheckingOut: boolean = false;

  shippingOptions: ShippingOption[] = [
    { id: 'standard', name: 'Standard Shipping', price: 5.99, days: '5-7 business days' },
    { id: 'express', name: 'Express Shipping', price: 12.99, days: '2-3 business days' },
    { id: 'overnight', name: 'Overnight Shipping', price: 24.99, days: 'Next business day' }
  ];

  promoCodes: { [key: string]: PromoCode } = {
    'SAVE10': { discount: 0.1, type: 'percentage', description: '10% off your order' },
    'FREESHIP': { discount: 0, type: 'shipping', description: 'Free standard shipping' },
    'WELCOME20': { discount: 20, type: 'fixed', description: '$20 off your order' }
  };

  constructor() { }

  ngOnInit(): void {
  }

  updateQuantity(id: number, newQuantity: number): void {
    if (newQuantity < 1) return;
    
    this.cartItems = this.cartItems.map(item => {
      if (item.id === id) {
        const updatedQuantity = Math.min(newQuantity, item.maxQuantity);
        return { ...item, quantity: updatedQuantity };
      }
      return item;
    });
  }

  removeItem(id: number): void {
    this.cartItems = this.cartItems.filter(item => item.id !== id);
  }

  applyPromoCode(): void {
    const promo = this.promoCodes[this.promoCode.toUpperCase()];
    if (promo) {
      this.appliedPromo = promo;
      this.promoCode = '';
      this.showPromoForm = false;
    } else {
      alert('Invalid promo code');
    }
  }

  removePromoCode(): void {
    this.appliedPromo = null;
  }

  getPromoCodeName(): string {
    return Object.keys(this.promoCodes).find(code => this.promoCodes[code] === this.appliedPromo) || '';
  }

  calculateSubtotal(): number {
    return this.cartItems.reduce((total, item) => total + (item.price * item.quantity), 0);
  }

  calculateShipping(): number {
    if (this.appliedPromo && this.appliedPromo.type === 'shipping') {
      return 0;
    }
    return this.shippingOptions.find(option => option.id === this.shippingOption)?.price || 0;
  }

  calculateDiscount(): number {
    if (!this.appliedPromo) return 0;
    
    const subtotal = this.calculateSubtotal();
    
    switch (this.appliedPromo.type) {
      case 'percentage':
        return subtotal * this.appliedPromo.discount;
      case 'fixed':
        return this.appliedPromo.discount;
      default:
        return 0;
    }
  }

  calculateTotal(): number {
    const subtotal = this.calculateSubtotal();
    const shipping = this.calculateShipping();
    const discount = this.calculateDiscount();
    return subtotal + shipping - discount;
  }

  async handleCheckout(): Promise<void> {
    if (this.cartItems.length === 0) {
      alert('Your cart is empty');
      return;
    }

    this.isCheckingOut = true;
    
    // Simulate checkout process
    setTimeout(() => {
      console.log('Checkout completed:', {
        items: this.cartItems,
        subtotal: this.calculateSubtotal(),
        shipping: this.calculateShipping(),
        discount: this.calculateDiscount(),
        total: this.calculateTotal(),
        promoCode: this.appliedPromo
      });
      this.isCheckingOut = false;
      alert('Order placed successfully!');
    }, 2000);
  }

  getItemTotal(item: CartItem): number {
    return item.price * item.quantity;
  }

  hasOutOfStockItems(): boolean {
    return this.cartItems.some(item => !item.inStock);
  }

  getSelectedShippingOption(): ShippingOption | undefined {
    return this.shippingOptions.find(option => option.id === this.shippingOption);
  }
}
