// gigasecond calculations
package gigasecond

import "time"

// Calculate the moment when someone has lived for 10^9 seconds.
func AddGigasecond(t time.Time) time.Time {
	return t.Add(time.Second * 1e9)
}
