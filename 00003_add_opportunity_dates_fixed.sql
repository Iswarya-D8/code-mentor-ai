/*
# Add Start Date and End Date to Opportunities

1. Schema Changes
   - Add `start_date` column (date, not null)
   - Add `end_date` column (date, not null)
   - Add constraint: end_date must be >= start_date

2. Data Migration
   - Update existing opportunities with realistic 2025 dates
   - Mix of open, upcoming, and closed opportunities

3. Notes
   - Opportunities can now be automatically classified by status
   - Status calculation: closed (end_date < today), upcoming (start_date > today), open (start_date <= today <= end_date)
*/

-- Add new date columns (nullable first)
ALTER TABLE opportunities 
ADD COLUMN IF NOT EXISTS start_date date,
ADD COLUMN IF NOT EXISTS end_date date;

-- Update existing opportunities with realistic dates
-- Closed opportunities (already ended)
UPDATE opportunities 
SET start_date = '2024-12-01', end_date = '2024-12-15'
WHERE title LIKE '%Google Summer%' AND start_date IS NULL;

-- Open opportunities (currently active)
UPDATE opportunities 
SET start_date = '2024-12-10', end_date = '2025-01-31'
WHERE title LIKE '%Microsoft%' AND start_date IS NULL;

UPDATE opportunities 
SET start_date = '2024-12-01', end_date = '2025-02-28'
WHERE title LIKE '%Amazon%' AND start_date IS NULL;

UPDATE opportunities 
SET start_date = '2024-11-15', end_date = '2025-01-15'
WHERE title LIKE '%Meta%' AND start_date IS NULL;

-- Upcoming opportunities (not started yet)
UPDATE opportunities 
SET start_date = '2025-01-15', end_date = '2025-03-15'
WHERE title LIKE '%MLH Hackathon%' AND start_date IS NULL;

UPDATE opportunities 
SET start_date = '2025-02-01', end_date = '2025-04-30'
WHERE title LIKE '%Fulbright%' AND start_date IS NULL;

UPDATE opportunities 
SET start_date = '2025-01-20', end_date = '2025-02-20'
WHERE title LIKE '%TechCrunch%' AND start_date IS NULL;

UPDATE opportunities 
SET start_date = '2025-03-01', end_date = '2025-05-31'
WHERE title LIKE '%Gates%' AND start_date IS NULL;

-- Set default dates for any remaining NULL values
UPDATE opportunities 
SET start_date = CURRENT_DATE, end_date = CURRENT_DATE + INTERVAL '30 days'
WHERE start_date IS NULL OR end_date IS NULL;

-- Now make columns required
ALTER TABLE opportunities 
ALTER COLUMN start_date SET NOT NULL,
ALTER COLUMN end_date SET NOT NULL;

-- Add constraint to ensure end_date is after start_date
ALTER TABLE opportunities 
DROP CONSTRAINT IF EXISTS check_date_order;

ALTER TABLE opportunities 
ADD CONSTRAINT check_date_order CHECK (end_date >= start_date);
