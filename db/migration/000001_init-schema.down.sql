ALTER TABLE "invoices" DROP CONSTRAINT IF EXISTS "invoices_order_id_fkey";
ALTER TABLE "orders" DROP CONSTRAINT IF EXISTS "orders_customer_id_fkey";
ALTER TABLE "orders_items" DROP CONSTRAINT IF EXISTS "orders_items_order_id_fkey";
DROP TABLE IF EXISTS "invoices";
DROP TABLE IF EXISTS "orders_items";
DROP TABLE IF EXISTS "orders";
DROP TABLE IF EXISTS "customers";