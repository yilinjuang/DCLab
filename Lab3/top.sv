module top (
    input           i_clk,
    input           i_clk_100k,
    input           i_rst,
    input           key0,
    input           key1,
    input           key2,
    input           key3,
    input           sw0,
    input           sw1,
    input           sw17,
    output  [1:0]   rec_state,
    output  [7:0]   rec_time,
    output  [7:0]   rec_speed,
    output  [19:0]  sram_addr,
    inout   [15:0]  sram_dq,
    output          sram_ce_n,
    output          sram_oe_n,
    output          sram_we_n,
    output          sram_ub_n,
    output          sram_lb_n,
    inout           aud_bclk,
    output          aud_dacdat,
    inout           aud_daclrck,
    input           aud_adcdat,
    inout           aud_adclrck,
    output          i2c_sclk,
    inout           i2c_sdat
);

    parameter IDLE      = 3'b000;
    parameter INIT      = 3'b001;
    parameter REC       = 3'b010;
    parameter P_REC     = 3'b011;
    parameter PLAY      = 3'b100;
    parameter P_PLAY    = 3'b101;

    parameter DISP_IDLE     = 2'b00;
    parameter DISP_REC      = 2'b01;
    parameter DISP_PLAY     = 2'b10;
    parameter DISP_PAUSE    = 2'b11;

    logic [2:0]     state_r, state_w;
    logic           init_rst_r, init_rst_w;
    logic           init_start_r, init_start_w;
    logic           inited_r, inited_w;
    logic [1:0]     audi_state_r, audi_state_w;
    logic [7:0]     audi_time_r, audi_time_w;
    logic [3:0]     audi_speed_r, audi_speed_w;
    //logic [19:0]    sram_addr_r, sram_addr_w;
    //logic [15:0]    sram_dq_r, sram_dq_w;
    //logic           sram_ce_n_r, sram_ce_n_w, sram_oe_n_r, sram_oe_n_w, sram_we_n_r, sram_we_n_w;
    //logic           sram_ub_n_r, sram_ub_n_w, sram_lb_n_r, sram_lb_n_w;
    //logic           aud_xck_r, aud_xck_w, aud_bclk_r, aud_bclk_w, aud_dacdat_r, aud_dacdat_w;
    //logic           aud_daclrck_r, aud_daclrck_w, aud_adcdat_r, aud_adcdat_w, aud_adclrck_r, aud_adclrck_w;

    logic           rec_start_r, rec_start_w, rec_end_r, rec_end_w, rec_rst_r, rec_rst_w, rec_pause_r, rec_pause_w;
    logic           play_start_r, play_start_w, play_end_r, play_end_w, play_rst_r, play_rst_w, play_pause_r, play_pause_w;
    logic [31:0]    time_counter_r, time_counter_w;
    logic [2:0]     speed_scale;

    assign audio_state        = audi_state_r;
    assign audio_time         = audi_time_r;
    assign audio_speed        = audi_speed_r;
    /*
    assign sram_addr        = sram_addr_r;
    assign sram_dq          = sram_oe_n ? sram_dq_r : 1'bz;
    assign sram_ce_n        = sram_ce_n_r;
    assign sram_oe_n        = sram_oe_n_r;
    assign sram_we_n        = sram_we_n_r;
    assign sram_ub_n        = sram_ub_n_r;
    assign sram_lb_n        = sram_lb_n_r;
    assign aud_bclk         = aud_bclk_r;
    assign aud_dacdat       = aud_dacdat_r;
    assign aud_daclrck      = aud_daclrck_r; // no enable, use as output only
    assign aud_adclrck      = aud_adclrck_r; // no enable, use as output only
    */
    I2cInitialize i2cinit(
        .i_clk(i_clk_100k),
        .i_start(init_start_r),
        .i_rst(init_rst_r),
        .o_sclk(i2c_sclk),
        .o_finished(inited_w),
        .io_sdat(i2c_sdat)
    );

    AudioRecorder audi_recorder(
        .start(rec_start_r),
        .stop(rec_end_r),
        .rst(rec_rst_r),
        .pause(rec_pause_r),
        .sram_addr(sram_addr),
        .sram_dq(sram_dq),
        .sram_ce_n(sram_ce_n),
        .sram_oe_n(sram_oe_n),
        .sram_we_n(sram_we_n),
        .sram_ub_n(sram_ub_n),
        .sram_lb_n(sram_lb_n),
        .aud_bclk(aud_bclk),
        .aud_adcdat(aud_adcdat),
        .aud_adclrck(aud_adclrck)
    );

    AudioPlayer audi_player(
        .start(play_start_r),
        .stop(play_end_r),
        .rst(play_rst_r),
        .pause(play_pause_r),
        .speed(rec_speed),
        .interpol_mode(sw17),
        .sram_addr(sram_addr),
        .sram_dq(sram_dq),
        .sram_ce_n(sram_ce_n),
        .sram_oe_n(sram_oe_n),
        .sram_we_n(sram_we_n),
        .sram_ub_n(sram_ub_n),
        .sram_lb_n(sram_lb_n),
        .aud_bclk(aud_bclk),
        .aud_dacdat(aud_dacdat),
        .aud_daclrck(aud_daclrck),
    );


    always_comb begin
        state_w         = state_r;
        init_rst_w      = init_rst_r;
        init_start_w    = init_start_r;
        audi_state_w    = audi_state_r;
        audi_time_w     = audi_time_r;
        audi_speed_w    = audi_speed_r;
        /*
        sram_addr_w     = sram_addr_r;
        sram_dq_w       = sram_dq_r;
        sram_ce_n_w     = sram_ce_n_r;
        sram_oe_n_w     = sram_oe_n_r;
        sram_we_n_w     = sram_we_n_r;
        sram_ub_n_w     = sram_ub_n_r;
        sram_lb_n_w     = sram_lb_n_r;
        aud_xck_w       = aud_xck_r;
        aud_bclk_w      = aud_bclk_r;
        aud_dacdat_w    = aud_dacdat_r;
        aud_daclrck_w   = aud_daclrck_r;
        aud_adcdat_w    = aud_adcdat_r;
        aud_adclrck_w   = aud_adclrck_r;
        */
        rec_start_w     = rec_start_r;
        rec_end_w       = rec_end_r;
        rec_rst_w       = rec_rst_r;
        play_start_w    = play_start_r;
        play_end_w      = play_end_r;
        play_rst_w      = play_rst_r;

        case(state_r)
            IDLE:
                begin
                    audi_state_w = 0;
                    audi_time_w = 63;
                    time_counter_w = 0;
                    if (sw0 == 1'b1) begin
                        audi_time_w = 0;
                        state_w = REC;
                        rec_rst_w = 1'b1;
                        rec_end_w = 1'b0;
                    end else if (sw1 == 1'b1) begin
                        audi_time_w = 0;
                        state_w = PLAY;
                        play_rst_w = 1'b1;
                        play_end_w = 1'b0;
                    end
                end
            INIT:
                begin
                    // I2cInitialize...
                    init_start_w = 1'b1;
                    if (inited_r == 1'b1) begin
                        init_start_w = 0;
                        state_w = IDLE;
                    end
                end
            REC:
                begin
                    audi_state_w = 1;
                    // record...
                    rec_rst_w = 1'b0;
                    rec_start_w = 1'b1;
                    
                    // calculate time
                    time_counter_w = time_counter_r + 1;
                    audi_time_w = time_counter_r / 50000000;
                    
                    // check if paused
                    if (key3 == 1'b1) begin
                        rec_pause_w = 1'b1;
                        state_w = P_REC;
                    end else if (sw0 == 1'b0) begin
                        rec_end_w = 1'b1;
                        state_w = IDLE;
                    end
                end
            P_REC:
                begin
                    audi_state_w = 3;
                    if (key3 == 1'b1) begin
                        rec_pause_w = 1'b0;
                        state_w = REC;
                    end
                end
            PLAY:
                begin
                    audi_state_w = 2;
                    // play...
                    play_rst_w = 1'b0;
                    play_start_w = 1'b1;
                    // calculate time
                    time_counter_w = time_counter_r + 1;
                    if (audi_speed_r >= 9) begin
                        speed_scale = audi_speed_r - 7;
                        audi_time_w = time_counter_r / (50000000 * speed_scale);
                    end else begin
                        speed_scale = audi_speed_r[2:0];
                        audi_time_w = time_counter_r * speed_scale / 50000000;
                    end
                    
                    // modify speed
                    if (key1 == 1'b1) begin
                        if (audi_speed_r >= 1 && audi_speed_r < 8) begin
                            audi_speed_w = audi_speed_r + 1;
                        end else if (audi_speed_r == 9) begin
                            audi_speed_w = 1;
                        end else if (audi_speed_r > 9 && audi_speed_r <= 15) begin
                            audi_speed_w = audi_speed_r - 1;
                        end
                    end else if (key2 == 1'b1) begin
                        if (audi_speed_r > 1 && audi_speed_r <= 8) begin
                            audi_speed_w = audi_speed_r - 1;
                        end else if (audi_speed_r == 1) begin
                            audi_speed_w = 9;
                        end else if (audi_speed_r >= 9 && audi_speed_r < 15) begin
                            audi_speed_w = audi_speed_r + 1;
                        end
                    end
                    
                    // check if paused
                    if (key3 == 1'b1) begin
                        play_pause_w = 1'b1;
                        state_w = P_PLAY;
                    end else if (sw1 == 1'b0) begin
                        play_end_w = 1'b1;
                        state_w = IDLE;
                    end
                end
            P_PLAY:
                begin
                    audi_state_w = 3;
                    if (key1 == 1'b1) begin
                        if (audi_speed_r >= 1 && audi_speed_r < 8) begin
                            audi_speed_w = audi_speed_r + 1;
                        end else if (audi_speed_r == 9) begin
                            audi_speed_w = 1;
                        end else if (audi_speed_r > 9 && audi_speed_r <= 15) begin
                            audi_speed_w = audi_speed_r - 1;
                        end
                    end else if (key2 == 1'b1) begin
                        if (audi_speed_r > 1 && audi_speed_r <= 8) begin
                            audi_speed_w = audi_speed_r - 1;
                        end else if (audi_speed_r == 1) begin
                            audi_speed_w = 9;
                        end else if (audi_speed_r >= 9 && audi_speed_r < 15) begin
                            audi_speed_w = audi_speed_r + 1;
                        end
                    end
                    if (key3 == 1'b1) begin
                        play_pause_w = 1'b0;
                        state_w = PLAY;
                    end
                end
        endcase
    end


    always_ff @(posedge i_clk) begin
        if(i_rst) begin
            state_r         <= INIT;
            init_rst_r      <= 1;
            init_start_r    <= 0;
            audi_state_r    <= DISP_IDLE;
            audi_time_r     <= 0;
            audi_speed_r    <= 1;
            /*
            sram_addr_r     <= 0;
            sram_dq_r       <= 0; // dunno what this should be
            sram_ce_n_r     <= 0; // dunno what this should be
            sram_oe_n_r     <= 0; // dunno what this should be
            sram_we_n_r     <= 0; // dunno what this should be
            sram_ub_n_r     <= 0; // dunno what this should be
            sram_lb_n_r     <= 0; // dunno what this should be
            aud_xck_r       <= 0; // dunno what this should be
            aud_bclk_r      <= 0; // dunno what this should be
            aud_dacdat_r    <= 0; // dunno what this should be
            aud_daclrck_r   <= 0; // dunno what this should be
            aud_adcdat_r    <= 0; // dunno what this should be
            aud_adclrck_r   <= 0; // dunno what this should be
            */
            rec_start_r     <= 0;
            rec_end_r       <= 0;
            rec_rst_r       <= 0;
            rec_pause_r     <= 0;
            play_start_r    <= 0;
            play_end_r      <= 0;
            play_rst_r      <= 0;
            play_pause_r    <= 0;
            time_counter_r  <= 0;
        end else begin
            state_r         <= state_w;
            init_rst_r      <= init_rst_w;
            init_start_r    <= init_start_w;
            audi_state_r    <= audi_state_w;
            audi_time_r     <= audi_time_w;
            audi_speed_r    <= audi_speed_w;
            /*
            sram_addr_r     <= sram_addr_w;
            sram_dq_r       <= sram_dq_w;
            sram_ce_n_r     <= sram_ce_n_w;
            sram_oe_n_r     <= sram_oe_n_w;
            sram_we_n_r     <= sram_we_n_w;
            sram_ub_n_r     <= sram_ub_n_w;
            sram_lb_n_r     <= sram_lb_n_w;
            aud_xck_r       <= aud_xck_w;
            aud_bclk_r      <= aud_bclk_w;
            aud_dacdat_r    <= aud_dacdat_w;
            aud_daclrck_r   <= aud_daclrck_w;
            aud_adcdat_r    <= aud_adcdat_w;
            aud_adclrck_r   <= aud_adclrck_w;
            */
            rec_start_r     <= rec_start_w;
            rec_end_r       <= rec_end_w;
            rec_rst_r       <= rec_rst_w;
            rec_pause_r     <= rec_pause_w;
            play_start_r    <= play_start_w;
            play_end_r      <= play_end_w;
            play_rst_r      <= play_rst_w;
            play_pause_r    <= play_pause_w;
            time_counter_r  <= time_counter_w;
        end
    end

endmodule
