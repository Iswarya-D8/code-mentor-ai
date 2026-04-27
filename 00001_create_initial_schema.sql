/*
# Create Initial Schema for Personal AI Mentor Platform

## 1. Plain English Explanation
This migration creates the foundational database structure for the Personal AI Mentor Platform.
It includes tables for user profiles, opportunities (internships/jobs/hackathons/scholarships),
coding practice profiles, daily schedules, email management, and performance analytics.

## 2. Table List & Column Descriptions

### profiles
- `id` (uuid, primary key, references auth.users) - User identifier
- `email` (text, unique) - User email address
- `full_name` (text) - User's full name
- `skills` (text[]) - Array of user skills
- `preferences` (jsonb) - User preferences and settings
- `role` (user_role, default: 'user') - User role (user/admin)
- `created_at` (timestamptz) - Account creation timestamp
- `updated_at` (timestamptz) - Last update timestamp

### opportunities
- `id` (uuid, primary key) - Opportunity identifier
- `title` (text, not null) - Opportunity title
- `organization` (text, not null) - Organization name
- `type` (opportunity_type, not null) - Type: internship/job/hackathon/scholarship
- `description` (text) - Detailed description
- `deadline` (date, not null) - Application deadline
- `application_url` (text) - External application website URL
- `requirements` (text[]) - Array of requirements
- `created_at` (timestamptz) - Creation timestamp

### coding_profiles
- `id` (uuid, primary key) - Profile identifier
- `user_id` (uuid, references profiles) - User reference
- `platform` (text, not null) - Platform name (LeetCode/HackerRank)
- `profile_url` (text, not null) - Profile URL
- `total_solved` (integer, default: 0) - Total problems solved
- `easy_solved` (integer, default: 0) - Easy problems solved
- `medium_solved` (integer, default: 0) - Medium problems solved
- `hard_solved` (integer, default: 0) - Hard problems solved
- `strengths` (text[]) - Identified strengths
- `weaknesses` (text[]) - Identified weaknesses
- `last_synced` (timestamptz) - Last sync timestamp
- `created_at` (timestamptz) - Creation timestamp

### schedules
- `id` (uuid, primary key) - Schedule identifier
- `user_id` (uuid, references profiles) - User reference
- `date` (date, not null) - Schedule date
- `available_hours` (integer, not null) - Available study hours
- `schedule_blocks` (jsonb, not null) - Time blocks with activities
- `created_at` (timestamptz) - Creation timestamp

### emails
- `id` (uuid, primary key) - Email identifier
- `user_id` (uuid, references profiles) - User reference
- `subject` (text, not null) - Email subject
- `sender` (text, not null) - Sender email/name
- `category` (email_category) - Auto-categorized type
- `content` (text) - Email content
- `is_read` (boolean, default: false) - Read status
- `priority` (text) - Priority level
- `received_at` (timestamptz, not null) - Received timestamp
- `created_at` (timestamptz) - Creation timestamp

### performance_analytics
- `id` (uuid, primary key) - Analytics identifier
- `user_id` (uuid, references profiles) - User reference
- `date` (date, not null) - Analytics date
- `coding_time` (integer, default: 0) - Minutes spent coding
- `problems_solved` (integer, default: 0) - Problems solved that day
- `study_time` (integer, default: 0) - Minutes spent studying
- `applications_submitted` (integer, default: 0) - Applications submitted
- `metrics` (jsonb) - Additional metrics data
- `created_at` (timestamptz) - Creation timestamp

## 3. Security Changes
- RLS is NOT enabled on any tables as this is a public platform
- All users can view opportunities (public data)
- Users can manage their own profiles, coding profiles, schedules, emails, and analytics
- First registered user becomes admin automatically via trigger

## 4. Notes
- Using ENUM types for role, opportunity_type, and email_category
- JSONB used for flexible data storage (preferences, schedule_blocks, metrics)
- Arrays used for skills, requirements, strengths, weaknesses
- Timestamps track creation and updates
- Foreign keys ensure referential integrity
*/

-- Create ENUM types
CREATE TYPE user_role AS ENUM ('user', 'admin');
CREATE TYPE opportunity_type AS ENUM ('internship', 'job', 'hackathon', 'scholarship');
CREATE TYPE email_category AS ENUM ('opportunities', 'coding_platforms', 'notifications', 'general');

-- Create profiles table
CREATE TABLE IF NOT EXISTS profiles (
  id uuid PRIMARY KEY REFERENCES auth.users(id) ON DELETE CASCADE,
  email text UNIQUE,
  full_name text,
  skills text[],
  preferences jsonb DEFAULT '{}'::jsonb,
  role user_role DEFAULT 'user'::user_role NOT NULL,
  created_at timestamptz DEFAULT now(),
  updated_at timestamptz DEFAULT now()
);

-- Create opportunities table
CREATE TABLE IF NOT EXISTS opportunities (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  title text NOT NULL,
  organization text NOT NULL,
  type opportunity_type NOT NULL,
  description text,
  deadline date NOT NULL,
  application_url text,
  requirements text[],
  created_at timestamptz DEFAULT now()
);

-- Create coding_profiles table
CREATE TABLE IF NOT EXISTS coding_profiles (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id uuid REFERENCES profiles(id) ON DELETE CASCADE,
  platform text NOT NULL,
  profile_url text NOT NULL,
  total_solved integer DEFAULT 0,
  easy_solved integer DEFAULT 0,
  medium_solved integer DEFAULT 0,
  hard_solved integer DEFAULT 0,
  strengths text[],
  weaknesses text[],
  last_synced timestamptz,
  created_at timestamptz DEFAULT now(),
  UNIQUE(user_id, platform)
);

-- Create schedules table
CREATE TABLE IF NOT EXISTS schedules (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id uuid REFERENCES profiles(id) ON DELETE CASCADE,
  date date NOT NULL,
  available_hours integer NOT NULL,
  schedule_blocks jsonb NOT NULL,
  created_at timestamptz DEFAULT now(),
  UNIQUE(user_id, date)
);

-- Create emails table
CREATE TABLE IF NOT EXISTS emails (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id uuid REFERENCES profiles(id) ON DELETE CASCADE,
  subject text NOT NULL,
  sender text NOT NULL,
  category email_category,
  content text,
  is_read boolean DEFAULT false,
  priority text,
  received_at timestamptz NOT NULL,
  created_at timestamptz DEFAULT now()
);

-- Create performance_analytics table
CREATE TABLE IF NOT EXISTS performance_analytics (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id uuid REFERENCES profiles(id) ON DELETE CASCADE,
  date date NOT NULL,
  coding_time integer DEFAULT 0,
  problems_solved integer DEFAULT 0,
  study_time integer DEFAULT 0,
  applications_submitted integer DEFAULT 0,
  metrics jsonb DEFAULT '{}'::jsonb,
  created_at timestamptz DEFAULT now(),
  UNIQUE(user_id, date)
);

-- Create function to handle new user registration
CREATE OR REPLACE FUNCTION handle_new_user()
RETURNS trigger
LANGUAGE plpgsql
SECURITY DEFINER SET search_path = public
AS $$
DECLARE
  user_count int;
BEGIN
  SELECT COUNT(*) INTO user_count FROM profiles;
  INSERT INTO profiles (id, email, role)
  VALUES (
    NEW.id,
    NEW.email,
    CASE WHEN user_count = 0 THEN 'admin'::user_role ELSE 'user'::user_role END
  );
  RETURN NEW;
END;
$$;

-- Create trigger for new user registration
DROP TRIGGER IF EXISTS on_auth_user_confirmed ON auth.users;
CREATE TRIGGER on_auth_user_confirmed
  AFTER UPDATE ON auth.users
  FOR EACH ROW
  WHEN (OLD.confirmed_at IS NULL AND NEW.confirmed_at IS NOT NULL)
  EXECUTE FUNCTION handle_new_user();

-- Create function to update updated_at timestamp
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
  NEW.updated_at = now();
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Create trigger for profiles updated_at
CREATE TRIGGER update_profiles_updated_at
  BEFORE UPDATE ON profiles
  FOR EACH ROW
  EXECUTE FUNCTION update_updated_at_column();

-- Insert sample opportunities data
INSERT INTO opportunities (title, organization, type, description, deadline, application_url, requirements) VALUES
('Software Engineering Intern', 'Google', 'internship'::opportunity_type, 'Join our team to work on cutting-edge technologies and solve complex problems at scale.', '2025-03-15', 'https://careers.google.com', ARRAY['Computer Science degree', 'Proficiency in Python/Java', 'Strong problem-solving skills']),
('Full Stack Developer', 'Microsoft', 'job'::opportunity_type, 'Build innovative solutions using modern web technologies in a collaborative environment.', '2025-02-28', 'https://careers.microsoft.com', ARRAY['3+ years experience', 'React and Node.js', 'Cloud platforms knowledge']),
('Global Hackathon 2025', 'MLH', 'hackathon'::opportunity_type, 'Compete with developers worldwide to build innovative solutions in 48 hours.', '2025-01-30', 'https://mlh.io', ARRAY['Team of 2-4 members', 'Any tech stack', 'Original project']),
('Merit Scholarship Program', 'Stanford University', 'scholarship'::opportunity_type, 'Full tuition scholarship for outstanding students pursuing Computer Science degrees.', '2025-04-01', 'https://www.stanford.edu', ARRAY['GPA 3.8+', 'Leadership experience', 'Research publications']),
('Data Science Intern', 'Meta', 'internship'::opportunity_type, 'Work with large-scale data to derive insights and build ML models.', '2025-03-20', 'https://www.metacareers.com', ARRAY['Statistics/ML background', 'Python and SQL', 'Data visualization skills']),
('DevOps Engineer', 'Amazon', 'job'::opportunity_type, 'Manage and optimize cloud infrastructure for high-traffic applications.', '2025-02-15', 'https://www.amazon.jobs', ARRAY['AWS certification', 'CI/CD experience', 'Kubernetes knowledge']),
('AI Innovation Challenge', 'OpenAI', 'hackathon'::opportunity_type, 'Build the next generation of AI-powered applications using GPT models.', '2025-02-10', 'https://openai.com', ARRAY['AI/ML knowledge', 'Creative thinking', 'Working prototype']),
('Women in Tech Scholarship', 'Grace Hopper Foundation', 'scholarship'::opportunity_type, 'Supporting women pursuing careers in technology with financial aid and mentorship.', '2025-03-30', 'https://ghc.anitab.org', ARRAY['Female student', 'STEM major', 'Community involvement']);
