module: time

// ----------------------------------------------------------------------------

// Time offset objects
define variable *my-time-offset* :: <time-offset>
  = make(<time-offset>, total-seconds: encode-total-seconds(15, 20, 10));
define variable *your-time-offset* :: <time-offset>
  = make(<time-offset>, total-seconds: - encode-total-seconds(6, 45, 30));

// Time of day objects
define variable *my-time-of-day* :: <time-of-day>
  = make(<time-of-day>, total-seconds: encode-total-seconds(0, 2, 0));
define variable *your-time-of-day* :: <time-of-day>
  = make(<time-of-day>, total-seconds: encode-total-seconds(8, 30, 59));

// Offsets to add
define variable *minus-2-hours* :: <time-offset>
  = make(<time-offset>, total-seconds: - encode-total-seconds (2, 0, 0));
define variable *plus-15-20-45* :: <time-offset>
  = make(<time-offset>, total-seconds: encode-total-seconds (15, 20, 45));

// ----------------------------------------------------------------------------

// Test say function
say(*my-time-offset*); format-out("\n"); // 1
say(*your-time-offset*); format-out("\n"); // 2
say(*my-time-of-day*); format-out("\n"); // 3
say(*your-time-of-day*); format-out("\n"); // 4

// Test offset + offset
begin
  let (h, m, s) = decode-total-seconds(*minus-2-hours* + *plus-15-20-45*);
  show-all(h, m, s); // 5
end;

// Test offset + time of day
begin
  let (h, m, s) = decode-total-seconds(*minus-2-hours* + *your-time-of-day*);
  show-all(h, m, s); // 6
end;

// Test time of day + offset
begin
  let (h, m, s) = decode-total-seconds(*your-time-of-day* + *minus-2-hours*);
  show-all(h, m, s); // 7
end;

// Compare offsets
format-out("%s\n", *plus-15-20-45* = *minus-2-hours*); // 8
format-out("%s\n", *plus-15-20-45* ~= *minus-2-hours*); // 9
format-out("%s\n", *plus-15-20-45* > *minus-2-hours*); // 10

// ----------------------------------------------------------------------------

/*

  Output

  1: plus 15:20
  2: minus 6:45
  3: 0:02
  4: 8:30
  5: 13:20:45
  6: 6:30:59
  7: 6:30:59
  8: #f
  9: #t
  10: #t

*/

// ----------------------------------------------------------------------------

