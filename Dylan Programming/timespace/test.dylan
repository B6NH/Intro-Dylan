module: timespace

// ----------------------------------------------------------------------------

// Helper method
let show-three
  = method (a, b, c) format-out("%s %s %s\n", a, b, c); end method;

// Create and show absolute position
format-out("Creating an instance of <absolute-position>:\n");
define variable *my-absolute-position*
  = make(<absolute-position>,
         latitude: make(<latitude>,
                        total-seconds: encode-total-seconds(42, 19, 34),
                        direction: "North"),
         longitude: make(<longitude>,
                         total-seconds: encode-total-seconds(70, 56, 26),
                         direction: "West"));
say(*my-absolute-position*);
format-out("\n");

// ----------------------------------------------------------------------------

// Create and show relative position
format-out("Creating an instance of <relative-position>:\n");
define variable *her-relative-position*
  = make(<relative-position>,
         distance: 30.,
         angle: make(<relative-angle>,
         total-seconds: encode-total-seconds(90, 5, 0)));
say(*her-relative-position*);
format-out("\n");

// ----------------------------------------------------------------------------

format-out("Creating an instance of <time-offset> in *minus-2-hours*.\n");
define variable *minus-2-hours*
  = make(<time-offset>, total-seconds: - encode-total-seconds (2, 0, 0));

format-out("Creating an instance of <time-offset> in *plus-15-20-45*.\n");
define variable *plus-15-20-45*
  = make(<time-offset>, total-seconds: encode-total-seconds (15, 20, 45));

format-out("Creating an instance of <time-of-day> in *var-8-30-59*.\n\n");
define variable *var-8-30-59*
  = make(<time-of-day>, total-seconds: encode-total-seconds (8, 30, 59));

// ----------------------------------------------------------------------------

// Offset addition
begin
  format-out("Adding <time-offset> + <time-offset>: *minus-2-hours* + *plus-15-20-45*:\n");
  let (a, b, c) = decode-total-seconds(*minus-2-hours* + *plus-15-20-45*);
  show-three(a, b, c);
end;

// Offset and time of day addition
begin
  format-out("Adding <time-offset> + <time-of-day>: *minus-2-hours* + *var-8-30-59*:\n");
  let (a, b, c) = decode-total-seconds(*minus-2-hours* + *var-8-30-59*);
  show-three(a, b, c);
end;

// Time of day and offset addition
begin
  format-out("Adding <time-of-day> + <time-offset>: *var-8-30-59* + *minus-2-hours*:\n");
  let (a, b, c) = decode-total-seconds(*var-8-30-59* + *minus-2-hours*);
  show-three(a, b, c);
end;

// ----------------------------------------------------------------------------

/*

  Output

  Creating an instance of <absolute-position>:
  42 degrees 19 minutes 34 seconds North latitude
  70 degrees 56 minutes 26 seconds West longitude

  Creating an instance of <relative-position>:
  30.000000 miles away at heading 90 degrees

  Creating an instance of <time-offset> in *minus-2-hours*.
  Creating an instance of <time-offset> in *plus-15-20-45*.
  Creating an instance of <time-of-day> in *var-8-30-59*.

  Adding <time-offset> + <time-offset>: *minus-2-hours* + *plus-15-20-45*:
  13 20 45
  Adding <time-offset> + <time-of-day>: *minus-2-hours* + *var-8-30-59*:
  6 30 59
  Adding <time-of-day> + <time-offset>: *var-8-30-59* + *minus-2-hours*:
  6 30 59

*/

// ----------------------------------------------------------------------------

