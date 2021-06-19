
# waitr

An R package which does nothing, and takes a number of millliseconds doing it. 
It wraps C date-time functions to provide a faster type of Sys.sleep() call,
keeping its own relative time. You can wait _for_ a number of milliseconds, or
wait _until a number of milliseconds have elapsed since a reference point.

The timing is not intended to be very precise, but is good enough for
maintaing an approximate frame-rate, allowind animations to look more or less
the same on different computers and platforms.

Sys.sleep() I found could not always do this, especially for very small
delays, on older or slower machines. On these cases, Sys.sleep(0.01) or less,
seemed to consistently cause very slow frame rates, whereas removing the 
Sys.sleep entirely showed the computer well able to exceed the framerate I
wanted if left in freefall.

<!-- badges: start -->
  [![Project Status: Active – The project has reached a stable, usable state and is being actively developed.](https://www.repostatus.org/badges/latest/active.svg)](https://www.repostatus.org/#active)
  [![R-CMD-check](https://github.com/weshinsley/waitr/workflows/R-CMD-check/badge.svg)](https://github.com/weshinsley/waitr/actions)
  [![codecov.io](https://codecov.io/github/weshinsley/waitr/coverage.svg?branch=v1)](https://codecov.io/github/weshinsley/waitr?branch=v1)
<!-- badges: end -->
  
## Installation

```r
devtools::install_github("weshinsley/waitr")
```

## Usage

Reset the internal clock to zero as follows. This will happen automatically
on the first call to any waitr function.

```r
> waitr::waitr_reset()
[1] 0
```

A delay might look like this.

```r
> system.time(waitr::waitr_delay(500))
   user  system elapsed 
   0.00    0.00    0.51 
```
And here is a delay until a certain relative time - which will be a short
delay if that time has already elapsed.

```r
x <- function() {
  t <- waitr::waitr_reset()
  t1 <- system.time(waitr::waitr_until(1000))[['elapsed']]
  t2 <- system.time(waitr::waitr_until(500))[['elapsed']]
  c(t1, t2)
}

> x()
[1] 0.89 0.00
```

The 0.89 is less than the second we hoped for, because of the overheads in R
of calling `system.time` in that way. But the key point is that the second
call finishes very quickly when the time has elapsed. You can therefore write
code that aims for an average framerate, catching up where it can, with
something in the form:-

```r
  next_frame <- waitr::waitr_timestamp() + 10
  while (TRUE) {
    # Do the work for the frame
    next_frame <- waitr::waitr_until(next_frame + 10)
  }
```

## License

MIT © [Wes Hinsley](https://github.com/weshinsley)
