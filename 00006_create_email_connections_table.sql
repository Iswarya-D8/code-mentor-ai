/*
# Email Connections Table for OAuth Integration

## Overview
This migration creates the infrastructure for secure email integration with Gmail and Outlook using OAuth 2.0.

## Tables Created

### email_connections
Stores OAuth connection details for user email accounts.

**Columns:**
- `id` (uuid, primary key): Unique identifier for the connection
- `user_id` (uuid, foreign key): References auth.users(id)
- `provider` (text): Email provider ('gmail' or 'outlook')
- `email_address` (text): User's email address
- `access_token` (text): Encrypted OAuth access token
- `refresh_token` (text): Encrypted OAuth refresh token
- `token_expires_at` (timestamptz): Token expiration timestamp
- `is_active` (boolean): Connection status
- `last_synced` (timestamptz): Last email sync timestamp
- `created_at` (timestamptz): Connection creation timestamp
- `updated_at` (timestamptz): Last update timestamp

## Security
- RLS enabled on email_connections table
- Users can only access their own connections
- Tokens are stored encrypted (application-level encryption recommended)
- Read-only OAuth scopes enforced at application level

## Indexes
- Index on user_id for fast lookups
- Index on provider for filtering
- Unique constraint on user_id + provider + email_address
*/

-- Create email_connections table
CREATE TABLE IF NOT EXISTS email_connections (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id uuid NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  provider text NOT NULL CHECK (provider IN ('gmail', 'outlook')),
  email_address text NOT NULL,
  access_token text NOT NULL,
  refresh_token text,
  token_expires_at timestamptz NOT NULL,
  is_active boolean DEFAULT true NOT NULL,
  last_synced timestamptz,
  created_at timestamptz DEFAULT now() NOT NULL,
  updated_at timestamptz DEFAULT now() NOT NULL,
  UNIQUE(user_id, provider, email_address)
);

-- Create indexes
CREATE INDEX IF NOT EXISTS idx_email_connections_user_id ON email_connections(user_id);
CREATE INDEX IF NOT EXISTS idx_email_connections_provider ON email_connections(provider);
CREATE INDEX IF NOT EXISTS idx_email_connections_active ON email_connections(is_active) WHERE is_active = true;

-- Enable RLS
ALTER TABLE email_connections ENABLE ROW LEVEL SECURITY;

-- RLS Policies
CREATE POLICY "Users can view own email connections" ON email_connections
  FOR SELECT USING (auth.uid() = user_id);

CREATE POLICY "Users can insert own email connections" ON email_connections
  FOR INSERT WITH CHECK (auth.uid() = user_id);

CREATE POLICY "Users can update own email connections" ON email_connections
  FOR UPDATE USING (auth.uid() = user_id);

CREATE POLICY "Users can delete own email connections" ON email_connections
  FOR DELETE USING (auth.uid() = user_id);

-- Add connection_id to emails table (optional, for tracking source)
ALTER TABLE emails ADD COLUMN IF NOT EXISTS connection_id uuid REFERENCES email_connections(id) ON DELETE SET NULL;
CREATE INDEX IF NOT EXISTS idx_emails_connection_id ON emails(connection_id);

-- Function to update updated_at timestamp
CREATE OR REPLACE FUNCTION update_email_connections_updated_at()
RETURNS TRIGGER AS $$
BEGIN
  NEW.updated_at = now();
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Trigger to auto-update updated_at
CREATE TRIGGER update_email_connections_updated_at_trigger
  BEFORE UPDATE ON email_connections
  FOR EACH ROW
  EXECUTE FUNCTION update_email_connections_updated_at();
