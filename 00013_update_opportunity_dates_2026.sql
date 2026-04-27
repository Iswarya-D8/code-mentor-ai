/*
# Update Opportunity Dates to 2026

Current database date is December 17, 2025, so all 2025 opportunities have expired.
This migration updates all opportunities to 2026 dates to make them current and future.

1. Updates all opportunities by adding 1 year to their dates
2. Ensures opportunities are visible (end_date >= current_date)
3. Maintains the same relative timing and duration
*/

-- Update all opportunities by adding 1 year to make them current
UPDATE opportunities 
SET 
  start_date = start_date + INTERVAL '1 year',
  end_date = end_date + INTERVAL '1 year',
  deadline = CASE 
    WHEN deadline IS NOT NULL THEN deadline + INTERVAL '1 year'
    ELSE NULL
  END;
