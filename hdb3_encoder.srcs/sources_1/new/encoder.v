//`timescale 1ns / 1ps

//// =============================================================================
//// Filename: encoder.v
//// Author: Ng, Renard Rafferty
//// Email: rrng@connect.ust.hk
//// Affiliation: Hong Kong University of Science and Technology
//// -----------------------------------------------------------------------------
//// =============================================================================

//module encoder #(parameter N = 60) (
//  input wire                  clk,          // system clock
//  input wire                  rst,          // system reset (active high)
//  input wire  [0:N-1]         data,         // 2.048MBits/s data 

//  output reg  [0:N-1]         p,            // result 1: quotient
//  output reg  [0:N-1]         n             // result 2: remainder
//);

////  ---------------------CUSTOM CODE--------------------------------//

//// States representing output 
////Evaluate starting bit
////ZERO for processing polarity
////ODD, EVEN only for changing output
//localparam STATE_IDLE = 2'b00,
//	   STATE_PROCESS = 2'b01,
//	   STATE_EVEN = 2'b10,
//	   STATE_ODD  = 2'b11;


//// parity even = 1, odd = 0
//// polarity positive = 1 negative 0
//reg[1:0] state_reg, state_next;
//reg polarity;
//reg parity;
//reg[2:0] count;
//integer index;

//always@(negedge clk)begin
//	if (rst)begin
//		p <= 0;
//		n <= 0;
//		polarity <= 1;
//		parity <= 1;	
//		count <= 0;
//		state_reg <= STATE_IDLE;
//		state_next <= 0;
//		index <= 0;
//	end
//	else begin
//            case(state_reg)
//                STATE_IDLE:begin
//                    if(data[index])begin
                        
//                        if (polarity) begin
//                            p[index] <= 1;
//                        end else begin
//                            n[index] <= 1;
//                        end
                        
//                        state_next <= STATE_PROCESS;
//                        polarity <= ~polarity;
//                        count <= count;
//                        parity <= ~parity;
                        
//                    end else begin
//                        state_next <= STATE_PROCESS;
//                        count <= count + 1;
//                    end
//                end
        
//                STATE_PROCESS:begin
//                    if (count == 4)begin
//                        if (parity == 1)begin
//                            state_next <= STATE_EVEN;
//                        end else begin
//                            state_next <= STATE_ODD;
//                        end
//                    end
                    
//                    if (data[index])begin
//                        count <= 0;	
//                        polarity <= ~polarity;
//                        parity <= ~parity;	
//                        if (polarity) begin
//                            p[index] <= 1;
//                        end else begin
//                            n[index] <= 1;
//                        end
//                    end else begin
//                        count <= count + 1;
//                    end
        
//                end
        
//                STATE_EVEN:begin
                    
//                    if(polarity == 1)begin
//                        n[index] <= 0;
//                        n[index-1] <= 0;
//                        n[index-2] <= 0;
//                        n[index-3] <= 0;
        
//                        p[index] <= 1;
//                        p[index-1] <= 0;
//                        p[index-2] <= 0;
//                        p[index-3] <= 1;
//                    end else begin
//                        n[index] <= 1;
//                        n[index-1] <= 0;
//                        n[index-2] <= 0;
//                        n[index-3] <= 1;
        
//                        p[index] <= 0;
//                        p[index-1] <= 0;
//                        p[index-2] <= 0;
//                        p[index-3] <= 0;
                    
//                    end
//                    state_next <= STATE_PROCESS;
        
//                end
        
//                STATE_ODD:begin	
//                    if(polarity == 1)begin
//                        n[index] <= 0;
//                        n[index-1] <= 0;
//                        n[index-2] <= 0;
//                        n[index-3] <= 0;
        
//                        p[index] <= 0;
//                        p[index-1] <= 0;
//                        p[index-2] <= 0;
//                        p[index-3] <= 1;
                    
//                    end else begin
//                        n[index] <= 0;
//                        n[index-1] <= 0;
//                        n[index-2] <= 0;
//                        n[index-3] <= 1;
        
//                        p[index] <= 0;
//                        p[index-1] <= 0;
//                        p[index-2] <= 0;
//                        p[index-3] <= 1;
                    
//                    end
//                    state_next <= STATE_PROCESS;
        
//                end
//            endcase
            
//            state_reg <= state_next;
//            index <= index + 1;
//        end
//    end

//endmodule

//`timescale 1ns / 1ps

//// =============================================================================
//// Filename: encoder.v
//// Author: Ng, Renard Rafferty
//// Email: rrng@connect.ust.hk
//// Affiliation: Hong Kong University of Science and Technology
//// -----------------------------------------------------------------------------
//// =============================================================================

module encoder #(parameter N = 60) (
  input wire                  clk,          // system clock
  input wire                  rst,          // system reset (active high)
  input wire  [0:N-1]         data,         // 2.048MBits/s data 

  output reg  [0:N-1]         p,            // result 1: quotient
  output reg  [0:N-1]         n             // result 2: remainder
);

//  ---------------------CUSTOM CODE--------------------------------//

// States representing output 
//Evaluate starting bit
//ZERO for processing polarity
//ODD, EVEN only for changing output
localparam STATE_IDLE = 2'b00,
	   STATE_PROCESS = 2'b01,
	   STATE_EVEN = 2'b10,
	   STATE_ODD  = 2'b11;


// parity even = 1, odd = 0
// polarity positive = 1 negative 0
reg[1:0] state_reg, state_next;
reg polarity;
reg parity;
reg[2:0] count;
integer index;

reg test1 = 0;reg test2= 0; reg test3= 0;reg test4 = 0; reg inputbit = 0;

always@(negedge clk)begin
	if (rst)begin
		p <= 0;
		n <= 0;
		polarity <= 1;
		parity <= 1;	
		count <= 0;
		state_reg <= STATE_IDLE;
		state_next <= 0;
		index <= 0;
	end
	else begin
            case(state_reg)
                STATE_IDLE:begin
                    if(data[index])begin
                        
                        if (polarity) begin
                            p[index] <= 1;
                        end else begin
                            n[index] <= 1;
                        end
                        
                        state_next <= STATE_PROCESS;
                        polarity <= ~polarity;
                        count <= count;
                        parity <= ~parity;
                        
                    end else begin
                        state_next <= STATE_PROCESS;
                        count <= count + 1;
                    end
                end
        
                STATE_PROCESS:begin
                    inputbit = data[index];
                    if (data[index])begin
                        
                        count <= 0;	
                        polarity <= ~polarity;
                        parity <= ~parity;	
                        if (polarity) begin
                            p[index] <= 1;
               
                        end else begin
                            n[index] <= 1;
                        end
                        
                        
                    end else begin
                        if (count == 3)begin
                            if (parity == 1)begin
                                if(polarity == 1)begin
                                    n[index] <= 0;
                                    n[index-1] <= 0;
                                    n[index-2] <= 0;
                                    n[index-3] <= 0;
                    
                                    p[index] <= 1;
                                    p[index-1] <= 0;
                                    p[index-2] <= 0;
                                    p[index-3] <= 1;
                                    
                                    test1 <= ~test1 ;
                                end else begin
                                    n[index] <= 1;
                                    n[index-1] <= 0;
                                    n[index-2] <= 0;
                                    n[index-3] <= 1;
                    
                                    p[index] <= 0;
                                    p[index-1] <= 0;
                                    p[index-2] <= 0;
                                    p[index-3] <= 0;
                                    
                                    test2 <= ~test2 ;
                                
                                end
                            end else begin
                                if(polarity == 1)begin
                                    n[index] <= 0;
                                    n[index-1] <= 0;
                                    n[index-2] <= 0;
                                    n[index-3] <= 0;
                    
                                    p[index] <= 1;
                                    p[index-1] <= 0;
                                    p[index-2] <= 0;
                                    p[index-3] <= 0;
                                    
                                    test3 <= ~test3 ;
                                
                                end else begin
                                    n[index] <= 1;
                                    n[index-1] <= 0;
                                    n[index-2] <= 0;
                                    n[index-3] <= 0;
                    
                                    p[index] <= 0;
                                    p[index-1] <= 0;
                                    p[index-2] <= 0;
                                    p[index-3] <= 0;
                                
                                    test4 <= ~test4 ;
                                end
                            end
                            
                            polarity <= ~polarity;
                            parity <= 1;	
                            count <= 0;
                        end else begin    
                            count <= count + 1;
                        end
                    end
        
                  state_next <= STATE_PROCESS;
                end

            endcase
            
            state_reg <= state_next;
            index <= index + 1;
        end
    end

endmodule


//`timescale 1ns / 1ps

//module hdb3_encoder #(parameter N = 60) (
//    input wire clk,          // system clock
//    input wire rst,          // system reset (active high)
//    input wire [N-1:0] data, // input data
//    output reg [N-1:0] p,    // positive output
//    output reg [N-1:0] n     // negative output
//);

//integer i, zero_count, one_count;
//reg last_pulse_positive; 

//always @(posedge clk) begin
//    if (rst) begin
//        p <= 0;
//        n <= 0;
//        zero_count <= 0;
//        one_count <= 0;
//        last_pulse_positive <= 1; 
//    end else begin
//        for (i = 0; i < N; i = i + 1) begin
//            if (data[i] == 1'b1) begin
//                if (last_pulse_positive) begin
//                    p[i] <= 1;
//                    n[i] <= 0;
//                end else begin
//                    p[i] <= 0;
//                    n[i] <= 1;
//                end
//                last_pulse_positive <= ~last_pulse_positive;
//                one_count <= one_count + 1;
//                zero_count <= 0;
//            end else begin
//                p[i] <= 0;
//                n[i] <= 0;
//                zero_count <= zero_count + 1;

//                if (zero_count == 4) begin
//                    p[i] <= last_pulse_positive ? 0 : 1;  
//                    n[i] <= last_pulse_positive ? 1 : 0;  
//                    zero_count <= 0; 
//                    last_pulse_positive <= ~last_pulse_positive; 

//                    if (one_count % 2 != 0) begin
//                        p[i-3] <= !last_pulse_positive ? 1 : 0;  // B
//                        n[i-3] <= !last_pulse_positive ? 0 : 1;  // B
//                    end
//                    one_count <= 0;  

//                    p[i-2] <= 0;
//                    p[i-1] <= 0;
//                    n[i-2] <= 0;
//                    n[i-1] <= 0;
//                end
//            end
//        end
//    end
//end

//endmodule