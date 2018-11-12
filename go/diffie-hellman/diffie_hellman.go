package diffiehellman

import (
	"math/big"
	"math/rand"
	"time"
)

var key = big.NewInt(0)

func PrivateKey(p *big.Int) *big.Int {
	two := big.NewInt(2)
	seed := rand.New(rand.NewSource(time.Now().UnixNano()))

	return key.Rand(seed, key.Sub(p, two)).Add(key, two)
}

func PublicKey(private *big.Int, p *big.Int, g int64) *big.Int {
	return key.Exp(big.NewInt(g), private, p)
}

func SecretKey(private1 *big.Int, public2 *big.Int, p *big.Int) *big.Int {
	return key.Exp(public2, private1, p)
}

func NewPair(p *big.Int, g int64) (*big.Int, *big.Int) {
	private := PrivateKey(p)
	return private, PublicKey(private, p, g)
}
