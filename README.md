# 📦 **QuickBill: Invoicing and Inventory Management App**

**QuickBill** is an intuitive invoicing and inventory management app for small businesses. It helps shopkeepers manage inventory, generate invoices, track sales, and maintain a history of invoices. With Firebase integration, the app ensures data remains safe and accessible even if the app is deleted.

## ✨ **Features**

🧾 **Invoice Generation**:
  Generate invoices with customer details, itemized pricing, taxes, and auto-calculated totals.

📦 **Inventory Management**:
Add, edit, delete, and monitor stock items with real-time updates.

📊 **Sales Dashboard**:
View total sales, recent invoices, and performance stats in one glance.

🌙 **Theme Toggle**:
Switch between light and dark mode for a personalized experience.

## 📱 App Screens

📊 **Dashboard Screen**:  
  View total sales, recent invoices, and key business stats.  

📦 **Inventory Screen**:  
  Add or update stock, manage product information, and track availability.

🧾 **Generate Invoice Screen**:  
  Create invoices by selecting products, entering customer details, and setting quantities.

📈 **Insights Screen**:  
  Analyze annual and monthly sales trends, and discover top-selling products.

⚙️ **Settings Screen**:  
  Toggle between light and dark themes for a customized experience.

## 🛠️ Tech Stack

**Flutter**: A powerful UI framework used for building natively compiled applications for mobile, web, and desktop.

**Riverpod**: A state management solution for handling app-wide state, including inventory and invoices.

**Firebase**: A cloud platform used for authentication, Firestore (cloud database), and cloud storage.

## 🚀 Getting Started:

**1. Clone the Repository**

git clone https://github.com/gaara40/QuickBill.git

**2. Install Dependencies**

Make sure Flutter is installed on your system, then run:

flutter pub get

**3. Firebase Setup**

Integrate Firebase into your Flutter app:

-Follow the official Firebase Flutter Setup Guide.

-Configure both Android and iOS platforms.

-Enable Authentication for email and password and Cloud Firestore in your Firebase Console.

-Download the google-services.json (for Android) and/or GoogleService-Info.plist (for iOS) and place them in the respective platform directories.

**4. Run the App**

-> flutter run

## 🤝 Contributing
Contributions are welcome! To contribute:

-Fork the repository

-Create a new branch for your feature or bugfix

-Commit your changes with descriptive messages

-Run and test your changes locally

-Open a pull request, explaining your changes

**Please follow the existing coding style and project structure.**

## 🔐 Firebase Auth Note
Each contributor's data will be saved under their Firebase credentials. Users are authenticated individually via Firebase Auth, ensuring isolated and secure access to their inventory and invoice data.