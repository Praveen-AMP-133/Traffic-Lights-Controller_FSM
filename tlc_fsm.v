module tlc_fsm (
  //---------- Input signals ------------
  input            clk,      
  input            rst_n,
  input            timer_exp,
  //--------- Output Signals -----------
  output reg       signal_out
);
  //---------State Registers -----------
  reg [1:0] state;
  reg [1:0] next_state;
  //--------States of FSM---------------
  localparam RED    = 2'b00;
  localparam YELLOW = 2'b01;
  localparam GREEN  = 2'b10;
  
  always@(posedge clk or negedge rst_n) begin
    if(!rst_n) begin
      state <= RED ;
    end else begin
      state <= next_state;
    end
  end
  
  always@(*) begin
    case(state)
      RED     : next_state = timer_exp ? YELLOW : RED    ;
      YELLOW  : next_state = timer_exp ? GREEN  : YELLOW ;
      GREEN   : next_state = timer_exp ? RED    : GREEN  ;
      default : next_state = RED;
    endcase
  end
  
  always @(*) begin
    signal_out = (state == GREEN);
  end
endmodule
