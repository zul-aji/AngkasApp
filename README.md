# AngkasApp: Soekarno-Hatta Airport Navigation App

Welcome to the repository for the **AngkasApp: Soekarno-Hatta Airport Navigation App**, a mobile solution developed as part of my bachelor's thesis. This project is designed to enhance the travel experience by providing efficient navigation and essential travel tools for one of Indonesia's largest and busiest airports.

## 📜 Project Overview

The **Soekarno-Hatta Airport Navigation App** addresses the challenges of navigating the complex layout of Soekarno-Hatta International Airport. It combines advanced pathfinding algorithms and user-friendly features to offer an intuitive and reliable guide for passengers. 

### Key Features
- **Smart Navigation**  
  - Utilizes the **A*** algorithm along with a **custom algorithm** to account for:
    - Multi-level structures of the airport.  
    - Diverse exits and entry points for optimized routes.
- **Real-time Flight Schedules**  
  - Stay updated with live flight information.  
- **Gate & Exit Guidance**  
  - Clear directions to gates, terminals, and exits.  
- **Personalized Reminders**  
  - Set reminders for flights and important travel milestones.  

### Core Objective
This app was developed to improve efficiency and convenience for travelers at Soekarno-Hatta Airport by integrating advanced pathfinding, user-centered design, and real-time data capabilities.

---

## 🛠️ Technologies Used

- **Android Development**  
  - **Flutter**  
- **Algorithms**  
  - **A*** pathfinding algorithm and a **custom heuristic algorithm** tailored for airport navigation.
- **Backend Integration**  
  - Real-time flight data APIs.
- **UI/UX Design**  
  - User-friendly and accessible interface.  

---

## 🎯 Use Case Scenarios

- **First-time Visitors**: Navigate the airport effortlessly with clear, step-by-step directions.  
- **Frequent Flyers**: Save time with efficient routes and personalized reminders.  

---

## 📖 Methodology

- **Pathfinding Algorithms**  
  - The A* algorithm calculates the shortest paths while considering the multi-level layout of the airport.
  - A custom heuristic was designed to account for factors like staircases, elevators, and gate locations.
- **Flight Data Integration**  
  - Real-time flight schedules are fetched via API calls and displayed in a user-friendly format.
- **Reminders & Notifications**  
  - Users can set reminders for flights, gate changes, or boarding times, with notifications delivered in-app.
