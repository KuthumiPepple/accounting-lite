package db

import (
	"context"
	"testing"

	"github.com/kuthumipepple/accounting-lite/util"
	"github.com/stretchr/testify/require"
)

func addRandomCustomer(t *testing.T) Customer {
	arg := AddCustomerParams{
		Name:    util.RandomName(),
		Phone:   util.RandomPhone(),
		Address: util.RandomAddress(),
		Email:   util.RandomEmail(),
	}

	customer, err := testDb.AddCustomer(context.Background(), arg)
	require.NoError(t, err)
	require.NotEmpty(t, customer)
	require.Equal(t, arg.Name, customer.Name)
	require.Equal(t, arg.Phone, customer.Phone)
	require.Equal(t, arg.Address, customer.Address)
	require.Equal(t, arg.Email, customer.Email)
	require.NotZero(t, customer.ID)

	return customer
}

func TestAddCustomer(t *testing.T) {
	addRandomCustomer(t)
}

func TestGetCustomer(t *testing.T) {
	customer1 := addRandomCustomer(t)
	customer2, err := testDb.GetCustomer(context.Background(), customer1.ID)
	require.NoError(t, err)
	require.NotEmpty(t, customer2)

	require.Equal(t, customer1.ID, customer2.ID)
	require.Equal(t, customer1.Name, customer2.Name)
	require.Equal(t, customer1.Phone, customer2.Phone)
	require.Equal(t, customer1.Address, customer2.Address)
	require.Equal(t, customer1.Email, customer2.Email)
}