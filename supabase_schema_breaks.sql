
-- Breaks Table
CREATE TABLE breaks (
  id UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
  time_entry_id UUID REFERENCES time_entries(id) ON DELETE CASCADE,
  start_time TIMESTAMP WITH TIME ZONE NOT NULL,
  end_time TIMESTAMP WITH TIME ZONE,
  duration DECIMAL(10, 2), -- Calculated in hours
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);
