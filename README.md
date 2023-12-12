# Flashzilla

## Overview
Flashzilla is an interactive flashcard application designed to help users learn various topics through a simple and engaging interface. 

## Features
- **Flashcard Learning**: Users interact with flashcards, each showing a prompt and an answer, to test and reinforce their knowledge.
- **Dynamic Interaction**: Cards can be swiped away based on whether the user knows the answer, providing an intuitive learning experience.
- **Timer-Based Sessions**: Each learning session is timed, adding a sense of urgency and gamification.
- **Customizable Card Decks**: Users can add, modify, and delete cards, allowing them to customize their learning experience.
- **Accessibility Support**: The app includes accessibility features like VoiceOver and color differentiation support.

## Implementation
- **Card Creation and Management**: Users can create new cards and edit existing ones.
- **Drag Gestures**: SwiftUI's `DragGesture` is used to implement the card swiping mechanism.
- **Data Persistence**: Cards are saved locally, ensuring that user data is retained across app launches.
- **Timer Integration**: A countdown timer is implemented for each learning session.

## Code Structure
- `Card`: A struct representing a single flashcard with a prompt and an answer.
- `CardStore`: A class managing the collection of cards and handling data persistence.
- `CardView`: A SwiftUI view displaying the content of a flashcard with interactive swipe gestures.
- `ContentView`: The main view of the app, orchestrating the user interface and interactions.
- `EditCards`: A view allowing users to add and edit flashcards in their collection.

## Challenges and Learnings
- Mastering SwiftUI's `DragGesture` to create a fluid card-swipe interface.
- Implementing data persistence to save and load flashcards.
- Designing a user-friendly interface that accommodates various accessibility needs.

## Future Enhancements
- Integration with online databases for a wider range of learning topics.
- Implementation of spaced repetition algorithms for improved learning efficiency.
- Addition of multiplayer or social features for collaborative learning.

---

*Flashzilla is part of the "100 Days of SwiftUI" course, showcasing advanced SwiftUI techniques and user interface design.*

---
