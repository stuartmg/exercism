package paasio

import (
	"io"
	"sync"
)

type counter struct {
	sync.Mutex
	bytes int64
	times int
}

type readCounter struct {
	reader io.Reader
	counter
}

type writeCounter struct {
	writer io.Writer
	counter
}

type readWriteCounter struct {
	readCounter
	writeCounter
}

func (c *counter) add(bytes int, err error) (int, error) {
	c.Lock()
	defer c.Unlock()

	c.bytes += int64(bytes)
	c.times++

	return bytes, err
}

func (c *counter) count() (int64, int) {
	c.Lock()
	defer c.Unlock()

	return c.bytes, c.times
}

func (c *readCounter) Read(p []byte) (int, error) {
	return c.add(c.reader.Read(p))
}

func (c *writeCounter) Write(p []byte) (int, error) {
	return c.add(c.writer.Write(p))
}

func (c *readCounter) ReadCount() (int64, int) {
	return c.count()
}

func (c *writeCounter) WriteCount() (int64, int) {
	return c.count()
}

func NewReadCounter(r io.Reader) ReadCounter {
	return &readCounter{reader: r}
}

func NewWriteCounter(w io.Writer) WriteCounter {
	return &writeCounter{writer: w}
}

func NewReadWriteCounter(rw io.ReadWriter) ReadWriteCounter {
	return &readWriteCounter{readCounter: readCounter{reader: rw}, writeCounter: writeCounter{writer: rw}}
}
