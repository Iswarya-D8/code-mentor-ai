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

-- Add new date columns
ALTER TABLE opportunities 
ADD COLUMN start_date date,
ADD COLUMN end_date date;

-- Update existing opportunities with realistic dates
-- Closed opportunities (already ended)
UPDATE opportunities 
SET start_date = '2024-12-01', end_date = '2024-12-15'
WHERE title LIKE '%Google Summer%';

-- Open opportunities (currently active)
UPDATE opportunities 
SET start_date = '2024-12-10', end_date = '2025-01-31'
WHERE title LIKE '%Microsoft%';

UPDATE opportunities 
SET start_date = '2024-12-01', end_date = '2025-02-28'
WHERE title LIKE '%Amazon%';

UPDATE opportunities 
SET start_date = '2024-11-15', end_date = '2025-01-15'
WHERE title LIKE '%Meta%';

-- Upcoming opportunities (not started yet)
UPDATE opportunities 
SET start_date = '2025-01-15', end_date = '2025-03-15'
WHERE title LIKE '%MLH Hackathon%';

UPDATE opportunities 
SET start_date = '2025-02-01', end_date = '2025-04-30'
WHERE title LIKE '%Fulbright%';

UPDATE opportunities 
SET start_date = '2025-01-20', end_date = '2025-02-20'
WHERE title LIKE '%TechCrunch%';

UPDATE opportunities 
SET start_date = '2025-03-01', end_date = '2025-05-31'
WHERE title LIKE '%Gates%';

-- Make columns required
ALTER TABLE opportunities 
ALTER COLUMN start_date SET NOT NULL,
ALTER COLUMN end_date SET NOT NULL;

-- Add constraint to ensure end_date is after start_date
ALTER TABLE opportunities 
ADD CONSTRAINT check_date_order CHECK (end_date >= start_date);
