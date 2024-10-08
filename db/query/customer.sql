-- name: AddCustomer :one
INSERT INTO customers (
    name, 
    phone, 
    address, 
    email
) VALUES (
    $1, $2, $3, $4
) RETURNING *;

-- name: GetCustomer :one
SELECT * FROM customers WHERE id = $1;

-- name: DeleteCustomer :exec
DELETE FROM customers WHERE id = $1;