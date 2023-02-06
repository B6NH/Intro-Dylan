module: hello

// No arguments
define method say-hello ()
  format-out("Hello, world\n");
end method say-hello;

// Generic function with two methods
define method say-greeting (greeting :: <object>)
  format-out("%s\n", greeting);
end method say-greeting;
define method say-greeting (greeting :: <integer>)
  format-out("Lucky number is %s\n", greeting);
end method say-greeting;

// Time class
define class <time-of-day> (<object>)
  slot total-seconds :: <integer>, init-keyword: total-seconds:;
end class <time-of-day>;

// Convert to seconds
define method encode-total-seconds (hours :: <integer>, minutes :: <integer>, seconds :: <integer>)
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

// Convert from object
define method decode-total-seconds (time :: <time-of-day>)
    => (hours :: <integer>, minutes :: <integer>, seconds :: <integer>)
  decode-total-seconds(time.total-seconds);
end method decode-total-seconds;

// Show time of day
define method say-time-of-day (time :: <time-of-day>) => ()
  let (hours, minutes) = decode-total-seconds(time);
  format-out("%d:%s%d", hours, if (minutes < 10) "0" else "" end, minutes);
end method say-time-of-day;

define method main ()

  // Method calls
  say-hello();
  say-greeting("hi, there");
  say-greeting(14);

  // Show direct class
  format-out("%=\n", object-class(2000));

  // General instance
  if (instance?(5, <object>)) format-out("Object\n"); end if;

  // Subtype
  if (subtype?(<float>, <object>)) format-out("Float\n"); end if;

  // Show string superclasses
  format-out("%=\n", all-superclasses(<string>));

  // Hours and minutes from time of day
  let tod = make(<time-of-day>, total-seconds: encode-total-seconds(6, 45, 30));
  say-time-of-day(tod); format-out("\n");

end method main;

main();


