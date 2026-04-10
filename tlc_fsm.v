module tlc_fsm (
  //---------- Input Signals ------------
  input            clk,        // System clock (drives state transitions)
  input            rst_n,      // Active-low asynchronous reset
  input            timer_exp,  // Timer expiry signal (triggers state change)

  //---------- Output Signals ----------
  output reg       signal_out  // Control signal: 1 = GO (GREEN), 0 = STOP/WAIT
);

  //---------- State Registers ---------
  reg [1:0] state;        // Holds current state
  reg [1:0] next_state;   // Holds next state (combinational)

  //---------- FSM State Encoding ------
  localparam RED    = 2'b00;  // Vehicles must stop
  localparam YELLOW = 2'b01;  // Transition state (prepare to stop/go)
  localparam GREEN  = 2'b10;  // Vehicles can go

  //---------- State Register Logic ----
  // Sequential block: updates current state on clock edge
  always @(posedge clk or negedge rst_n) begin
    if (!rst_n)
      state <= RED;          // Reset to RED state
    else
      state <= next_state;   // Move to next state
  end

  //---------- Next State Logic --------
  // Combinational block: decides next state based on current state and timer
  always @(*) begin
    case (state)
      RED    : next_state = timer_exp ? YELLOW : RED;     // RED → YELLOW
      YELLOW : next_state = timer_exp ? GREEN  : YELLOW;  // YELLOW → GREEN
      GREEN  : next_state = timer_exp ? RED    : GREEN;   // GREEN → RED
      default: next_state = RED;                          // Safety fallback
    endcase
  end

  //---------- Output Logic ------------
  // Moore FSM: output depends only on current state
  // HIGH only in GREEN state
  always @(*) begin
    signal_out = (state == GREEN);
  end

endmodule
