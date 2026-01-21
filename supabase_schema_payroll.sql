
-- Staff Table
CREATE TABLE staff (
  id UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
  name TEXT NOT NULL,
  email TEXT,
  phone TEXT,
  role TEXT,
  hourly_rate DECIMAL(10, 2) DEFAULT 0.00,
  pin_code TEXT UNIQUE NOT NULL, -- PIN for Time Clock
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Time Entries Table
CREATE TABLE time_entries (
  id UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
  staff_id UUID REFERENCES staff(id) ON DELETE CASCADE,
  clock_in TIMESTAMP WITH TIME ZONE NOT NULL,
  clock_out TIMESTAMP WITH TIME ZONE,
  total_hours DECIMAL(10, 2), -- Calculated on clock out (hours)
  date DATE DEFAULT CURRENT_DATE,
  status TEXT DEFAULT 'active' CHECK (status IN ('active', 'completed')),
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Payrolls Table
CREATE TABLE payrolls (
  id UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
  staff_id UUID REFERENCES staff(id) ON DELETE CASCADE,
  period_start DATE NOT NULL,
  period_end DATE NOT NULL,
  total_hours DECIMAL(10, 2) DEFAULT 0.00,
  gross_pay DECIMAL(10, 2) DEFAULT 0.00,
  deductions DECIMAL(10, 2) DEFAULT 0.00,
  net_pay DECIMAL(10, 2) DEFAULT 0.00,
  status TEXT DEFAULT 'draft' CHECK (status IN ('draft', 'paid')),
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);
