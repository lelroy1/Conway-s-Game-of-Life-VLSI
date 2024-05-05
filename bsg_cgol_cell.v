/**
* Conway's Game of Life Cell
*
* data_i[7:0] is status of 8 neighbor cells
* data_o is status this cell
* 1: alive, 0: death
*
* when en_i==1:
*   simulate the cell transition with 8 given neighors
* else when update_i==1:
*   update the cell status to update_val_i
* else:
*   cell status remains unchanged
**/

module bsg_cgol_cell (
    input clk_i

    ,input en_i          
    ,input [7:0] data_i

    ,input update_i     
    ,input update_val_i

    ,output logic data_o
  );

  // TODO: Design your bsg_cgl_cell
  // Hint: Find the module to count the number of neighbors from basejump
  logic [3:0] num_ones;
  assign num_ones = data_i[0] + data_i[1] + data_i[2] + data_i[3] + data_i[4] + data_i[5] + data_i[6] + data_i[7];

  logic ps,ns;
  always_ff @(posedge clk_i) begin
    if (update_i) begin
        ps = update_val_i;
    end else begin
      if (en_i) begin
        ps = ns;
      end
    end    
  end

  //always_comb begin
  //  if (ps == 1'b1) begin
  //    if (num_ones == 4'd2 | num_ones == 4'd3) begin
  //      ns = 1'b1;
  //    end else begin 
  //      ns = 1'b0;
  //    end
  //  end else begin
  //    if(num_ones == 4'd3) begin
  //      ns = 1'b1;
  //    end else begin
  //      ns = 1'b0;
  //    end
  //  end
  //end
  always_comb begin
    if (ps == 1'b1 && (num_ones == 4'd2 || num_ones == 4'd3)) begin
      ns = 1'b1;
    end else if (ps == 1'b0 && num_ones == 4'd3) begin
      ns = 1'b1;
    end else begin
      ns = 1'b0;
    end
  end
  assign data_o = ps;

endmodule

