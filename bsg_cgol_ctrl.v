module bsg_cgol_ctrl #(
   parameter `BSG_INV_PARAM(max_game_length_p)
  ,localparam game_len_width_lp=`BSG_SAFE_CLOG2(max_game_length_p+1)
) (
   input clk_i
  ,input reset_i

  ,input en_i

  // Input Data Channel
  ,input  [game_len_width_lp-1:0] frames_i
  ,input  v_i
  ,output ready_o

  // Output Data Channel
  ,input yumi_i
  ,output v_o

  // Cell Array
  ,output update_o
  ,output en_o
);

  wire unused = en_i; // for clock gating, unused
  
  typedef enum logic [1:0] {ready, prepping, working, done} state;
  state  ns, ps;

  logic [game_len_width_lp-1:0] count; 
  logic [game_len_width_lp-1:0] frames_i_n;

  bsg_cycle_counter 
    #(.width_p(game_len_width_lp))
    cycle_counter
      (.clk_i
      ,.reset_i(~(ps==working))
      ,.ctr_r_o(count));

  assign ready_o = ps == ready;
  assign v_o = ps == done;
  assign update_o = ps == ready;
  assign en_o = ps == working;

  always_comb
    begin
      ns = ps;
      if (ready_o & v_i) begin
        ns = prepping;
      end else if (ps == prepping) begin
        ns = working;
      end else if ((ps == working) & (count == frames_i_n - 1)) begin
        ns = done;
      end else if ((ps == done) & yumi_i) begin
        ns = ready; 
      end
    end

  always_ff @(posedge clk_i)
    begin
      if (v_i) 
        frames_i_n <= frames_i;
      if (reset_i) begin
        ps <= ready;
      end else begin 
        ps <= ns;
      end
    end

endmodule