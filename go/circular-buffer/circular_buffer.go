package circular

import "errors"

type Buffer struct {
  buf        []byte
  size       int
  readIndex  int
  writeIndex int
}

func (b *Buffer) advanceReadIndex() {
  b.readIndex = (b.readIndex + 1) % b.size
}

func (b *Buffer) advanceWriteIndex() {
  b.writeIndex = (b.writeIndex + 1) % b.size
}

func (b *Buffer) ReadByte() (byte, error) {
  result := b.buf[b.readIndex]
  if result == 0 {
    return 0, errors.New("Nothing to read")
  }

  b.buf[b.readIndex] = 0
  b.advanceReadIndex()

  return result, nil
}

func (b *Buffer) WriteByte(c byte) error {
  if b.buf[b.writeIndex] != 0 {
    return errors.New("Buffer is full")
  }

  b.buf[b.writeIndex] = c
  b.advanceWriteIndex()

  return nil
}

func (b *Buffer) Overwrite(c byte) {
  full := b.buf[b.writeIndex] != 0

  b.buf[b.writeIndex] = c
  b.advanceWriteIndex()
  if full {
    b.advanceReadIndex()
  }

  return
}

func (b *Buffer) Reset() {
  b.buf = make([]byte, b.size)
  b.readIndex = 0
  b.writeIndex = 0
}

func NewBuffer(size int) *Buffer {
  return &Buffer{buf: make([]byte, size), size: size}
}
