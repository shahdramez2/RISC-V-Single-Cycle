module RISC_tb ();
	
	/**** Local Parameters ******/
	localparam WIDTH = 32;
	localparam Tclk  = 20;
	
	/**** Signals Declaration ******/
	reg clk, reset_n;


	/**** Counters Generation ******/
	integer errorCases, correctCases, testCases;

	/**** RISCV Instantiation ******/
	RISCV #(.INST_WIDTH(WIDTH), 
			.IMMSEL_WIDTH(3), 
			.PC_WIDTH(WIDTH),
			.DATA_WIDTH(WIDTH),
			.DATAMEM_ADDR_WIDTH(WIDTH),
			.ALUSEL_WIDTH(3))
			 DUT
			(.clk(clk),
			.reset_n(reset_n)
			);

    
    /**** Clock Generation ******/
    initial begin
    	clk = 1'b0;
    	forever #(Tclk/2) clk = ~clk;
    end


    /********* Directed test cases ************/
    initial begin

    	//initialize counters to zero
    	errorCases   = 0;
    	correctCases = 0;
    	testCases    = 0;


		reset_check();


		//The following checking conditions are based on the attached machine code along with this project 
	
    	check_regfile (2,  5,  1);
    	check_regfile (3, 12,  2);
    	check_regfile (7,  3,  3);
    	check_regfile (4,  7,  4);
    	check_regfile (5,  4,  5);
    	check_regfile (5,  11, 6);

    	check_PC ('h1C,7);

    	check_regfile (4,  0,  8);

    	check_PC ('h28,9);

    	check_regfile (4,  1,  10);
    	check_regfile (7,  12, 12);
    	check_regfile (7,  7,  13);

    	check_DMEM (96,  7,  14);

    	check_regfile (2,  7,  15);
    	check_regfile (9,  18, 16);

    	check_PC ('h48,17);

    	check_regfile (2,  25, 19);

    	check_DMEM (100,25, 20);


    	$display("%t: errorCases = %0d \t correctCases = %0d \t testCases = %0d", $time, errorCases, correctCases, testCases);
    	
    	$stop;
    end

/***********************************************************************************************************/

   /*********Tasks ************/

    task reset_check (); 
    	reset_n = 1'b0;
    	@(negedge clk);
    	reset_n = 1'b1;
    endtask


	task check_PC (input [31:0] expected_PC, input [4:0]codeLine);
		@(negedge clk);
		if(DUT.inst_CPU_wrapper.inst_Datapath.PC.Q !== expected_PC) begin
			errorCases ++;
			testCases ++;
    		$display("%t:ERROR in line %0d. PC_value = %0h while the expected_PC_value = %0h",     $time,codeLine, DUT.inst_CPU_wrapper.inst_Datapath.PC.Q, expected_PC);
    	end
    	else begin
    		correctCases ++;
    		testCases ++;
    	end
	endtask 



	task check_regfile (input [4:0] index, input [31:0] expected_value, input [4:0]codeLine);
		@(negedge clk);
		if(DUT.inst_CPU_wrapper.inst_Datapath.reg_file_inst.reg_file[index] !== expected_value) begin
			errorCases ++;
			testCases ++;
    		$display("%t:ERROR in line %0d. regFile[%0d] = %0d while the expected_value = %0d", $time,codeLine, index, DUT.inst_CPU_wrapper.inst_Datapath.reg_file_inst.reg_file[index] , expected_value);
    	end
    	else begin
    		correctCases ++;
    		testCases ++;
    	end
	endtask



	task check_DMEM (input [9:0] index, input [31:0] expected_value, input [4:0]codeLine);
		@(negedge clk);
		if(DUT.DMEM_inst.dmem[index] !== expected_value) begin
			errorCases ++;
    		testCases ++;
    		$display("%t:ERROR in line %0d. DMEM[%0d] = %0d while the expected_value = %0d", $time,codeLine, index, DUT.DMEM_inst.dmem[index], expected_value);
    	end
    	else begin
    		correctCases ++;
    		testCases ++;
    	end
	endtask
endmodule 
