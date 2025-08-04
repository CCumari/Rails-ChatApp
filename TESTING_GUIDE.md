# Rails Chat Application - Testing Guide

## Test Users Available:
- **Username:** admin **Password:** password123
- **Username:** john_doe **Password:** password123  
- **Username:** jane_smith **Password:** password123

## How to Test:

1. **Visit the homepage** at http://localhost:3000
   - You should see a welcome page with test credentials

2. **Login** 
   - Click "Login to Chat" or go to http://localhost:3000/login
   - Use any of the test users above

3. **Test Chat Features**
   - Send messages in the chat interface
   - Open multiple browser tabs/windows with different users
   - Test real-time messaging between users
   - Verify auto-scroll functionality

4. **Test Authentication**
   - Try accessing /chat without logging in (should redirect to login)
   - Test logout functionality

## Features Implemented:
✅ User authentication with username/password
✅ Real-time chat using ActionCable
✅ Auto-scroll to latest messages
✅ Only loads last 50 messages for performance
✅ Semantic UI styling throughout
✅ Proper use of partials for code organization
✅ Form validation and error handling
✅ Session management
✅ Flash messages for user feedback

## Files Structure:
- Models: User, Message (with associations and validations)
- Controllers: Application, Sessions, Chat, Home
- Views: Organized with partials (_navigation, _flash_messages, _message)
- ActionCable: ChatRoomChannel for real-time messaging
- JavaScript: Auto-scroll, form handling, WebSocket connections
