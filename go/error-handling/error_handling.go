package erratum

// Use opens, uses, and closes a resource and handles any errors
func Use(o ResourceOpener, input string) (err error) {
	resource, err := o()
	if err != nil {
		// if it was a transient error, try again
		if _, ok := err.(TransientError); ok {
			return Use(o, input)
		}

		return err
	}

	defer resource.Close()
	defer func() {
		if r := recover(); r != nil {
			switch e := r.(type) {
			case FrobError:
				resource.Defrob(e.defrobTag)
				err = e
			case error:
				err = e
			}
		}
	}()

	resource.Frob(input)
	return nil
}
