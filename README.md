# Supermarket Checkout System

A **Flutter application** for managing supermarket checkout processes, including product listing, adding/removing items to/from a cart, and applying promotions like "Buy N Get One Free". 

---

## Packages Used

| Package Name                        | Description                                      |
|-------------------------------------|--------------------------------------------------|
| `flutter_bloc`                      | Implements the BLoC pattern for state management.|
| `go_router`                         | Provides declarative routing for navigation.     |
| `mocktail`                          | A testing library for mocking classes.           |
| `flutter_test`                      | Flutter's built-in testing library.              |
| `bloc_test`                         | Helps test BLoC states and transitions.          |

---

## Features

1. **Product Listing**  
   - Displays a list of products fetched from the repository.  
   - Supports adding/removing items to/from the cart.

2. **Cart Management**  
   - Real-time cart updates (item count, promotions, discounts, and totals).  
   - Applies "Buy N Get One Free" promotions automatically.

3. **Checkout Page**  
   - Displays detailed pricing (product price, discounts, and final price).  
   - Shows total items and promotions applied.

4. **State Management**  
   - Uses **Bloc** to handle UI state and business logic efficiently.  

5. **Testing**  
   - Comprehensive widget and cubit tests to ensure reliability.

---

## Project Structure

The project follows the **Clean Architecture** approach:

```
lib/
│
├── core/                      # Core utilities and constants
│   ├── app_colors.dart        # App color constants
│   └── service_locator.dart   # Dependency injection setup
│
├── features/checkout/         # Checkout feature
│   ├── domain/                # Business logic layer
│   │   ├── entities/          # Data models (e.g., Item, Promotion)
│   │   ├── repositories/      # Abstract repository classes
│   │   └── usecases/          # Use cases (e.g., CalculateTotal)
│   ├── presentation/          # UI layer
│   │   ├── cubit/             # BLoC (Cubit) for state management
│   │   ├── screens/           # Screens (e.g., ProductListPage, CheckoutPage)
│   │   └── widgets/           # Reusable UI widgets
│   
└── app_routers.dart           # Router setup
└── main.dart                  # Run app setup

```

---

## Setup and Installation

1. **Clone the repository**:
   ```bash
   git clone https://github.com/your_username/supermarket_checkout.git
   cd supermarket_checkout
   ```

2. **Install dependencies**:
   ```bash
   flutter pub get
   ```

3. **Run the project**:
   ```bash
   flutter run
   ```

4. **Run tests**:
   ```bash
   flutter test
   ```

---

## How to Run the Project

To run the project locally:

1. Make sure you have **Flutter** installed. If not, follow the [Flutter installation guide](https://flutter.dev/docs/get-started/install).
2. Navigate to the project directory:
   ```bash
   cd supermarket_checkout
   ```
3. Install dependencies:
   ```bash
   flutter pub get
   ```
4. Run the project on a connected device or emulator:
   ```bash
   flutter run
   ```
5. To execute tests:
   ```bash
   flutter test
   ```

---

## Testing

This project includes unit tests and widget tests for ensuring code reliability.

### Key Test Areas:
- **Cubit Testing**: Ensures correct state transitions for cart management.
- **Widget Testing**: Verifies UI updates based on Bloc states.
- **Promotion Logic Testing**: Validates "Buy N Get One Free" and pricing calculations.

To execute tests, run:
```bash
flutter test
```
---

## Contact

For questions or feedback, please contact:

- **Name**: Mona Verma  
- **Email**: mn.monaverma@gmail.com  
- **LinkedIn**: https://linkedin.com/in/mona-v-verma

---

