module: time

// ----------------------------------------------------------------------------

// Convert to seconds
define method encode-total-seconds
  (hours :: <integer>, minutes :: <integer>, seconds :: <integer>)
    => (total-seconds :: <integer>)
  ((hours * 60) + minutes) * 60 + seconds;
end method encode-total-seconds;

// Convert from seconds
define method decode-total-seconds (total-seconds :: <integer>)
    => (hours :: <integer>, minutes :: <integer>, seconds :: <integer>)
  let (total-minutes, seconds) = truncate/(total-seconds, 60);
  let (hours, minutes) = truncate/(total-minutes, 60);
  values(hours, minutes, seconds);
end method decode-total-seconds;

// ----------------------------------------------------------------------------

// Explicit generic function
define generic say (any-object :: <object>) => ();

// ----------------------------------------------------------------------------

// Time
define class <time> (<object>)
  slot total-seconds :: <integer>, init-keyword: total-seconds:;
end class <time>;

// Show hours and minutes
define method say (time :: <time>) => ()
  let (hours, minutes) = decode-total-seconds(time);
  format-out
    ("%d:%s%d", hours, if (minutes < 10) "0" else "" end, minutes);
end method say;

// ----------------------------------------------------------------------------

// Time of day
define class <time-of-day> (<time>)
end class <time-of-day>;

// Convert from object
define method decode-total-seconds (time :: <time>)
    => (hours :: <integer>, minutes :: <integer>, seconds :: <integer>)
  decode-total-seconds(abs(time.total-seconds));
end method decode-total-seconds;

// ----------------------------------------------------------------------------

// Offset
define class <time-offset> (<time>)
end class <time-offset>;

// Show offset
define method say (time :: <time-offset>) => ()
  format-out("%s ", if (past?(time)) "minus" else "plus" end);
  next-method();
end method say;

// Check if value is negative
define method past? (time :: <time-offset>) => (past? :: <boolean>)
  time.total-seconds < 0;
end method past?;

// ----------------------------------------------------------------------------

// Add time offsets
define method \+
  (offset1 :: <time-offset>, offset2 :: <time-offset>)
    => (sum :: <time-offset>)
  let sum = offset1.total-seconds + offset2.total-seconds;
  make(<time-offset>, total-seconds: sum);
end method \+;

// Offset + Time of day
define method \+
  (offset :: <time-offset>, time-of-day :: <time-of-day>)
    => (sum :: <time-of-day>)
  make(<time-of-day>,
       total-seconds: offset.total-seconds + time-of-day.total-seconds);
end method \+;

// Time of day + Offset
define method \+
  (time-of-day :: <time-of-day>, offset :: <time-offset>)
    => (sum :: <time-of-day>)
  offset + time-of-day;
end method \+;

// Two time objects can't be added
// This method is not part of the library
/*
define method \+ (time1 :: <time>, time2 :: <time>)
  error("Sorry, we can't add a %s to a %s.",
  object-class(time1), object-class(time2));
end method \+;
*/

// Compare times of day
define method \<
  (time1 :: <time-of-day>, time2 :: <time-of-day>)
    => (boolean :: <boolean>)
  time1.total-seconds < time2.total-seconds;
end method \<;

// Compare offsets
define method \<
  (time1 :: <time-offset>, time2 :: <time-offset>)
    => (boolean :: <boolean>)
  time1.total-seconds < time2.total-seconds;
end method \<;

// Equal times of day
define method \=
  (time1 :: <time-of-day>, time2 :: <time-of-day>)
    => (boolean :: <boolean>)
  time1.total-seconds = time2.total-seconds;
end method \=;

// Equal offsets
define method \=
  (time1 :: <time-offset>, time2 :: <time-offset>)
    => (boolean :: <boolean>)
  time1.total-seconds = time2.total-seconds;
end method \=;

// ----------------------------------------------------------------------------

// Show three integers
define method show-all(h :: <integer>, m :: <integer>, s :: <integer>)
  format-out("%s:%s:%s\n", h, m, s);
end method show-all;

// ----------------------------------------------------------------------------

