//`timescale 1ns/1ps
`timescale 1ns/1ns
module tb_tlc_fsm;

    reg clk;
    reg rst_n;
    reg timer_exp;
    wire signal_out;

    // Instantiate DUT (Device Under Test)
    tlc_fsm dut (
        .clk        (clk),
        .rst_n      (rst_n),
        .timer_exp  (timer_exp),
        .signal_out (signal_out)
    );

    //---------- Clock Generation ----------
    // 4ns clock period
    always #2 clk = ~clk;

    //---------- Timer Logic ---------------
    // Generates timer_exp pulse every 30 clock cycles
    integer timer;

    always @(posedge clk) begin
      if (timer == 30) begin
        timer     <= 0;     // Reset timer
        timer_exp <= 1;     // Assert timer expiry (1-cycle pulse)
        $display("Timer expired at time %0t", $time);
      end else begin
        timer_exp <= 0;     // Deassert timer
        timer     <= timer + 1;
      end
    end

    //---------- Initial Block -------------
    initial begin
        clk       = 0;
        rst_n     = 0;   // Apply reset
        timer_exp = 0;
        timer     = 0;

        // Release reset after one clock cycle
        @(negedge clk);
        rst_n = 1;

        // Run simulation
        #500 $finish;
    end

    //---------- Monitor -------------------
    // Displays key signals during simulation
    initial begin
        $monitor("T=%0t | rst_n=%b | timer_exp=%b | signal_out=%b",
                  $time, rst_n, timer_exp, signal_out);
    end

    //---------- Waveform Dump -------------
    initial begin
      $dumpfile("traffic_light_controller.vcd");
      $dumpvars(0, tb_tlc_fsm);
    end

endmodule
