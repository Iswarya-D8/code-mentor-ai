# Personal AI Mentor Web Application Requirements Document

## 1. Application Overview

### 1.1 Application Name
Personal AI Mentor Platform

### 1.2 Application Description
An AI-powered full-stack web application designed to serve as a personal mentor for students and job seekers, helping them discover opportunities, practice coding, manage schedules, and track performance progress.

### 1.3 Target Users
Students and job seekers looking for internships, jobs, hackathons, and scholarships while improving their coding skills and productivity.

---

## 2. Core Functional Modules

### 2.1 Authentication System
- Secure user registration and login using email and password
- Clean, minimal, and professional authentication UI
- Automatic redirect to Dashboard after successful login
- Secure session management and user state persistence

### 2.2 Dashboard
- Personalized welcome message displaying user name\n- Today's focus summary section
- Performance snapshot overview
- Daily progress tracker showing solved problems vs daily target
- Sidebar navigation menu including:\n  - Dashboard
  - Present Opportunities\n  - Coding Practice
  - Smart Schedule
  - Performance Analytics\n  - Emails
  - Profile\n- Card-based layout with icons and smooth animations

### 2.3 Present Opportunities Module\n- **Real-World Opportunities Database**:
  - Display authentic opportunities including:
    - **Internships**: Google STEP Internship, Microsoft Explore Program, Amazon SDE Intern, Meta University, Goldman Sachs Summer Analyst
    - **Jobs**: Software Engineer at Stripe, Product Manager at Notion, Data Scientist at Airbnb, Frontend Developer at Vercel\n    - **Hackathons**: MLH Season Hackathons, Google Solution Challenge, MIT COVID-19 Challenge, NASA Space Apps Challenge
    - **Scholarships**: Google Generation Scholarship, Palantir Women in Technology Scholarship, GitHub Campus Experts Program, Oracle Academy Scholarship
  - Opportunities continuously updated with real-world data sources
\n- **Opportunity Data Structure**:
  Each opportunity contains:
  - **Title**: Full opportunity name
  - **Organization Name**: Company, university, or organizing body
  - **Category**: Internship / Job / Hackathon / Scholarship
  - **Start Date**: Opportunity opening date (when applications begin)
  - **End Date**: Application deadline
  - **Official Application URL**: Direct link to apply on organization's website
  - **Short Description**: Brief overview of opportunity, requirements, and benefits (2-3 sentences)
  - **Status Badge**: Automatically determined based on current date

- **Dynamic Status Classification**:
  Automatic status determination using date-based logic:
  - **Upcoming**: Start Date > today (applications not yet open)
  - **Open**: Start Date ≤ today ≤ End Date (currently accepting applications)
  - **Closed**: End Date < today (deadline passed, automatically hidden from display)
\n- **Display Logic**:
  - Show only **Open** and **Upcoming** opportunities in main interface
  - Automatically hide or archive **Closed** opportunities
  - Tab-based navigation:\n    - **Open Tab**: Display currently accepting applications
    - **Upcoming Tab**: Display future opportunities with start dates ahead
  - No manual intervention required for status updates

- **Sorting and Organization**:
  - Primary sort: Closest deadline (End Date ascending)
  - Secondary sort: Relevance score based on user profile and preferences
  - Category filters: All / Internships / Jobs / Hackathons / Scholarships
\n- **Visual Indicators**:
  - Color-coded status badges:\n    - Green badge for 'Open' opportunities
    - Blue badge for 'Upcoming' opportunities
  - 'New' badge for opportunities added within last 7 days
  - Deadline urgency indicator (e.g., 'Ends in 3 days', 'Opens in 5 days')
  - Category icon for quick identification

- **User Interaction**:
  - Click'Apply Now' button to directly open official application URL in new tab
  - Hover effects showing additional details
  - Bookmark/save favorite opportunities for quick access
  - Share opportunity via link\n
- **Dynamic Updates**:
  - Automatic daily refresh to update opportunity statuses based on current date
  - Real-time status transitions (Upcoming → Open → Closed)
  - New opportunities automatically added from integrated data sources
  - Expired opportunities automatically moved to archive
  - No manual date management required

- **UI/UX Design**:
  - Clean card-based layout with professional styling
  - Responsive design for mobile and desktop
  - Smooth loading states and transitions
  - Clear visual hierarchy emphasizing deadlines and categories
  - Consistent design language with existing dashboard modules

### 2.4 Coding Profile Analysis
- Allow users to input profile URLs:\n  - LeetCode profile URL\n  - HackerRank profile URL
- Fetch real performance data from platforms:
  - Total problems solved correctly\n  - Difficulty-wise breakdown (Easy/Medium/Hard)
  - Exclude wrong attempts and unsolved problems from analysis
  - Practice consistency metrics
- Analyze and display performance insights:
  - Identify weak areas based on difficulty distribution and topic coverage
  - Highlight strengths and areas of proficiency
  - Calculate problem-solving patterns and consistency
  - Track progress over time
- Store fetched data for daily recommendation generation

### 2.5 Coding Practice Module
- Fetch and analyze real user data from provided profile URLs (LeetCode and HackerRank)
- Generate personalized daily problem recommendations based on:
  - User's daily target hours input
  - Identified weak areas from performance analysis
  - Current skill level and difficulty progression
  - Problems not yet solved by the user
- Each recommended problem includes:
  - Problem title
  - Platform name (LeetCode/HackerRank)
  - Difficulty level with color-coded badge (Easy: green, Medium: orange, Hard: red)
  - Direct clickable link to problem on respective platform\n  - Solved/Unsolved status indicator
- Problem filtering logic:
  - Exclude all problems already solved correctly by the user
  - Prioritize problems targeting identified weak areas
  - Balance difficulty appropriate to user's current level
- Display problems in organized card layout:
  - Clear visual hierarchy with card-based design
  - Solved problems marked with checkmark icon
  - Unsolved problems highlighted for focus
  - Hover effects and smooth transitions
- Daily dashboard update:
  - Show number of problems solved today vs daily target
  - Progress bar indicating daily completion percentage
  - Streak tracking for consecutive days of practice
- Clicking any problem card opens the problem directly on the respective coding platform in a new tab
- Refresh recommendations daily based on updated profile data and newly solved problems

### 2.6 Smart Daily Schedule Generator
- **User Input Collection**:
  - Prompt user:'How many hours can you study daily?'
  - Request coding profile URLs (LeetCode and HackerRank) if not already provided
- **Fetch Coding Performance Data**:
  - Retrieve weak topics and areas needing improvement
  - Identify strength areas and proficiency levels
  - Determine daily target problems based on available hours
- **AI-Driven Schedule Generation**:
  - Divide available hours into time blocks:\n    - **Coding Practice**: Focus on solving unsolved problems targeting weak topics
    - **Revision**: Review previously solved problems and strengthen concepts
    - **New Topics**: Explore new problem categories or advanced topics
  - Prioritization logic:
    - Weak topics and unsolved problems first
    - Balance difficulty progression throughout the day
    - Include direct clickable links to daily recommended problems within each time block
  - Automatically insert short breaks (5-10 minutes) between study blocks for optimal productivity
- **Dynamic Schedule Updates**:
  - Adjust schedule based on previous day's progress:\n    - Compare target vs completed problems
    - Increase or decrease problem difficulty if user consistently exceeds or falls short of targets
  - Refresh schedule daily to reflect updated profile data and newly solved problems
  - Adapt time allocation based on user's performance trends and consistency
- **UI Display**:\n  - Timeline or card-based layout showing daily schedule\n  - Each time block displays:
    - Start and End time
    - Task type (Coding Practice / Revision / New Topics / Break)
    - Specific problem links for practice blocks
    - Color-coded by task type (e.g., blue for Coding Practice, green for Revision, purple for New Topics, gray for Breaks)
  - Optional checkbox for users to mark completed tasks
  - Visual progress indicator showing completed vs pending blocks
- **Design Consistency**:
  - Maintain clean, professional design aligned with existing dashboard aesthetics
  - Smooth animations and transitions\n  - Responsive layout for mobile and desktop
\n### 2.7 Performance Analytics
- **User Profile Input**:
  - User provides LeetCode profile URL\n  - User provides HackerRank profile URL
- **Data Fetching and Processing**:
  - Fetch or simulate real performance data from provided profile URLs:\n    - Total problems solved correctly (excluding wrong attempts and unsolved problems)
    - Difficulty-wise breakdown: Easy, Medium, Hard solved counts
    - Weak topics identified from problems attempted but answered incorrectly
    - Strong topics based on consistently correct submissions
    - Daily and weekly submission patterns
    - Consistency metrics and streak tracking
- **Performance Metrics Display**:
  - **Line Graph**: Daily problems solved over time and streak visualization
  - **Bar Chart**: Difficulty-wise problem count comparison (Easy vs Medium vs Hard)
  - **Pie Chart**: Weak topics vs strong topics distribution and time usage breakdown
  - **Target vs Completed**: Visual comparison of daily target problems vs actual completed problems
  - **Consistency Indicators**: Streak count, submission frequency, and practice regularity
- **AI-Driven Insights**:
  - Identify weak areas requiring focused practice based on incorrect attempts and topic gaps
  - Highlight top-performing topics and strength areas
  - Show performance trends and improvement trajectories over time
  - Generate personalized improvement suggestions based on actual practice patterns
  - Recommend specific topics and difficulty levels for next practice sessions
- **UI/UX Design**:
  - Clean, professional dashboard-style card layout
  - Color-coded charts for instant visual recognition (green for strengths, red for weak areas, blue for neutral metrics)
  - Interactive graphs with hover tooltips showing detailed data points
  - Responsive design supporting mobile and desktop views
  - Smooth animations during data loading and chart rendering
- **Dynamic Updates**:
  - Automatically refresh performance data when new problems are solved
  - Update graphs and metrics to reflect latest fetched profile data
  - Show real-time progress towards daily and weekly targets
  - Maintain historical data for trend analysis and long-term tracking
- **Seamless Integration**:
  - Integrate smoothly with existing dashboard navigation and layout
  - Consistent design language with other modules
  - Quick access from sidebar menu\n  - Performance snapshot visible on main Dashboard for at-a-glance monitoring

### 2.8 Email Management Module
- **Email Account Connection**:
  - 'Connect Email' button prominently displayed in Emails module
  - OAuth authentication integration supporting Gmail and Outlook
  - Request READ-ONLY access permission to user's inbox
  - Secure authentication flow with clear permission disclosure
  - User can disconnect email account anytime from settings\n- **Real Email Fetching**:
  - Fetch real emails from connected inbox including:
    - Sender name and email address
    - Subject line\n    - Date and time received
    - Email content for keyword extraction
  - Periodic automatic sync to keep email list updated
  - Manual refresh option for instant sync
- **Intelligent Email Classification**:
  - Automatically classify fetched emails into four categories:
    - **Opportunities**: Emails containing keywords like 'internship', 'job opening', 'hackathon', 'scholarship', 'application', 'career', 'hiring', 'recruitment'
    - **Coding Platforms**: Emails from sender domains like leetcode.com, hackerrank.com, codechef.com, codeforces.com, geeksforgeeks.org\n    - **Notifications**: System alerts, updates, reminders, newsletters\n    - **General**: All other emails not fitting above categories
  - Classification logic based on:\n    - Sender domain analysis
    - Subject line keyword matching
    - Email content keyword extraction
  - Machine learning enhancement for improved accuracy over time
- **UI Display**:
  - Clean, professional email interface with category tabs:\n    - Opportunities
    - Coding Platforms
    - Notifications\n    - General
  - Unread count badge displayed on each category tab
  - Email list showing:\n    - Sender name and email address
    - Subject line\n    - Preview snippet of email content
    - Date/time received
    - Unread indicator (bold text or colored dot)
  - Click email to view full content in modal or side panel
  - Responsive layout for mobile and desktop
- **Search and Filter Options**:
  - Search bar for keyword-based email search across all categories
  - Filter by:\n    - Read/Unread status
    - Date range
    - Sender\n  - Sort options: Date (newest/oldest), Sender, Subject\n- **Opportunity Email Highlighting**:
  - Important opportunity emails marked with star icon or highlighted background
  - Priority badge for urgent deadlines or high-relevance opportunities
  - Visual distinction for new opportunities received within last 7 days
- **Privacy and Security**:
  - READ-ONLY access to user's email inbox (no send, delete, or modify permissions)
  - Encrypted storage of email metadata
  - No sharing of email data with third parties
  - Clear privacy policy and data usage disclosure
  - User can disconnect email account anytime\n  - Compliance with data protection regulations\n- **Seamless Integration**:
  - Consistent design language with existing dashboard modules
  - Smooth animations and transitions
  - Quick access from sidebar navigation menu
  - Loading states during email sync
  - Error handling for connection issues

### 2.9 User Profile\n- User information management\n- Coding profile URLs storage and management
- Skills and preferences settings
- Daily target hours configuration
- Email account connection status and management
- Profile data used for AI context and personalization
\n---

## 3. Design Style\n
### 3.1 Visual Design\n- Modern, professional startup-level interface
- Dark and Light theme support with toggle option
- Card-based layout with clear visual hierarchy
- Professional icon set throughout the application
- Smooth animations and transitions between states
- Color-coded difficulty badges for instant recognition
\n### 3.2 Color Scheme
- Primary color: Deep blue (#2563EB) for trust and professionalism
- Secondary color: Vibrant purple (#7C3AED) for AI and innovation elements
- Accent color: Emerald green (#10B981) for success states and progress indicators
- Difficulty colors: Green (#10B981) for Easy, Orange (#F59E0B) for Medium, Red (#EF4444) for Hard\n- Neutral grays for backgrounds and text hierarchy

### 3.3 Layout and Typography
- Responsive design supporting mobile and desktop viewports
- Clean spacing with consistent padding and margins
- Professional sans-serif typography (Inter or similar)
- Clear visual separation between content sections
- IIT/hackathon-quality visual presentation

### 3.4 Interactive Elements
- Smooth hover effects on buttons and cards
- Loading states with elegant animations during data fetching
- Micro-interactions for user feedback
- Clear visual indicators for clickable problem links
- Solved/unsolved status marks with icon animations

---

## 4. Technical Requirements

### 4.1 Architecture
- Modular and scalable code structure
- API-ready backend architecture
- Integration with LeetCode and HackerRank APIs or web scraping for real profile data fetching
- OAuth 2.0 integration for secure email account connection (Gmail and Outlook)
- Email parsing and classification engine using keyword analysis and sender domain logic
- Context-driven AI response system\n- Clean and maintainable codebase\n- Date-based opportunity classification logic with automatic status updates
- Daily data refresh mechanism for coding profiles and email sync
- Real-time opportunity database with automated status transitions
- Integration with opportunity data sources for continuous updates

### 4.2 Security
- Secure authentication and session management
- Protected API endpoints\n- Data encryption for sensitive user information
- Safe handling of external profile URLs and fetched data
- Rate limiting for API calls to coding platforms
- READ-ONLY OAuth permissions for email access
- Encrypted storage of email metadata
- Secure handling of user email credentials
- Compliance with data protection regulations (GDPR, CCPA)

### 4.3 Integration
- Real-time data fetching from LeetCode and HackerRank profiles
- Parsing and analysis of fetched performance data
- Filtering logic to exclude unsolved and incorrectly solved problems
- Direct linking to external opportunity websites and coding problems
- Performance data processing and visualization
- Real-time date comparison for opportunity status determination
- Daily recommendation engine based on fetched profile data
- OAuth2.0 integration with Gmail and Outlook for secure email access
- Real email fetching including sender, subject, date, and content keywords
- Intelligent email classification using sender domains and keyword-based logic
- Periodic email sync and manual refresh functionality
- Automated opportunity database updates with real-world data sources
- Dynamic status management without manual intervention

---

## 5. User Experience Flow

1. User registers/logs in via authentication page
2. Redirected to personalized Dashboard showing daily progress vs target
3. Navigate to Present Opportunities module
4. View real-world opportunities (internships, jobs, hackathons, scholarships) organized in Open and Upcoming tabs
5. See opportunities automatically sorted by closest deadline and relevance
6. Identify new opportunities via'New' badge and deadline urgency indicators
7. Filter opportunities by category (All / Internships / Jobs / Hackathons / Scholarships)
8. Click'Apply Now' to directly open official application URL in new tab
9. Bookmark favorite opportunities for quick access
10. System automatically updates opportunity statuses daily based on current date
11. Closed opportunities automatically hidden from display
12. Input coding profile URLs (LeetCode and HackerRank) in Coding Profile Analysis section
13. System fetches real performance data and analyzes solved problems
14. View performance insights showing strengths and identified weak areas
15. Navigate to Coding Practice module to view personalized daily problem recommendations
16. See problems filtered to exclude already solved ones, with difficulty color codes
17. Click problem cards to practice directly on coding platforms
18. Track daily progress with solved/unsolved indicators and target achievement
19. Input daily available hours in Smart Schedule module
20. System fetches coding performance data (weak topics, strengths, daily targets)
21. Generate AI-driven personalized schedule with time blocks for Coding Practice, Revision, and New Topics
22. View schedule in timeline/card layout with start-end times, task types, and direct problem links
23. Schedule prioritizes weak topics and unsolved problems, with automatic breaks included
24. Mark completed tasks with optional checkboxes
25. Schedule dynamically updates next day based on previous day's progress and target achievement
26. Navigate to Performance Analytics module\n27. View comprehensive performance dashboard with line graphs, bar charts, and pie charts based on fetched profile data
28. Review AI-driven insights identifying weak areas, strengths, and improvement suggestions
29. Monitor daily streaks, consistency metrics, and target vs completed problems
30. Track performance trends and long-term progress with dynamically updated graphs
31. Navigate to Email Management module
32. Click 'Connect Email' button to initiate OAuth authentication
33. Choose email provider (Gmail or Outlook) and grant READ-ONLY access permission
34. System fetches real emails from connected inbox including sender, subject, date, and content keywords
35. Emails automatically classified into Opportunities, Coding Platforms, Notifications, and General categories
36. View emails organized in category tabs with unread count badges
37. Use search and filter options to find specific emails by keyword, date, sender, or read/unread status
38. Identify highlighted opportunity emails with priority indicators and star icons
39. Click emails to view full content in modal or side panel
40. Manually refresh emails or rely on periodic automatic sync
41. Disconnect email account anytime from profile settings for privacy control
42. Update profile, preferences, and daily targets as needed
\n---

## 6. Application Goal

Create a production-ready platform that feels like 'A personal AI mentor that helps users discover real-world opportunities with dynamic updates, apply confidently, practice coding with real data-driven recommendations, manage time with intelligent scheduling, track performance, and organize real emails intelligently using secure OAuth integration' with actual fetched data from coding platforms, real opportunities automatically updated based on current dates, secure email integration with automatic classification based on sender domains and keywords, intelligent problem filtering, dynamic schedule adaptation, comprehensive performance analytics with AI-driven insights, clear user flow, and impressive UX quality suitable for demonstration and judging.