// create tournament table given results
package tournament

import (
	"bufio"
	"errors"
	"fmt"
	"io"
	"sort"
	"strings"
)

type Team struct {
	Name   string
	Wins   int
	Draws  int
	Losses int
}

type League map[string]*Team

func (t *Team) Points() int {
	return (t.Wins * 3) + t.Draws
}

func (t *Team) Played() int {
	return t.Wins + t.Draws + t.Losses
}

// tally the results from the provider Reader and write the table to the provider Writer
func Tally(in io.Reader, out io.Writer) error {
	league := make(League)
	scanner := bufio.NewScanner(in)

	for scanner.Scan() {
		line := strings.TrimSpace(scanner.Text())

		if line == "" || strings.HasPrefix(line, "#") {
			continue
		}

		parts := strings.Split(line, ";")

		if len(parts) != 3 {
			return errors.New(fmt.Sprintf("Invalid input: %s", line))
		}

		team1 := getTeam(league, parts[0])
		team2 := getTeam(league, parts[1])

		err := processOutcome(team1, team2, parts[2])
		if err != nil {
			return err
		}
	}

	writeTable(league, out)
	return nil
}

func getTeam(league League, name string) *Team {
	if _, ok := league[name]; !ok {
		league[name] = &Team{Name: name}
	}
	return league[name]
}

func processOutcome(team1 *Team, team2 *Team, outcome string) error {
	switch outcome {
	case "win":
		team1.Wins++
		team2.Losses++
	case "draw":
		team1.Draws++
		team2.Draws++
	case "loss":
		team1.Losses++
		team2.Wins++
	default:
		return errors.New(fmt.Sprintf("Invalid outcome: %s", outcome))
	}

	return nil
}

func writeTable(league League, out io.Writer) {
	teams := make([]Team, 0, len(league))
	for _, team := range league {
		teams = append(teams, *team)
	}

	sort.Slice(teams, func(i, j int) bool {
		t1, t2 := teams[i], teams[j]
		return t1.Points() > t2.Points() || (t1.Points() == t2.Points() && t1.Name < t2.Name)
	})

	out.Write([]byte("Team                           | MP |  W |  D |  L |  P\n"))
	for _, team := range teams {
		line := fmt.Sprintf("%-30s | %2d | %2d | %2d | %2d | %2d\n", team.Name, team.Played(), team.Wins, team.Draws, team.Losses, team.Points())
		out.Write([]byte(line))
	}
}
