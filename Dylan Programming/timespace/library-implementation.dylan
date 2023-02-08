module: timespace

// ----------------------------------------------------------------------------

// Abstract class for time and angle
define abstract class <sixty-unit> (<object>)
  slot total-seconds :: <integer>, init-keyword: total-seconds:;
end class <sixty-unit>;

// Read units, minutes and seconds
define method decode-total-seconds
  (sixty-unit :: <sixty-unit>)
    => (max-unit :: <integer>, minutes :: <integer>, seconds :: <integer>)
  decode-total-seconds(abs(sixty-unit.total-seconds))
end method decode-total-seconds;

// ----------------------------------------------------------------------------

// Decode seconds from integer
define method decode-total-seconds
  (total-seconds :: <integer>)
    => (hours :: <integer>, minutes :: <integer>, seconds :: <integer>)
  let (total-minutes, seconds) = truncate/(total-seconds, 60);
  let (hours, minutes) = truncate/(total-minutes, 60);
  values(hours, minutes, seconds)
end method decode-total-seconds;

// Encode seconds to integer
define method encode-total-seconds
  (max-unit :: <integer>, minutes :: <integer>, seconds :: <integer>)
    => (total-seconds :: <integer>)
  ((max-unit * 60) + minutes) * 60 + seconds
end method encode-total-seconds;

// ----------------------------------------------------------------------------

// Generic function for displaying objects
define generic say (any-object :: <object>) => ();

// ----------------------------------------------------------------------------

// Time
define abstract class <time> (<sixty-unit>)
end class <time>;

// Show hours and minutes with colon
define method say (time :: <time>) => ()
  let (hours, minutes) = decode-total-seconds(time);
  format-out
    ("%d:%s%d", hours, if (minutes < 10) "0" else "" end, minutes);
end method say;

// ----------------------------------------------------------------------------

// Time of day
define class <time-of-day> (<time>)
end class <time-of-day>;

// ----------------------------------------------------------------------------

// Offset
define class <time-offset> (<time>)
end class <time-offset>;

// Is its past?
define method past? (time :: <time-offset>) => (past? :: <boolean>)
  time.total-seconds < 0
end method past?;

// Show offset
define method say (time :: <time-offset>) => ()
  format-out("%s ", if (past?(time)) "minus" else "plus" end);
  next-method();
end method say;

// ----------------------------------------------------------------------------

// Add offsets
define method \+
  (offset1 :: <time-offset>, offset2 :: <time-offset>)
    => (sum :: <time-offset>)
  let sum = offset1.total-seconds + offset2.total-seconds;
  make(<time-offset>, total-seconds: sum)
end method \+;

// Add offset and time of day
define method \+
  (offset :: <time-offset>, time-of-day :: <time-of-day>)
    => (sum :: <time-of-day>)
  make(<time-of-day>,
    total-seconds: offset.total-seconds + time-of-day.total-seconds)
end method \+;

// Add time of day and offset
define method \+
  (time-of-day :: <time-of-day>, offset :: <time-offset>)
    => (sum :: <time-of-day>)
  offset + time-of-day
end method \+;

// Compare times of day
define method \< (time1 :: <time-of-day>, time2 :: <time-of-day>)
    => (less-than? :: <boolean>)
  time1.total-seconds < time2.total-seconds
end method \<;

// Compare offsets
define method \< (time1 :: <time-offset>, time2 :: <time-offset>)
    => (less-than? :: <boolean>)
  time1.total-seconds < time2.total-seconds
end method \<;

// Equal times of day
define method \= (time1 :: <time-of-day>, time2 :: <time-of-day>)
    => (equal? :: <boolean>)
  time1.total-seconds = time2.total-seconds
end method \=;

// Equal offsets
define method \= (time1 :: <time-offset>, time2 :: <time-offset>)
    => (equal? :: <boolean>)
  time1.total-seconds = time2.total-seconds
end method \=;

// ----------------------------------------------------------------------------

// Angle
define abstract class <angle> (<sixty-unit>)
end class <angle>;

// Show angle
define method say (angle :: <angle>) => ()
  let (degrees, minutes, seconds) = decode-total-seconds(angle);
  format-out
    ("%d degrees %d minutes %d seconds", degrees, minutes, seconds);
end method say;

// ----------------------------------------------------------------------------

// Relative angle
define class <relative-angle> (<angle>)
end class <relative-angle>;

// Show relative angle
define method say (angle :: <relative-angle>) => ()
  format-out("%d degrees\n", decode-total-seconds(angle));
end method say;

// ----------------------------------------------------------------------------

// Directed angle
define abstract class <directed-angle> (<angle>)
  slot direction :: <string>, init-keyword: direction:;
end class <directed-angle>;

// Show directed angle
define method say (angle :: <directed-angle>) => ()
  next-method();
  format-out(" %s", angle.direction);
end method say;

// ----------------------------------------------------------------------------

// Latitude
define class <latitude> (<directed-angle>)
end class <latitude>;

// Show latitude
define method say (latitude :: <latitude>) => ()
  next-method();
  format-out(" latitude\n");
end method say;

// ----------------------------------------------------------------------------

// Longitude
define class <longitude> (<directed-angle>)
end class <longitude>;

// Show longitude
define method say (longitude :: <longitude>) => ()
  next-method();
  format-out(" longitude\n");
end method say;

// ----------------------------------------------------------------------------

// Position
define abstract class <position> (<object>)
end class <position>;

// ----------------------------------------------------------------------------

// Absolute position
define class <absolute-position> (<position>)
  slot latitude :: <latitude>, init-keyword: latitude:;
  slot longitude :: <longitude>, init-keyword: longitude:;
end class <absolute-position>;

// Show latitude and longitude
define method say (position :: <absolute-position>) => ()
  say(position.latitude);
  say(position.longitude);
end method say;

// ----------------------------------------------------------------------------

// Relative position
define class <relative-position> (<position>)
  slot distance :: <single-float>, init-keyword: distance:;
  slot angle :: <relative-angle>, init-keyword: angle:;
end class <relative-position>;

// Show relative position
define method say (position :: <relative-position>) => ()
  format-out("%d miles away at heading ", position.distance);
  say(position.angle);
end method say;

// ----------------------------------------------------------------------------

