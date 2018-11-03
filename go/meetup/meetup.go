package meetup

import "time"

type WeekSchedule int

const (
	First WeekSchedule = iota
	Second
	Third
	Fourth
	Last
	Teenth
)

func Day(week WeekSchedule, weekday time.Weekday, month time.Month, year int) int {
	moment := time.Date(year, month, 1, 0, 0, 0, 0, time.UTC)

	switch week {
	case Second:
		moment = moment.AddDate(0, 0, 7)
	case Third:
		moment = moment.AddDate(0, 0, 14)
	case Fourth:
		moment = moment.AddDate(0, 0, 21)
	case Last:
		moment = moment.AddDate(0, 1, -7)
	case Teenth:
		moment = moment.AddDate(0, 0, 12)
	}

	delta := int(weekday - moment.Weekday())
	if delta < 0 {
		delta = int(time.Saturday+1) + delta
	}

	moment = moment.AddDate(0, 0, delta)

	return moment.Day()
}
