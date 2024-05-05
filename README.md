# Conway-s-Game-of-Life-VLSI
An implementation of Conway's game of life in verilog traced into a fully verified place and routed chip design.<br />

To accomplish this there was a module dedicated to taking care of cell logic which is called bsg_cgol_cell.
After this another module was dedicated for controlling the cells (telling them when to die, stay alive, and come back to life) called bsg_cgol_ctrl.
It is worth noting that many of these modules rely on submodules found in basejump stl. This was done to simplfy the design process and learn how to 
interface verilog designs with standard module libraries. For more information on the details of the design see the project description pdf.
