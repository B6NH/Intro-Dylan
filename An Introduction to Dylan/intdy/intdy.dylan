Module: intdy
Synopsis:
Author:
Copyright:

// Module variable and constant
define variable *x* :: <integer> = 3;
define constant $hi = "Hi";
define constant $governors-car = make(<car>, sn: 11122333);

// Functional style
define method shoe-size-one (person :: <string>) => (i :: <integer>)
  if (person = "Larry")
    14
  else
    11
  end if;
end method shoe-size-one;

// Imperative style
define method shoe-size-two (person :: <string>) => (i :: <integer>)
  let the-size = 11;
  if (person = "Joe")
    the-size := 14;
  end if;
  the-size
end method shoe-size-two;

// Explicitly specified return value
define method sum-ints (x :: <integer>, y :: <integer>) => (sum :: <integer>)
  x + y
end method sum-ints;

// Parameters in 'arguments'
define method many-args (arg-one :: <integer>, #rest arguments) => ()
  format-out("Len arguments: %d\n", size(arguments));
end method many-args;

// Return two values
define method ret-two () => (str :: <string>, thing)
  values("text", 2)
end method ret-two;

// Anonymous method
define method add-five (numbers :: <list>) => (out :: <list>)
  map(method(x) x + 5 end method, numbers);
end method add-five;

// Local methods
define method loc-met (n :: <integer>) => (i :: <integer>)
  local method add-two (p)
          p + 2
        end method add-two,
        method times-three(r)
          r * 3
        end method times-three;
  times-three(add-two(n))
end method loc-met;

// Return method
define method ret-met (string :: <string>) => (res :: <function>)
  local method string-putter()
          format-out(string);
        end method string-putter;
  string-putter
end method ret-met;

// Generic function
define method display (i :: <integer>) => ()
  format-out("Integer\n");
end method display;
define method display (s :: <string>) => ()
  format-out("String\n");
end method display;
define method display (f :: <float>) => ()
  format-out("Float\n");
end method display;

// Function with keyword arguments and default values
define method print-records (records :: <collection>, #key init-codes = "", lines-per-page = 66) => ()
  format-out("Records: %s, Codes: %s, Lines: %d\n", records, init-codes, lines-per-page);
end method print-records;

// Various keyword arguments
define method subseq (seq :: <sequence>, #key start :: <integer> = 0, end: _end :: <integer> = seq.size) => ()
  format-out("Sequence: %s, Start: %s, End: %d\n", seq, start, _end);
end method subseq;

// Class definition
define abstract class <vehicle> (<object>)
  slot serial-number :: <integer>,
    required-init-keyword: sn:;
  slot owner :: <string>,
    init-keyword: owner:,
    init-value: "Northern Motors";
end class <vehicle>;

// Make abstract class instantiable
define method make (class == <vehicle>, #rest keys, #key big?) => (vehicle :: <vehicle>)
  if (big?)
    apply(make, <truck>, tons: 2, keys)
  else
    apply(make, <car>, keys)
  end if;
end method make;

// Initialize object
define method initialize (v :: <vehicle>, #key)
  next-method();
  if (v.serial-number < 1000000)
    error("Bad serial number!");
  end if;
end method initialize;

// Subclass
define class <car> (<vehicle>)
end class <car>;

// Subclass with new slot
define class <truck> (<vehicle>)
  slot capacity, required-init-keyword: tons:;
end class <truck>;

// Generic function for vehicle, car and truck
define generic tax (v :: <vehicle>) => (tax-in-dollars :: <float>);
define method tax (v :: <vehicle>) => (tax-in-dollars :: <float>)
  100.00
end method tax;
define method tax (c :: <car> ) => (tax-in-dollars :: <float>)
  50.00
end method tax;
define method tax (t :: <truck>) => (tax-in-dollars :: <float>)
  next-method() + t.capacity * 10.00
end method tax;

// Inspector
define class <inspector> (<object>)
end class <inspector>;

// State inspector
define class <state-inspector> (<inspector>)
end class <state-inspector>;

// Generic vehicle inspect
define generic inspect-vehicle (v :: <vehicle>, i :: <inspector>) => ();
define method inspect-vehicle (v :: <vehicle>, i :: <inspector>) => ()
  format-out("Looking for rust\n");
end method inspect-vehicle;
define method inspect-vehicle (car :: <car>, i :: <inspector>) => ()
  next-method();
  format-out("Checking seat belts\n");
end method inspect-vehicle;
define method inspect-vehicle (truck :: <truck>, i :: <inspector>) => ()
  next-method();
  format-out("Checking cargo attachments\n");
end method inspect-vehicle;
define method inspect-vehicle (car :: <car>, i :: <state-inspector>) => ()
  next-method();
  format-out("Checking insurance\n");
end method inspect-vehicle;
define method inspect-vehicle (car == $governors-car, i :: <state-inspector>) => ()
  format-out("Waving through\n");
end method inspect-vehicle;

define function main (name :: <string>, arguments :: <vector>)

  // Display values returned from methods
  format-out("Size 1: %d\n", shoe-size-one("Larry"));
  format-out("Size 2: %d\n", shoe-size-two("Person"));

  // Create variable
  let a :: <integer> = 3;

  // Rebind
  a := 5;

  // Parallel assignment
  let (b, c, d) = values(2, 7, 8);

  // Output
  format-out("Sum 1: %d\n", a + b);
  format-out("Sum 2: %d\n", \+(c, d));
  format-out("Sum 3: %d\n", sum-ints(15, 7));

  // Module values
  format-out("Module variable and constant: %s, %d!\n", $hi, *x*);

  // Call method with variable number of parameters
  many-args(5, 1, 2, 3);

  // Two values from function
  let (v1, v2) = ret-two ();
  format-out("Vals: %s, %d\n", v1, v2);

  // List
  let lst :: <list> = add-five(#(1, 2, 3, 4));
  format-out("List: %s\n", lst);

  // Method with local methods - (5 + 2) * 3
  format-out("Local: %d\n", loc-met(5));

  // Returned method
  let rmet = ret-met("SSString\n");
  rmet();

  // Call generic function
  display(5); display(7.5); display("abc");

  // Keyword arguments
  print-records(#(1, 2, 3), init-codes: "mcodes", lines-per-page: 20);
  subseq(#(4, 5, 6), start: 10);

  // Create object using abstract class
  let veh = make(<vehicle>, sn: 2000000);

  // Update slots
  serial-number-setter(1234, veh);
  veh.owner := "Asl";

  // Alternative method
  // serial-number(veh) := 4321;

  // Read values
  format-out("Serial: %d, Owner: %s\n", veh.serial-number, owner(veh));

  // Create two objects
  let (car, tru) =
    values(make(<car>, sn: 5542521, owner: "Cst"),
           make(<truck>, sn: 3721498, tons: 4, owner: "Rkt"));
  capacity-setter(5, tru);

  // Show tax
  format-out("Vehicle tax: %d\n", veh.tax);
  format-out("Car tax: %d\n", tax(car));
  format-out("Truck tax: %d\n", tru.tax);

  // Three objects from abstract class
  let x = 9786754;
  let (vcar1, vtruck, vcar2) =
    values(make(<vehicle>, sn: x, big?: #f),
           make(<vehicle>, sn: x, big?: #t),
           make(<vehicle>, sn: x));
  format-out("Abstract: %s, %s, %s\n", vcar1, vtruck, vcar2);

  // Multiple dispatch
  let (inspector, car) =
    values(make(<state-inspector>),
           make(<car>, sn: 7775554));

  // Rust, belts and insurance
  inspect-vehicle(car, inspector);

  // Rust and cargo attachments
  inspect-vehicle(vtruck, inspector);

  // Dispatch on specific object
  inspect-vehicle($governors-car, inspector);

  exit-application(0);

end function main;

main(application-name(), application-arguments());

