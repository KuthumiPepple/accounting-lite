CREATE TYPE "draft_status" AS ENUM (
  'Active',
  'Cancelled',
  'Invoiced'
);

CREATE TABLE "accounts" (
  "id" bigserial PRIMARY KEY,
  "customer_id" bigint,
  "balance" bigint NOT NULL DEFAULT 0,
  "currency" varchar NOT NULL DEFAULT 'USD'
);

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
  "customer_id" bigint,
  "status" draft_status NOT NULL DEFAULT 'Active',
  "subtotal" bigint NOT NULL,
  "discount_rate" int NOT NULL,
  "discount" bigint NOT NULL,
  "total_amount" bigint NOT NULL
);

CREATE TABLE "orders_items" (
  "id" bigserial PRIMARY KEY,
  "order_id" bigint,
  "description" varchar NOT NULL,
  "quantity" bigint NOT NULL,
  "unit_price" bigint NOT NULL,
  "total_price" bigint NOT NULL
);

CREATE TABLE "customers" (
  "id" bigserial PRIMARY KEY,
  "customer_name" varchar NOT NULL,
  "customer_phone" varchar NOT NULL,
  "customer_address" varchar NOT NULL,
  "customer_email" varchar NOT NULL
);

CREATE TABLE "payments" (
  "id" bigserial PRIMARY KEY,
  "account_id" bigint,
  "amount" bigint NOT NULL
);

CREATE TABLE "invoices_payments" (
  "id" bigserial PRIMARY KEY,
  "invoice_number" bigint,
  "payment_id" bigint,
  "amount_applied" bigint NOT NULL
);

CREATE UNIQUE INDEX ON "accounts" ("customer_id", "currency");

ALTER TABLE "accounts" ADD FOREIGN KEY ("customer_id") REFERENCES "customers" ("id");

ALTER TABLE "invoices" ADD FOREIGN KEY ("order_id") REFERENCES "orders" ("id");

ALTER TABLE "orders" ADD FOREIGN KEY ("customer_id") REFERENCES "customers" ("id");

ALTER TABLE "orders_items" ADD FOREIGN KEY ("order_id") REFERENCES "orders" ("id");

ALTER TABLE "payments" ADD FOREIGN KEY ("account_id") REFERENCES "accounts" ("id");