// Prevents additional console window on Windows in release, DO NOT REMOVE!!
#![cfg_attr(not(debug_assertions), windows_subsystem = "windows")]

use tauri::Manager;

fn main() {
    tauri::Builder::default()
        .invoke_handler(tauri::generate_handler![
            get_data_table_data,
            get_wizard_data,
            get_dashboard_data,
            get_media_player_data,
            get_shopping_cart_data,
            get_calendar_data,
            get_rich_text_data,
            get_search_data,
            get_map_data,
            get_social_feed_data
        ])
        .run(tauri::generate_context!())
        .expect("error while running tauri application");
}

#[tauri::command]
fn get_data_table_data() -> String {
    serde_json::json!({
        "employees": [
            {
                "id": 1,
                "name": "John Smith",
                "email": "john.smith@company.com",
                "department": "Engineering",
                "position": "Senior Developer",
                "salary": 95000,
                "status": "Active"
            },
            {
                "id": 2,
                "name": "Sarah Johnson",
                "email": "sarah.johnson@company.com",
                "department": "Marketing",
                "position": "Marketing Manager",
                "salary": 78000,
                "status": "Active"
            },
            {
                "id": 3,
                "name": "Mike Wilson",
                "email": "mike.wilson@company.com",
                "department": "Sales",
                "position": "Sales Representative",
                "salary": 65000,
                "status": "Active"
            }
        ]
    }).to_string()
}

#[tauri::command]
fn get_wizard_data() -> String {
    serde_json::json!({
        "steps": [
            {
                "id": 1,
                "title": "Personal Information",
                "fields": ["firstName", "lastName", "email", "phone", "dateOfBirth"]
            },
            {
                "id": 2,
                "title": "Account Details",
                "fields": ["username", "password", "confirmPassword", "securityQuestion", "securityAnswer"]
            },
            {
                "id": 3,
                "title": "Preferences",
                "fields": ["newsletter", "promotions", "updates", "timezone", "language", "bio"]
            },
            {
                "id": 4,
                "title": "Review",
                "fields": []
            }
        ]
    }).to_string()
}

#[tauri::command]
fn get_dashboard_data() -> String {
    serde_json::json!({
        "revenue": {
            "total": 125000,
            "recurring": 85000,
            "oneTime": 40000
        },
        "engagement": {
            "sessions": 12543,
            "duration": "2:34",
            "bounceRate": 68,
            "pagesPerSession": 4.2
        },
        "conversion": {
            "visitors": 10000,
            "productViews": 7500,
            "addToCart": 2250,
            "checkout": 1125,
            "purchase": 900
        }
    }).to_string()
}

#[tauri::command]
fn get_media_player_data() -> String {
    serde_json::json!({
        "playlist": [
            {
                "id": 1,
                "title": "Sample Video 1",
                "duration": "5:30",
                "thumbnail": "📹"
            },
            {
                "id": 2,
                "title": "Sample Video 2",
                "duration": "3:45",
                "thumbnail": "📹"
            },
            {
                "id": 3,
                "title": "Sample Video 3",
                "duration": "7:20",
                "thumbnail": "📹"
            }
        ],
        "settings": {
            "quality": "auto",
            "speed": 1.0,
            "subtitles": "off"
        }
    }).to_string()
}

#[tauri::command]
fn get_shopping_cart_data() -> String {
    serde_json::json!({
        "items": [
            {
                "id": 1,
                "name": "iPhone 15 Pro",
                "brand": "Apple",
                "price": 999.00,
                "quantity": 1,
                "sku": "IPH15P-256-BLU"
            },
            {
                "id": 2,
                "name": "AirPods Pro",
                "brand": "Apple",
                "price": 249.00,
                "quantity": 2,
                "sku": "APP-GEN2"
            },
            {
                "id": 3,
                "name": "iPhone Case",
                "brand": "Apple",
                "price": 49.00,
                "quantity": 1,
                "sku": "CASE-IPH15-CLR"
            }
        ],
        "shipping": {
            "standard": 0,
            "express": 9.99,
            "overnight": 19.99
        }
    }).to_string()
}

#[tauri::command]
fn get_calendar_data() -> String {
    serde_json::json!({
        "events": [
            {
                "id": 1,
                "title": "Team Meeting",
                "date": "2024-12-15",
                "time": "10:00",
                "duration": 60,
                "category": "work",
                "location": "Conference Room A"
            },
            {
                "id": 2,
                "title": "Doctor Appointment",
                "date": "2024-12-18",
                "time": "14:30",
                "duration": 30,
                "category": "personal",
                "location": "Medical Center"
            }
        ],
        "categories": ["work", "personal", "meetings", "travel"]
    }).to_string()
}

#[tauri::command]
fn get_rich_text_data() -> String {
    serde_json::json!({
        "document": {
            "title": "Sample Document",
            "content": "This is a sample rich text document with various formatting options.",
            "wordCount": 0,
            "charCount": 0,
            "pageCount": 1
        },
        "history": [],
        "settings": {
            "fontFamily": "Arial",
            "fontSize": 16,
            "textColor": "#000000",
            "backgroundColor": "transparent"
        }
    }).to_string()
}

#[tauri::command]
fn get_search_data() -> String {
    serde_json::json!({
        "products": [
            {
                "id": 1,
                "title": "iPhone 15 Pro",
                "brand": "Apple",
                "category": "electronics",
                "price": 999,
                "rating": 4.8,
                "image": "📱"
            },
            {
                "id": 2,
                "title": "Samsung Galaxy S24",
                "brand": "Samsung",
                "category": "electronics",
                "price": 899,
                "rating": 4.6,
                "image": "📱"
            }
        ],
        "filters": {
            "categories": ["electronics", "clothing", "home", "sports"],
            "brands": ["Apple", "Samsung", "Sony", "LG"],
            "ratings": [5, 4, 3]
        }
    }).to_string()
}

#[tauri::command]
fn get_map_data() -> String {
    serde_json::json!({
        "locations": [
            {
                "id": 1,
                "name": "Central Park",
                "category": "attraction",
                "x": 30,
                "y": 25,
                "address": "New York, NY"
            },
            {
                "id": 2,
                "name": "Times Square",
                "category": "attraction",
                "x": 45,
                "y": 30,
                "address": "New York, NY"
            }
        ],
        "layers": ["traffic", "transit", "bike", "satellite"]
    }).to_string()
}

#[tauri::command]
fn get_social_feed_data() -> String {
    serde_json::json!({
        "posts": [
            {
                "id": 1,
                "username": "Sarah Wilson",
                "avatar": "SW",
                "timestamp": "2 hours ago",
                "text": "Just finished an amazing hike in the mountains!",
                "likes": 24,
                "retweets": 8,
                "comments": 12
            },
            {
                "id": 2,
                "username": "Tech News",
                "avatar": "TN",
                "timestamp": "4 hours ago",
                "text": "Breaking: New AI breakthrough could revolutionize healthcare.",
                "likes": 156,
                "retweets": 89,
                "comments": 34
            }
        ]
    }).to_string()
}
