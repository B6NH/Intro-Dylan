module: hello

// ----------------------------------------------------------------------------

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

// Main method
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

end method main;

// ----------------------------------------------------------------------------

main();

// ----------------------------------------------------------------------------

/*

  Output

  Hello, world
  hi, there
  Lucky number is 14
  {class <integer>}
  Object
  Float
  #({class <string>}, {class <mutable-sequence>},
    {class <mutable-collection>}, {class <sequence>},
    {class <collection>}, {class <mutable-object-with-elements>},
    {class <object-with-elements>}, {class <object>})

*/

// ----------------------------------------------------------------------------
