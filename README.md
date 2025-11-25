This is the first commit for buddy ai. My  PLP final project that will be built with flutter-dart.

# Buddy AI - Mental Health Safe Space App

## Overview
Buddy AI is a mental health platform providing anonymous community support through secret chats, educational blogs, and a welcoming landing page.

## Features
1. **Landing Page** - Hero section with app branding and navigation
2. **Authentication** - Login and sign-up for users
3. **Secret Chats** - Anonymous topic-based discussions (requires login)
4. **About Page** - App information (public)
5. **Blog Page** - Mental health articles from app owner (public)

## Technical Stack
- **State Management**: Provider
- **Navigation**: go_router
- **Storage**: Local Storage (shared_preferences)
- **UI**: Custom sleek design with specified color palette

## Color Palette
- Primary Light Yellow: #f1e47f
- Primary Green: #7ca750  
- Secondary Green: #739d43
- Light Green: #cde5c5
- Dark Background: #070c06

## Architecture

### Data Models (`lib/models/`)
1. **User** - id, email, password, displayName, createdAt, updatedAt
2. **Topic** - id, title, commentCount, createdAt, updatedAt
3. **Comment** - id, topicId, userId, content, isAnonymous, createdAt, updatedAt
4. **Blog** - id, title, content, imageUrl, authorId, createdAt, updatedAt

### Services (`lib/services/`)
1. **AuthService** - Login, signup, logout, current user management
2. **TopicService** - CRUD operations for topics and comments
3. **BlogService** - Read operations for blogs
4. **StorageService** - Local storage wrapper using shared_preferences

### Screens (`lib/screens/`)
1. **LandingPage** - Hero section with branding and navigation
2. **LoginPage** - Email/password authentication
3. **SignUpPage** - New user registration
4. **SecretChatsPage** - List of discussion topics (protected)
5. **TopicDetailPage** - View topic and comments with add comment feature
6. **AboutPage** - App information
7. **BlogListPage** - Display all blogs
8. **BlogDetailPage** - Read full blog post

### Providers (`lib/providers/`)
1. **AuthProvider** - Manages authentication state

### Routing
- `/` - Landing page
- `/login` - Login page
- `/signup` - Sign up page
- `/secret-chats` - Secret chats list (protected)
- `/topic/:id` - Topic detail (protected)
- `/about` - About page
- `/blogs` - Blog list
- `/blog/:id` - Blog detail

## Implementation Status: ✅ COMPLETE

All features have been successfully implemented:

### Completed Components
- ✅ Custom theme with brand color palette (#f1e47f, #7ca750, #739d43, #cde5c5, #070c06)
- ✅ Data models: User, Topic, Comment, Blog
- ✅ Services: AuthService, TopicService, BlogService, StorageService
- ✅ Auth provider with state management
- ✅ All 8 screens with modern UI design
- ✅ Protected routing with go_router
- ✅ Sample data initialized (5 users, 5 topics with 20 comments, 5 blogs)

### Sample Data Included
- 5 dummy users (alex.miller, sarah.jones, michael.chen, emma.wilson, david.brown)
- 5 discussion topics (anxiety, work stress, motivation, sleep, emotions)
- 20 anonymous comments (4 per topic)
- 5 blog posts with images and 2-paragraph content each
