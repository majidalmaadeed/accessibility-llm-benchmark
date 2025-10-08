<template>
  <div class="main-container">
    <div class="main-content">
      <h1>Product Filter</h1>
      
      
      <div class="filter-section">
        <label 
          for="category-filter" 
          class="filter-label"
        >
          Filter by Category:
        </label>
        <div class="custom-dropdown" ref="dropdownRef">
          <button
            ref="triggerRef"
            id="category-filter"
            @click="toggleDropdown"
            @keydown="handleKeyDown"
            :aria-expanded="isOpen"
            aria-haspopup="listbox"
            aria-labelledby="category-filter-label"
            :aria-activedescendant="isOpen ? `option-${currentIndex}` : undefined"
            class="dropdown-trigger"
            :class="{ open: isOpen }"
          >
            <span>{{ selectedText }}</span>
            <span class="dropdown-arrow" :class="{ rotated: isOpen }">▼</span>
          </button>
          
          <div
            v-if="isOpen"
            role="listbox"
            aria-labelledby="category-filter-label"
            class="dropdown-menu"
          >
            <div
              v-for="(option, index) in options"
              :key="option.value"
              :ref="el => setOptionRef(el, index)"
              :id="`option-${index}`"
              role="option"
              :aria-selected="selectedValue === option.value"
              :tabindex="index === currentIndex ? 0 : -1"
              @click="selectOption(option.value, option.text, index)"
              @keydown="handleOptionKeyDown($event, option.value, option.text, index)"
              @mouseenter="currentIndex = index"
              class="dropdown-option"
              :class="{ selected: selectedValue === option.value }"
            >
              {{ option.text }}
            </div>
          </div>
        </div>
      </div>
      
      <div class="results-section">
        <h2>Filtered Results</h2>
        <div class="results-grid">
          <div
            v-for="(product, index) in filteredProducts"
            :key="index"
            class="result-card"
          >
            <h3>{{ product.name }}</h3>
            <p>{{ product.category }}</p>
          </div>
        </div>
      </div>
    </div>

  </div>
</template>

<script>
import { ref, computed, onMounted, onUnmounted } from 'vue'

export default {
  name: 'CustomDropdownNavigation',
  setup() {
    const isOpen = ref(false)
    const selectedValue = ref('all')
    const selectedText = ref('All Categories')
    const currentIndex = ref(0)
    const dropdownRef = ref(null)
    const triggerRef = ref(null)
    const optionsRef = ref([])

    const options = [
      { value: 'all', text: 'All Categories' },
      { value: 'electronics', text: 'Electronics' },
      { value: 'clothing', text: 'Clothing' },
      { value: 'books', text: 'Books' },
      { value: 'home', text: 'Home & Garden' }
    ]

    const products = {
      all: [
        { name: 'iPhone 15', category: 'Electronics' },
        { name: 'MacBook Pro', category: 'Electronics' },
        { name: 'Cotton T-Shirt', category: 'Clothing' },
        { name: 'JavaScript Guide', category: 'Books' },
        { name: 'Garden Tools', category: 'Home & Garden' }
      ],
      electronics: [
        { name: 'iPhone 15', category: 'Electronics' },
        { name: 'MacBook Pro', category: 'Electronics' }
      ],
      clothing: [
        { name: 'Cotton T-Shirt', category: 'Clothing' }
      ],
      books: [
        { name: 'JavaScript Guide', category: 'Books' }
      ],
      home: [
        { name: 'Garden Tools', category: 'Home & Garden' }
      ]
    }

    const filteredProducts = computed(() => {
      return products[selectedValue.value] || []
    })

    const setOptionRef = (el, index) => {
      if (el) {
        optionsRef.value[index] = el
      }
    }

    const toggleDropdown = () => {
      isOpen.value = !isOpen.value
      if (isOpen.value) {
        // Focus first option when opening
        setTimeout(() => {
          if (optionsRef.value[0]) {
            optionsRef.value[0].focus()
          }
        }, 0)
      }
    }

    const selectOption = (value, text, index) => {
      selectedValue.value = value
      selectedText.value = text
      currentIndex.value = index
      isOpen.value = false
      // Return focus to trigger
      if (triggerRef.value) {
        triggerRef.value.focus()
      }
    }

    const handleKeyDown = (event) => {
      if (!isOpen.value) {
        if (event.key === 'Enter' || event.key === ' ') {
          event.preventDefault()
          toggleDropdown()
        }
        return
      }

      switch (event.key) {
        case 'ArrowDown':
          event.preventDefault()
          const nextIndex = currentIndex.value < options.length - 1 ? currentIndex.value + 1 : 0
          currentIndex.value = nextIndex
          if (optionsRef.value[nextIndex]) {
            optionsRef.value[nextIndex].focus()
          }
          break
        case 'ArrowUp':
          event.preventDefault()
          const prevIndex = currentIndex.value > 0 ? currentIndex.value - 1 : options.length - 1
          currentIndex.value = prevIndex
          if (optionsRef.value[prevIndex]) {
            optionsRef.value[prevIndex].focus()
          }
          break
        case 'Enter':
        case ' ':
          event.preventDefault()
          selectOption(options[currentIndex.value].value, options[currentIndex.value].text, currentIndex.value)
          break
        case 'Escape':
          isOpen.value = false
          if (triggerRef.value) {
            triggerRef.value.focus()
          }
          break
      }
    }

    const handleOptionKeyDown = (event, value, text, index) => {
      if (event.key === 'Enter' || event.key === ' ') {
        event.preventDefault()
        selectOption(value, text, index)
      } else if (event.key === 'Escape') {
        isOpen.value = false
        if (triggerRef.value) {
          triggerRef.value.focus()
        }
      }
    }

    const handleClickOutside = (event) => {
      if (dropdownRef.value && !dropdownRef.value.contains(event.target)) {
        isOpen.value = false
      }
    }

    onMounted(() => {
      document.addEventListener('mousedown', handleClickOutside)
    })

    onUnmounted(() => {
      document.removeEventListener('mousedown', handleClickOutside)
    })

    return {
      isOpen,
      selectedValue,
      selectedText,
      currentIndex,
      dropdownRef,
      triggerRef,
      optionsRef,
      options,
      filteredProducts,
      setOptionRef,
      toggleDropdown,
      selectOption,
      handleKeyDown,
      handleOptionKeyDown
    }
  }
}
</script>

<style scoped>
.main-container {
  font-family: Arial, sans-serif;
  max-width: 800px;
  margin: 50px auto;
  padding: 20px;
  background-color: #f5f5f5;
}

.main-content {
  background: white;
  padding: 30px;
  border-radius: 8px;
  box-shadow: 0 2px 10px rgba(0,0,0,0.1);
}

.filter-section {
  margin-bottom: 30px;
}

.filter-label {
  display: block;
  margin-bottom: 10px;
  font-weight: bold;
  color: #333;
}

.custom-dropdown {
  position: relative;
  display: inline-block;
  width: 200px;
}

.dropdown-trigger {
  background-color: #f8f9fa;
  border: 2px solid #ddd;
  border-radius: 4px;
  padding: 12px 16px;
  cursor: pointer;
  display: flex;
  justify-content: space-between;
  align-items: center;
  font-size: 16px;
  width: 100%;
  box-sizing: border-box;
}

.dropdown-trigger:hover {
  border-color: #007bff;
}

.dropdown-trigger:focus {
  outline: none;
  border-color: #007bff;
  box-shadow: 0 0 0 2px rgba(0, 123, 255, 0.25);
}

.dropdown-trigger.open {
  border-color: #007bff;
  border-bottom-left-radius: 0;
  border-bottom-right-radius: 0;
}

.dropdown-arrow {
  transition: transform 0.2s ease;
}

.dropdown-arrow.rotated {
  transform: rotate(180deg);
}

.dropdown-menu {
  position: absolute;
  top: 100%;
  left: 0;
  right: 0;
  background: white;
  border: 2px solid #007bff;
  border-top: none;
  border-radius: 0 0 4px 4px;
  box-shadow: 0 4px 12px rgba(0,0,0,0.15);
  z-index: 1000;
}

.dropdown-option {
  padding: 12px 16px;
  cursor: pointer;
  border-bottom: 1px solid #eee;
  transition: background-color 0.2s ease;
}

.dropdown-option:last-child {
  border-bottom: none;
}

.dropdown-option:hover {
  background-color: #f8f9fa;
}

.dropdown-option.selected {
  background-color: #007bff;
  color: white;
}

.dropdown-option.selected:hover {
  background-color: #0056b3;
}

.results-section {
  margin-top: 30px;
}

.results-grid {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(200px, 1fr));
  gap: 20px;
  margin-top: 20px;
}

.result-card {
  background: white;
  border: 1px solid #ddd;
  border-radius: 8px;
  padding: 20px;
  text-align: center;
  box-shadow: 0 2px 4px rgba(0,0,0,0.1);
}

.result-card h3 {
  margin: 0 0 10px 0;
  color: #333;
}

.result-card p {
  margin: 0;
  color: #666;
}

</style>