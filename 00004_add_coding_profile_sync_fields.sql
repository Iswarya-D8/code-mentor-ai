/*
# Add Profile Sync Fields to Coding Profiles

1. Schema Changes
   - Add `solved_problems` column (jsonb) to store fetched problem data
   - Add `last_synced` column (timestamptz) to track last sync time
   - Add `sync_status` column (text) to track sync state
   - Add `total_solved` column (integer) to cache total count
   - Add `easy_solved` column (integer) to cache easy count
   - Add `medium_solved` column (integer) to cache medium count
   - Add `hard_solved` column (integer) to cache hard count

2. Data Structure
   - solved_problems: Array of problem objects with title, difficulty, topics, url
   - sync_status: 'pending' | 'syncing' | 'success' | 'error'

3. Notes
   - Enables real-time fetching of profile data
   - Caches results to reduce API calls
   - Tracks sync status for user feedback
*/

-- Add new columns to coding_profiles table
ALTER TABLE coding_profiles 
ADD COLUMN IF NOT EXISTS solved_problems jsonb DEFAULT '[]'::jsonb,
ADD COLUMN IF NOT EXISTS last_synced timestamptz,
ADD COLUMN IF NOT EXISTS sync_status text DEFAULT 'pending',
ADD COLUMN IF NOT EXISTS total_solved integer DEFAULT 0,
ADD COLUMN IF NOT EXISTS easy_solved integer DEFAULT 0,
ADD COLUMN IF NOT EXISTS medium_solved integer DEFAULT 0,
ADD COLUMN IF NOT EXISTS hard_solved integer DEFAULT 0;

-- Create index on sync_status for efficient queries
CREATE INDEX IF NOT EXISTS idx_coding_profiles_sync_status ON coding_profiles(sync_status);

-- Create index on last_synced for efficient queries
CREATE INDEX IF NOT EXISTS idx_coding_profiles_last_synced ON coding_profiles(last_synced);
