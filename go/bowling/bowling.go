package bowling

import "errors"

type Game struct {
	balls []int
}

func NewGame() *Game {
	return &Game{}
}

func (g *Game) Roll(pins int) error {
	if g.done() {
		return errors.New("Game is done")
	}

	if pins < 0 || pins > 10 {
		return errors.New("Invalid number of pins")
	}

	midFrame := len(g.balls)%2 == 1
	prevPins := 0
	if midFrame {
		prevPins = g.balls[len(g.balls)-1]
	}

	// can't knock down more than 10 pins in a frame
	if midFrame && prevPins+pins > 10 {
		return errors.New("Invalid number of pins for frame")
	}

	g.balls = append(g.balls, pins)

	// add an extra ball if it was a strike
	if pins == 10 {
		g.balls = append(g.balls, 0)
	}

	return nil
}

func (g *Game) Score() (int, error) {
	score := 0

	// can't caculate score until game is done
	if !g.done() {
		return 0, errors.New("Game is not done yet")
	}

	// score each frame
	for t := 0; t < 20; t += 2 {
		first, second := g.balls[t], g.balls[t+1]
		score += first + second

		// if it was a spare, add the next ball
		if first+second == 10 {
			score += g.balls[t+2]
		}

		// if it was a strike, add the 2nd next ball
		if first == 10 {
			// if next frame was a strike, add the first ball from the next+1 frame
			if g.balls[t+2] == 10 {
				score += g.balls[t+4]
			} else {
				score += g.balls[t+3]
			}
		}
	}

	return score, nil
}

func (g *Game) done() bool {
	balls := len(g.balls)

	// still going if we haven't rolled 20 balls yet
	if balls >= 0 && balls < 20 {
		return false
	}

	// if we've hit 20 balls, we are done unless 10th frame was strike or spare
	if balls == 20 {
		return g.balls[18]+g.balls[19] < 10
	}

	// we only get 1 bonus roll if 10th frame was a spare
	if balls == 21 {
		return g.balls[18] < 10
	}

	// we get 2 bonus rolls if 10th frame was a strike and first bonus roll was a strike
	if balls == 22 && g.balls[18] == 10 && g.balls[20] == 10 {
		return false
	}

	return true
}
