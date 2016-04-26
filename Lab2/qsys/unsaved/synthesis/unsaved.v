// unsaved.v

// Generated using ACDS version 15.1 185

`timescale 1 ps / 1 ps
module unsaved (
    /*
		output wire  hex0,  // debug
		output wire  hex1,  // debug
		output wire  hex2,  // debug
		output wire  hex3,  // debug
		output wire  hex4,  // debug
		output wire  hex5,  // debug
		output wire  hex6,  // debug
		output wire  hex7,  // debug
        */
		input  wire  clk_clk,                        //                        clk.clk
		input  wire  reset_reset_n,                  //                      reset.reset_n
		input  wire  uart_0_external_connection_rxd, // uart_0_external_connection.rxd
		output wire  uart_0_external_connection_txd  //                           .txd
	);

	wire         altpll_0_c0_clk;                           // altpll_0:c0 -> [mm_interconnect_0:altpll_0_c0_clk, new_component_0:avm_clk, rst_controller_001:clk, uart_0:clk]
	wire  [31:0] new_component_0_avalon_master_readdata;    // mm_interconnect_0:new_component_0_avalon_master_readdata -> new_component_0:avm_readdata
	wire         new_component_0_avalon_master_waitrequest; // mm_interconnect_0:new_component_0_avalon_master_waitrequest -> new_component_0:avm_waitrequest
	wire   [4:0] new_component_0_avalon_master_address;     // new_component_0:avm_address -> mm_interconnect_0:new_component_0_avalon_master_address
	wire         new_component_0_avalon_master_read;        // new_component_0:avm_read -> mm_interconnect_0:new_component_0_avalon_master_read
	wire         new_component_0_avalon_master_write;       // new_component_0:avm_write -> mm_interconnect_0:new_component_0_avalon_master_write
	wire  [31:0] new_component_0_avalon_master_writedata;   // new_component_0:avm_writedata -> mm_interconnect_0:new_component_0_avalon_master_writedata
	wire         mm_interconnect_0_uart_0_s1_chipselect;    // mm_interconnect_0:uart_0_s1_chipselect -> uart_0:chipselect
	wire  [15:0] mm_interconnect_0_uart_0_s1_readdata;      // uart_0:readdata -> mm_interconnect_0:uart_0_s1_readdata
	wire   [2:0] mm_interconnect_0_uart_0_s1_address;       // mm_interconnect_0:uart_0_s1_address -> uart_0:address
	wire         mm_interconnect_0_uart_0_s1_read;          // mm_interconnect_0:uart_0_s1_read -> uart_0:read_n
	wire         mm_interconnect_0_uart_0_s1_begintransfer; // mm_interconnect_0:uart_0_s1_begintransfer -> uart_0:begintransfer
	wire         mm_interconnect_0_uart_0_s1_write;         // mm_interconnect_0:uart_0_s1_write -> uart_0:write_n
	wire  [15:0] mm_interconnect_0_uart_0_s1_writedata;     // mm_interconnect_0:uart_0_s1_writedata -> uart_0:writedata
	wire         rst_controller_reset_out_reset;            // rst_controller:reset_out -> altpll_0:reset
	wire         rst_controller_001_reset_out_reset;        // rst_controller_001:reset_out -> [mm_interconnect_0:new_component_0_reset_sink_reset_bridge_in_reset_reset, new_component_0:avm_rst, uart_0:reset_n]

	unsaved_altpll_0 altpll_0 (
		.clk       (clk_clk),                        //       inclk_interface.clk
		.reset     (rst_controller_reset_out_reset), // inclk_interface_reset.reset
		.read      (),                               //             pll_slave.read
		.write     (),                               //                      .write
		.address   (),                               //                      .address
		.readdata  (),                               //                      .readdata
		.writedata (),                               //                      .writedata
		.c0        (altpll_0_c0_clk),                //                    c0.clk
		.areset    (),                               //        areset_conduit.export
		.locked    (),                               //        locked_conduit.export
		.phasedone ()                                //     phasedone_conduit.export
	);

	Rsa256Wrapper new_component_0 (
        /*
      .hex0            (hex0),    // debug
		.hex1            (hex1),    // debug
		.hex2            (hex2),    // debug
		.hex3            (hex3),    // debug
		.hex4            (hex4),    // debug
		.hex5            (hex5),    // debug
		.hex6            (hex6),    // debug
		.hex7            (hex7),    // debug
        */
		.avm_rst         (rst_controller_001_reset_out_reset),        //    reset_sink.reset
		.avm_clk         (altpll_0_c0_clk),                           //    clock_sink.clk
		.avm_address     (new_component_0_avalon_master_address),     // avalon_master.address
		.avm_read        (new_component_0_avalon_master_read),        //              .read
		.avm_readdata    (new_component_0_avalon_master_readdata),    //              .readdata
		.avm_write       (new_component_0_avalon_master_write),       //              .write
		.avm_writedata   (new_component_0_avalon_master_writedata),   //              .writedata
		.avm_waitrequest (new_component_0_avalon_master_waitrequest)  //              .waitrequest
	);

	unsaved_uart_0 uart_0 (
		.clk           (altpll_0_c0_clk),                           //                 clk.clk
		.reset_n       (~rst_controller_001_reset_out_reset),       //               reset.reset_n
		.address       (mm_interconnect_0_uart_0_s1_address),       //                  s1.address
		.begintransfer (mm_interconnect_0_uart_0_s1_begintransfer), //                    .begintransfer
		.chipselect    (mm_interconnect_0_uart_0_s1_chipselect),    //                    .chipselect
		.read_n        (~mm_interconnect_0_uart_0_s1_read),         //                    .read_n
		.write_n       (~mm_interconnect_0_uart_0_s1_write),        //                    .write_n
		.writedata     (mm_interconnect_0_uart_0_s1_writedata),     //                    .writedata
		.readdata      (mm_interconnect_0_uart_0_s1_readdata),      //                    .readdata
		.dataavailable (),                                          //                    .dataavailable
		.readyfordata  (),                                          //                    .readyfordata
		.rxd           (uart_0_external_connection_rxd),            // external_connection.export
		.txd           (uart_0_external_connection_txd),            //                    .export
		.irq           ()                                           //                 irq.irq
	);

	unsaved_mm_interconnect_0 mm_interconnect_0 (
		.altpll_0_c0_clk                                        (altpll_0_c0_clk),                           //                                      altpll_0_c0.clk
		.new_component_0_reset_sink_reset_bridge_in_reset_reset (rst_controller_001_reset_out_reset),        // new_component_0_reset_sink_reset_bridge_in_reset.reset
		.new_component_0_avalon_master_address                  (new_component_0_avalon_master_address),     //                    new_component_0_avalon_master.address
		.new_component_0_avalon_master_waitrequest              (new_component_0_avalon_master_waitrequest), //                                                 .waitrequest
		.new_component_0_avalon_master_read                     (new_component_0_avalon_master_read),        //                                                 .read
		.new_component_0_avalon_master_readdata                 (new_component_0_avalon_master_readdata),    //                                                 .readdata
		.new_component_0_avalon_master_write                    (new_component_0_avalon_master_write),       //                                                 .write
		.new_component_0_avalon_master_writedata                (new_component_0_avalon_master_writedata),   //                                                 .writedata
		.uart_0_s1_address                                      (mm_interconnect_0_uart_0_s1_address),       //                                        uart_0_s1.address
		.uart_0_s1_write                                        (mm_interconnect_0_uart_0_s1_write),         //                                                 .write
		.uart_0_s1_read                                         (mm_interconnect_0_uart_0_s1_read),          //                                                 .read
		.uart_0_s1_readdata                                     (mm_interconnect_0_uart_0_s1_readdata),      //                                                 .readdata
		.uart_0_s1_writedata                                    (mm_interconnect_0_uart_0_s1_writedata),     //                                                 .writedata
		.uart_0_s1_begintransfer                                (mm_interconnect_0_uart_0_s1_begintransfer), //                                                 .begintransfer
		.uart_0_s1_chipselect                                   (mm_interconnect_0_uart_0_s1_chipselect)     //                                                 .chipselect
	);

	altera_reset_controller #(
		.NUM_RESET_INPUTS          (1),
		.OUTPUT_RESET_SYNC_EDGES   ("deassert"),
		.SYNC_DEPTH                (2),
		.RESET_REQUEST_PRESENT     (0),
		.RESET_REQ_WAIT_TIME       (1),
		.MIN_RST_ASSERTION_TIME    (3),
		.RESET_REQ_EARLY_DSRT_TIME (1),
		.USE_RESET_REQUEST_IN0     (0),
		.USE_RESET_REQUEST_IN1     (0),
		.USE_RESET_REQUEST_IN2     (0),
		.USE_RESET_REQUEST_IN3     (0),
		.USE_RESET_REQUEST_IN4     (0),
		.USE_RESET_REQUEST_IN5     (0),
		.USE_RESET_REQUEST_IN6     (0),
		.USE_RESET_REQUEST_IN7     (0),
		.USE_RESET_REQUEST_IN8     (0),
		.USE_RESET_REQUEST_IN9     (0),
		.USE_RESET_REQUEST_IN10    (0),
		.USE_RESET_REQUEST_IN11    (0),
		.USE_RESET_REQUEST_IN12    (0),
		.USE_RESET_REQUEST_IN13    (0),
		.USE_RESET_REQUEST_IN14    (0),
		.USE_RESET_REQUEST_IN15    (0),
		.ADAPT_RESET_REQUEST       (0)
	) rst_controller (
		.reset_in0      (~reset_reset_n),                 // reset_in0.reset
		.clk            (clk_clk),                        //       clk.clk
		.reset_out      (rst_controller_reset_out_reset), // reset_out.reset
		.reset_req      (),                               // (terminated)
		.reset_req_in0  (1'b0),                           // (terminated)
		.reset_in1      (1'b0),                           // (terminated)
		.reset_req_in1  (1'b0),                           // (terminated)
		.reset_in2      (1'b0),                           // (terminated)
		.reset_req_in2  (1'b0),                           // (terminated)
		.reset_in3      (1'b0),                           // (terminated)
		.reset_req_in3  (1'b0),                           // (terminated)
		.reset_in4      (1'b0),                           // (terminated)
		.reset_req_in4  (1'b0),                           // (terminated)
		.reset_in5      (1'b0),                           // (terminated)
		.reset_req_in5  (1'b0),                           // (terminated)
		.reset_in6      (1'b0),                           // (terminated)
		.reset_req_in6  (1'b0),                           // (terminated)
		.reset_in7      (1'b0),                           // (terminated)
		.reset_req_in7  (1'b0),                           // (terminated)
		.reset_in8      (1'b0),                           // (terminated)
		.reset_req_in8  (1'b0),                           // (terminated)
		.reset_in9      (1'b0),                           // (terminated)
		.reset_req_in9  (1'b0),                           // (terminated)
		.reset_in10     (1'b0),                           // (terminated)
		.reset_req_in10 (1'b0),                           // (terminated)
		.reset_in11     (1'b0),                           // (terminated)
		.reset_req_in11 (1'b0),                           // (terminated)
		.reset_in12     (1'b0),                           // (terminated)
		.reset_req_in12 (1'b0),                           // (terminated)
		.reset_in13     (1'b0),                           // (terminated)
		.reset_req_in13 (1'b0),                           // (terminated)
		.reset_in14     (1'b0),                           // (terminated)
		.reset_req_in14 (1'b0),                           // (terminated)
		.reset_in15     (1'b0),                           // (terminated)
		.reset_req_in15 (1'b0)                            // (terminated)
	);

	altera_reset_controller #(
		.NUM_RESET_INPUTS          (1),
		.OUTPUT_RESET_SYNC_EDGES   ("deassert"),
		.SYNC_DEPTH                (2),
		.RESET_REQUEST_PRESENT     (0),
		.RESET_REQ_WAIT_TIME       (1),
		.MIN_RST_ASSERTION_TIME    (3),
		.RESET_REQ_EARLY_DSRT_TIME (1),
		.USE_RESET_REQUEST_IN0     (0),
		.USE_RESET_REQUEST_IN1     (0),
		.USE_RESET_REQUEST_IN2     (0),
		.USE_RESET_REQUEST_IN3     (0),
		.USE_RESET_REQUEST_IN4     (0),
		.USE_RESET_REQUEST_IN5     (0),
		.USE_RESET_REQUEST_IN6     (0),
		.USE_RESET_REQUEST_IN7     (0),
		.USE_RESET_REQUEST_IN8     (0),
		.USE_RESET_REQUEST_IN9     (0),
		.USE_RESET_REQUEST_IN10    (0),
		.USE_RESET_REQUEST_IN11    (0),
		.USE_RESET_REQUEST_IN12    (0),
		.USE_RESET_REQUEST_IN13    (0),
		.USE_RESET_REQUEST_IN14    (0),
		.USE_RESET_REQUEST_IN15    (0),
		.ADAPT_RESET_REQUEST       (0)
	) rst_controller_001 (
		.reset_in0      (~reset_reset_n),                     // reset_in0.reset
		.clk            (altpll_0_c0_clk),                    //       clk.clk
		.reset_out      (rst_controller_001_reset_out_reset), // reset_out.reset
		.reset_req      (),                                   // (terminated)
		.reset_req_in0  (1'b0),                               // (terminated)
		.reset_in1      (1'b0),                               // (terminated)
		.reset_req_in1  (1'b0),                               // (terminated)
		.reset_in2      (1'b0),                               // (terminated)
		.reset_req_in2  (1'b0),                               // (terminated)
		.reset_in3      (1'b0),                               // (terminated)
		.reset_req_in3  (1'b0),                               // (terminated)
		.reset_in4      (1'b0),                               // (terminated)
		.reset_req_in4  (1'b0),                               // (terminated)
		.reset_in5      (1'b0),                               // (terminated)
		.reset_req_in5  (1'b0),                               // (terminated)
		.reset_in6      (1'b0),                               // (terminated)
		.reset_req_in6  (1'b0),                               // (terminated)
		.reset_in7      (1'b0),                               // (terminated)
		.reset_req_in7  (1'b0),                               // (terminated)
		.reset_in8      (1'b0),                               // (terminated)
		.reset_req_in8  (1'b0),                               // (terminated)
		.reset_in9      (1'b0),                               // (terminated)
		.reset_req_in9  (1'b0),                               // (terminated)
		.reset_in10     (1'b0),                               // (terminated)
		.reset_req_in10 (1'b0),                               // (terminated)
		.reset_in11     (1'b0),                               // (terminated)
		.reset_req_in11 (1'b0),                               // (terminated)
		.reset_in12     (1'b0),                               // (terminated)
		.reset_req_in12 (1'b0),                               // (terminated)
		.reset_in13     (1'b0),                               // (terminated)
		.reset_req_in13 (1'b0),                               // (terminated)
		.reset_in14     (1'b0),                               // (terminated)
		.reset_req_in14 (1'b0),                               // (terminated)
		.reset_in15     (1'b0),                               // (terminated)
		.reset_req_in15 (1'b0)                                // (terminated)
	);

endmodule
