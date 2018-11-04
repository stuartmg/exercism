package account

import "sync"

// bank account that is thread safe
type Account struct {
	sync.Mutex
	amount int64
	closed bool
}

// close the account and return the payout balance
func (acct *Account) Close() (int64, bool) {
	acct.Lock()
	defer acct.Unlock()

	if acct.closed {
		return 0, false
	}

	payout := acct.amount
	acct.amount = 0
	acct.closed = true

	return payout, true
}

// return the account balance
func (acct *Account) Balance() (int64, bool) {
	acct.Lock()
	defer acct.Unlock()

	return acct.amount, !acct.closed
}

// deposit or withdrawl (negative deposit) money
func (acct *Account) Deposit(amount int64) (int64, bool) {
	acct.Lock()
	defer acct.Unlock()

	if acct.closed {
		return 0, false
	}

	if amount < 0 && acct.amount+amount < 0 {
		return 0, false
	}

	acct.amount += amount

	return acct.amount, true
}

// open a new account with the initial balance
func Open(amount int64) *Account {
	if amount < 0 {
		return nil
	}

	return &Account{amount: amount, closed: false}
}
