package robotname

import (
	"fmt"
	"math/rand"
	"time"
)

type Robot struct {
	name string
}

func init() {
	rand.Seed(time.Now().UnixNano())
}

func (robot *Robot) Name() string {
	if len(robot.name) == 0 {
		robot.generateName()
	}

	return robot.name
}

func (robot *Robot) Reset() {
	robot.name = ""
}

func (robot *Robot) generateName() {
	robot.name = fmt.Sprintf("%c%c%03d", 'A'+rand.Intn(26), 'A'+rand.Intn(26), rand.Intn(999))
}
