-- Create Finance Categories Table
CREATE TABLE finance_categories (
  id UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
  nombre TEXT NOT NULL,
  tipo TEXT CHECK (tipo IN ('ingreso', 'egreso')) NOT NULL,
  descripcion TEXT,
  icono TEXT,
  color TEXT,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Create Finance Accounts Table
CREATE TABLE finance_accounts (
  id UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
  nombre TEXT NOT NULL,
  tipo TEXT CHECK (tipo IN ('banco', 'efectivo', 'tarjeta')) NOT NULL,
  numero_cuenta TEXT, -- Can be null for cash
  banco TEXT, -- Can be null for cash
  saldo DECIMAL(12, 2) DEFAULT 0.00,
  moneda TEXT DEFAULT 'USD',
  estado TEXT DEFAULT 'activo',
  descripcion TEXT,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Create Finance Transactions Table
CREATE TABLE finance_transactions (
  id UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
  fecha DATE NOT NULL,
  tipo TEXT CHECK (tipo IN ('ingreso', 'egreso')) NOT NULL,
  categoria TEXT NOT NULL, -- Storing name for simplicity as per current app structure, or could reference ID
  subcategoria TEXT,
  monto DECIMAL(12, 2) NOT NULL,
  metodo_pago TEXT,
  cuenta TEXT NOT NULL, -- Storing name for simplicity
  descripcion TEXT NOT NULL,
  referencia TEXT,
  estado TEXT CHECK (estado IN ('completado', 'pendiente', 'cancelado')) DEFAULT 'completado',
  comprobante TEXT, -- URL or path
  created_by TEXT, -- User ID
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Optional: Insert some initial data (Categories)
INSERT INTO finance_categories (nombre, tipo, descripcion, icono, color) VALUES
('Ventas', 'ingreso', 'Ingresos por ventas de productos y servicios', 'ShoppingCart', 'green'),
('Servicios', 'ingreso', 'Ingresos por servicios prestados', 'Briefcase', 'blue'),
('Otros Ingresos', 'ingreso', 'Ingresos varios', 'Plus', 'teal'),
('Nómina', 'egreso', 'Pagos de salarios y beneficios', 'Users', 'red'),
('Gastos Operativos', 'egreso', 'Gastos de operación diaria', 'Settings', 'orange'),
('Marketing', 'egreso', 'Gastos de marketing y publicidad', 'Megaphone', 'purple'),
('Compras', 'egreso', 'Compra de inventario y materia prima', 'Package', 'yellow'),
('Gastos Administrativos', 'egreso', 'Gastos administrativos generales', 'FileText', 'gray'),
('Tecnología', 'egreso', 'Inversión en tecnología', 'Laptop', 'indigo');

-- Optional: Insert some initial data (Accounts)
INSERT INTO finance_accounts (nombre, tipo, numero_cuenta, banco, saldo, moneda, estado, descripcion) VALUES
('Banco Principal', 'banco', '****1234', 'Banco Nacional', 125000.00, 'USD', 'activo', 'Cuenta principal de operaciones'),
('Caja General', 'efectivo', NULL, NULL, 8500.00, 'USD', 'activo', 'Caja general para ventas al contado'),
('Caja Chica', 'efectivo', NULL, NULL, 2000.00, 'USD', 'activo', 'Fondo fijo para gastos menores'),
('Tarjeta Corporativa', 'tarjeta', '****5678', 'Banco Nacional', -6000.00, 'USD', 'activo', 'Tarjeta de crédito corporativa');

-- Inventory Categories Table
CREATE TABLE inventory_categories (
  id UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
  name TEXT NOT NULL,
  type TEXT CHECK (type IN ('product', 'asset')) NOT NULL,
  description TEXT,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Inventory Products Table
CREATE TABLE inventory_products (
  id UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
  name TEXT NOT NULL,
  sku TEXT,
  category_id UUID REFERENCES inventory_categories(id),
  quantity INTEGER DEFAULT 0,
  price DECIMAL(12, 2) DEFAULT 0.00,
  description TEXT,
  status TEXT DEFAULT 'active',
  image TEXT,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Inventory Assets Table
CREATE TABLE inventory_assets (
  id UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
  name TEXT NOT NULL,
  asset_code TEXT,
  category_id UUID REFERENCES inventory_categories(id),
  value DECIMAL(12, 2) DEFAULT 0.00,
  location TEXT,
  acquired_date DATE,
  status TEXT DEFAULT 'active',
  description TEXT,
  image TEXT,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);
