# Things I learned about OpenSCAD on this project

* module() is really powerful!
    * This allows you to define the size, shape, and position of a *component* for your design, in a modular fashion, as a bunch of reusable components to be assembled
    * Then, in the main body of your program, you can use union() and difference() to assemble the pieces together, while using translate()/rotate()/resize() to position them together
    * This means you can use simple text revision-control tools like git, and get great fidelity from looking at changes over time
    * eg, when you make a change to a module, it doesn't affect the rest of the assembly.
* A .scad file is just text, so you can use your favourite text editor to clean it up, if you like
