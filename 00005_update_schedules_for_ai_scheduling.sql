/*
# Update Schedules Table for AI-Driven Scheduling

1. Schema Changes
   - Add `daily_hours` column (integer) - User's available study hours per day
   - Add `schedule_blocks` column (jsonb) - Array of time blocks with tasks
   - Add `target_problems` column (integer) - Daily problem-solving target
   - Add `completed_problems` column (integer) - Problems completed today
   - Add `last_generated` column (date) - Last schedule generation date
   - Add `preferences` column (jsonb) - User preferences for scheduling

2. Schedule Block Structure
   - start_time: Time when block starts
   - end_time: Time when block ends
   - task_type: 'coding' | 'revision' | 'new_topics' | 'break'
   - topic: Topic to focus on
   - problems: Array of problem objects with links
   - completed: Boolean for tracking completion

3. Notes
   - Enables AI-driven schedule generation
   - Tracks daily progress
   - Supports dynamic schedule updates
*/

-- Add new columns to schedules table
ALTER TABLE schedules 
ADD COLUMN IF NOT EXISTS daily_hours integer DEFAULT 4,
ADD COLUMN IF NOT EXISTS schedule_blocks jsonb DEFAULT '[]'::jsonb,
ADD COLUMN IF NOT EXISTS target_problems integer DEFAULT 3,
ADD COLUMN IF NOT EXISTS completed_problems integer DEFAULT 0,
ADD COLUMN IF NOT EXISTS last_generated date,
ADD COLUMN IF NOT EXISTS preferences jsonb DEFAULT '{}'::jsonb;

-- Create index on last_generated for efficient queries
CREATE INDEX IF NOT EXISTS idx_schedules_last_generated ON schedules(last_generated);

-- Create index on user_id and last_generated for user-specific queries
CREATE INDEX IF NOT EXISTS idx_schedules_user_date ON schedules(user_id, last_generated);
