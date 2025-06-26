# QuickBill: Invoicing and Inventory Management App

**QuickBill** is an intuitive invoicing and inventory management app for small businesses. It helps shopkeepers manage inventory, generate invoices, track sales, and maintain a history of invoices. With Firebase integration, the app ensures data remains safe and accessible even if the app is deleted.

## Features:
- **Inventory Management**: Add, update, delete, and view inventory items with real-time updates.
- **Invoice Generation**: Generate invoices with selected items, including customer details, pricing, and total amount.
- **Recent Invoices**: View a history of recent invoices and total sales.
- **Theme Toggle**: Switch between light and dark themes for a better user experience.
- **Profile & Shop Details**: Manage user profile and shop information from the settings screen.

## Tech Stack:
- **Flutter**: A powerful UI framework used for building natively compiled applications for mobile, web, and desktop.
- **Riverpod**: A state management solution for handling app-wide state, including inventory and invoices.
- **Firebase**: A cloud platform used for authentication, Firestore (cloud database), and cloud storage.

## Getting Started:

1. **Clone the repository**:
   ```bash
   git clone https://github.com/your-username/quickbill.git


2. **Install Dependencies**:
    Ensure you have Flutter installed on your system.
    Navigate to the project folder and run:
    flutter pub get

3. **Setup Firebase**:
    Follow the Firebase setup guide to integrate Firebase into your Flutter app.
    Configure Firebase for both Android and iOS.
    Enable Firebase Firestore and Authentication (Google sign-in) in the Firebase console.
    Run the App:
    flutter run

4. **App Screens**:
    -Dashboard Screen: Displays total sales, recent invoices, and other key statistics.
    -Inventory Screen: Manage inventory items, update stock levels, and add new items.
    -Generate Invoice Screen: Select items, input customer details, and generate an invoice.
    -Settings Screen: Adjust settings such as theme preference, shop details, and user profile.

5. **Contributing**:
    I welcome contributions! Feel free to open issues or submit pull requests. Please ensure that your code adheres to the existing coding style.
    To get started with contributing:
    -Fork the repository and create a new branch for your changes.
    -Make your changes and run tests.
    -Submit a pull request, describing the changes you’ve made.