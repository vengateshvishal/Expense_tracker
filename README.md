# Expense Tracker

A Flutter-based mobile application designed to help users manage their personal finances by tracking income and expenditures. This project integrates Firebase for real-time data storage and user authentication.

# Features

User Authentication: Secure Sign-in, Sign-up, and Forgot Password functionality powered by Firebase Auth.

Income & Expense Management: Easily add and categorize financial transactions.

Dashboard: A home screen to view a summary of your financial status.

Profile Management: View and manage user account details, including an option to delete the account.

Onboarding: A smooth introductory experience for new users.

# Project Structure

lib/Page/: Contains the UI screens such as home.dart, Signin.dart, and addExpense.dart.

lib/Services/: Handles backend logic, including authServices.dart for authentication and dataBase.dart for Firestore interactions.

lib/Widgets/: Reusable UI components like profileCard.dart.

Assets/: Stores images and SVG icons used throughout the application.

# Getting Started

# Prerequisites

Flutter SDK

Dart SDK

Firebase Project Setup

# Installation

# Clone the repository:

git clone https://github.com/vengateshvishal/expense_tracker.git

# Install dependencies:

flutter pub get

# Firebase Configuration:

Ensure the google-services.json file is correctly placed in the android/app/ directory.

The firebase_options.dart file is already configured for this project.

# Run the application:

flutter run