CREATE TABLE "invoices" (
  "invoice_number" bigserial PRIMARY KEY,
  "issue_date" timestamptz NOT NULL DEFAULT (now()),
  "due_date" timestamptz NOT NULL DEFAULT (now() + interval '30 days'),
  "order_id" bigint NOT NULL,
  "vendor_name" varchar NOT NULL,
  "vendor_phone" varchar NOT NULL,
  "vendor_address" varchar NOT NULL,
  "vendor_email" varchar NOT NULL,
  "customer_name" varchar NOT NULL,
  "customer_phone" varchar NOT NULL,
  "customer_address" varchar NOT NULL,
  "customer_email" varchar NOT NULL
);

CREATE TABLE "orders" (
  "id" bigserial PRIMARY KEY,
  "customer_id" bigint NOT NULL,
  "status" varchar NOT NULL DEFAULT 'active',
  "subtotal" bigint NOT NULL,
  "discount_rate" int NOT NULL,
  "total_amount" bigint NOT NULL,
  "note" varchar NOT NULL DEFAULT 'Thank you for your patronage'
);

CREATE TABLE "orders_items" (
  "id" bigserial PRIMARY KEY,
  "order_id" bigint NOT NULL,
  "description" varchar NOT NULL,
  "quantity" bigint NOT NULL,
  "unit_price" bigint NOT NULL,
  "total_price" bigint NOT NULL
);

CREATE TABLE "customers" (
  "id" bigserial PRIMARY KEY,
  "name" varchar NOT NULL,
  "phone" varchar NOT NULL,
  "address" varchar NOT NULL,
  "email" varchar NOT NULL
);

ALTER TABLE "invoices" ADD FOREIGN KEY ("order_id") REFERENCES "orders" ("id");

ALTER TABLE "orders" ADD FOREIGN KEY ("customer_id") REFERENCES "customers" ("id");

ALTER TABLE "orders_items" ADD FOREIGN KEY ("order_id") REFERENCES "orders" ("id");
