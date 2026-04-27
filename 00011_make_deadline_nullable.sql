/*
# Make Deadline Column Nullable

Since we're now using start_date and end_date for date-based logic,
the deadline column is redundant. Making it nullable for backward compatibility.
*/

ALTER TABLE opportunities 
ALTER COLUMN deadline DROP NOT NULL;
