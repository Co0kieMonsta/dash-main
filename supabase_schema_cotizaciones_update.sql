-- Add product_id to details table
ALTER TABLE detalles_cotizacion 
ADD COLUMN product_id UUID REFERENCES inventory_products(id);
