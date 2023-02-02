Module: intdy
Synopsis:
Author:
Copyright:

// Module variable and constant
define variable *x* :: <integer> = 3;
define constant $hi = "Hi";

// Functional style
define method shoe-size-one (person :: <string>)
  if (person = "Larry")
    14
  else
    11
  end if
end method shoe-size-one;

// Imperative style
define method shoe-size-two (person :: <string>)
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
  map(method(x) x + 5 end, numbers);
end method add-five;

// Local methods
define method loc-met(n :: <integer>)
  local method add-two (p)
          p + 2
        end,
        method times-three(r)
          r * 3
        end;
  times-three(add-two(n))
end method loc-met;

// Return method
define method ret-met (string :: <string>) => (res :: <function>)
  local method string-putter()
          format-out(string);
        end;
  string-putter
end method ret-met;

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
  many-args(5,1,2,3);

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

  exit-application(0);

end function main;

main(application-name(), application-arguments());

