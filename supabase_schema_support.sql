
-- Support Tickets Table
CREATE TABLE support_tickets (
  id UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
  type TEXT CHECK (type IN ('feedback', 'bug_report')) NOT NULL,
  title TEXT NOT NULL,
  description TEXT,
  contact_email TEXT,
  severity TEXT CHECK (severity IN ('low', 'medium', 'high', 'critical')),
  status TEXT DEFAULT 'open' CHECK (status IN ('open', 'in_progress', 'resolved', 'closed')),
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);
