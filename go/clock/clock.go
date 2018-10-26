package clock

import "fmt"

const (
	minutesPerHour = 60
	minutesPerDay  = 1440
)

type Clock struct {
	time int
}

func New(h int, m int) Clock {
	min := (h*minutesPerHour + m) % minutesPerDay
	if min < 0 {
		min += minutesPerDay
	}
	return Clock{time: min}
}

func (c Clock) String() string {
	return fmt.Sprintf("%02d:%02d", c.hour(), c.minute())
}

func (c Clock) Add(m int) Clock {
	return New(0, c.time+m)
}

func (c Clock) Subtract(m int) Clock {
	return New(0, c.time-m)
}

func (c Clock) hour() int {
	return (c.time / 60) % 24
}

func (c Clock) minute() int {
	return c.time % 60
}
