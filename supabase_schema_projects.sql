
-- Projects Table
CREATE TABLE projects (
  id UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
  title TEXT NOT NULL,
  subtitle TEXT,
  description TEXT,
  status TEXT DEFAULT 'active', -- active, completed, hold, review, in progress
  priority TEXT, -- low, medium, high
  assign JSONB DEFAULT '[]'::jsonb, -- Array of user objects
  percentage INTEGER DEFAULT 0,
  is_favorite BOOLEAN DEFAULT false,
  start_date DATE, -- Maps to assignDate
  end_date DATE, -- Maps to dueDate
  image TEXT,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Tasks Table
CREATE TABLE tasks (
  id UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
  project_id UUID REFERENCES projects(id) ON DELETE CASCADE,
  title TEXT NOT NULL,
  description TEXT,
  status TEXT DEFAULT 'todo', -- todo, in-progress, done
  priority TEXT DEFAULT 'medium', -- low, medium, high
  assigned_to UUID REFERENCES staff(id) ON DELETE SET NULL,
  due_date DATE,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);
