# 🛒 E-Commerce App

A full-stack mobile application for managing products, users, and transactions.  
Built with a focus on clean architecture, scalability, and real-world system design.

---

## 🚀 Features

### 👤 Authentication & Authorization

- JWT-based authentication
- Secure login and signup
- Role-based access control (Admin / Merchant / Customer)

### 🛍️ Product Management

- Add, update, and delete products (Merchant)
- Structured product listings
- Category-based organization

### 🛒 Cart System

- Add and remove items from cart
- Persistent cart handling
- Dynamic price calculation

### 🔍 Search Functionality

- Search products by **name and category**
- Case-insensitive filtering
- Backend-powered query system

### 💳 Payments

- Razorpay payment gateway integration
- Secure checkout process

### 👤 User Profile

- Manage personal user data
- Profile update functionality

---

## 🛠️ Tech Stack

### Frontend

- Flutter
- Bloc (State Management)

### Backend

- Node.js
- Express.js
- RESTful APIs

### Database

- MongoDB (Mongoose)
- SQL (for structured data handling)

### Integrations

- Razorpay Payment Gateway

---

## 🧩 Architecture

This project follows a **Clean Architecture approach**:

- **Presentation Layer** → UI + Bloc
- **Domain Layer** → Business logic & use cases
- **Data Layer** → Repositories & API calls

This ensures:

- Better scalability
- Maintainable codebase
- Clear separation of concerns

---

## 🔄 Application Workflow

### 👤 Customer Flow

1. User registers or logs in
2. User browses product catalog
3. User searches products (name/category)
4. User adds items to cart
5. User proceeds to payment
6. Order is processed

---

### 🛍️ Merchant/Admin Flow

1. Merchant logs in with role-based access
2. Merchant adds new products with details (name, price, category, etc.)
3. Merchant updates or deletes existing products
4. Merchant manages product listings and availability
5. Merchant monitors orders and system activity

🚧 Future Improvements

- Order history & tracking
- Wishlist functionality
- Push notifications
- Admin dashboard analytics
- Performance optimizations


📫 Contact
1. GitHub: https://github.com/AyushMusale
2. LinkedIn: https://www.linkedin.com/in/ayushmusale

> “Discipline over motivation. Systems over hacks.”
