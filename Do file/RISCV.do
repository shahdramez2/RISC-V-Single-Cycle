vlog ALU.v ALU_control_unit.v BranchComp.v control_unit.v CPU_wrapper.v CU_wrapper.v Datapath_wrapper.v DMEM.v IMEM.v Imm_Gen.v Mux_2_1.v Mux_3_1.v reg.v reg_file.v RISCV.v RISCV_tb.sv
vsim -voptargs=+acc work.RISC_tb -cover
add wave *


add wave -position insertpoint  \
sim:/RISC_tb/DUT/addr_Dmem \
sim:/RISC_tb/DUT/ALUSEL_WIDTH \
sim:/RISC_tb/DUT/clk \
sim:/RISC_tb/DUT/DATA_WIDTH \
sim:/RISC_tb/DUT/DATAMEM_ADDR_WIDTH \
sim:/RISC_tb/DUT/DataR_wrapper \
sim:/RISC_tb/DUT/DataW_Dmem \
sim:/RISC_tb/DUT/IMMSEL_WIDTH \
sim:/RISC_tb/DUT/INST_WIDTH \
sim:/RISC_tb/DUT/inst_wrapper \
sim:/RISC_tb/DUT/MemRW_wrapper \
sim:/RISC_tb/DUT/PC_out_Imem \
sim:/RISC_tb/DUT/PC_WIDTH \
sim:/RISC_tb/DUT/reset_n
add wave -position insertpoint  \
sim:/RISC_tb/DUT/inst_CPU_wrapper/inst_Datapath/PC/clk \
sim:/RISC_tb/DUT/inst_CPU_wrapper/inst_Datapath/PC/I \
sim:/RISC_tb/DUT/inst_CPU_wrapper/inst_Datapath/PC/Q \
sim:/RISC_tb/DUT/inst_CPU_wrapper/inst_Datapath/PC/REG_WIDTH \
sim:/RISC_tb/DUT/inst_CPU_wrapper/inst_Datapath/PC/reset_n
add wave -position insertpoint sim:/RISC_tb/DUT/inst_CPU_wrapper/inst_Datapath/reg_file_inst/*
add wave -position insertpoint  \
sim:/UART_tb/testWords

add wave -position insertpoint  \
sim:/UART_tb/DUT/receiver/calculated_parity \
sim:/UART_tb/DUT/receiver/clk \
sim:/UART_tb/DUT/receiver/DATA_BITS \
sim:/UART_tb/DUT/receiver/data_state \
sim:/UART_tb/DUT/receiver/DATA_TIME \
sim:/UART_tb/DUT/receiver/full \
sim:/UART_tb/DUT/receiver/idle_state \
sim:/UART_tb/DUT/receiver/parity_bit \
sim:/UART_tb/DUT/receiver/parity_flag \
sim:/UART_tb/DUT/receiver/parity_state \
sim:/UART_tb/DUT/receiver/received_bits_counter \
sim:/UART_tb/DUT/receiver/reset_n \
sim:/UART_tb/DUT/receiver/rx \
sim:/UART_tb/DUT/receiver/rx_done_tick \
sim:/UART_tb/DUT/receiver/rx_dout \
sim:/UART_tb/DUT/receiver/serial_in_shift_reg \
sim:/UART_tb/DUT/receiver/start_state \
sim:/UART_tb/DUT/receiver/START_TIME \
sim:/UART_tb/DUT/receiver/state_next \
sim:/UART_tb/DUT/receiver/state_reg \
sim:/UART_tb/DUT/receiver/STOP_BIT_TICKS \
sim:/UART_tb/DUT/receiver/stop_state \
sim:/UART_tb/DUT/receiver/timer_tick \
sim:/UART_tb/DUT/receiver/timer_tick_counter
add wave -position insertpoint  \
sim:/UART_tb/DUT/transmitter/calculated_parity \
sim:/UART_tb/DUT/transmitter/clk \
sim:/UART_tb/DUT/transmitter/DATA_BITS \
sim:/UART_tb/DUT/transmitter/data_state \
sim:/UART_tb/DUT/transmitter/DATA_TIME \
sim:/UART_tb/DUT/transmitter/idle_state \
sim:/UART_tb/DUT/transmitter/parity_state \
sim:/UART_tb/DUT/transmitter/reset_n \
sim:/UART_tb/DUT/transmitter/sent_bits_counter \
sim:/UART_tb/DUT/transmitter/start_state \
sim:/UART_tb/DUT/transmitter/START_TIME \
sim:/UART_tb/DUT/transmitter/state_next \
sim:/UART_tb/DUT/transmitter/state_reg \
sim:/UART_tb/DUT/transmitter/STOP_BIT_TICKS \
sim:/UART_tb/DUT/transmitter/stop_state \
sim:/UART_tb/DUT/transmitter/timer_tick \
sim:/UART_tb/DUT/transmitter/timer_tick_counter \
sim:/UART_tb/DUT/transmitter/tx \
sim:/UART_tb/DUT/transmitter/tx_din \
sim:/UART_tb/DUT/transmitter/tx_done_tick \
sim:/UART_tb/DUT/transmitter/tx_start
add wave -position insertpoint  \
sim:/UART_tb/DUT/rx_FIFO/BITS \
sim:/UART_tb/DUT/rx_FIFO/clk \
sim:/UART_tb/DUT/rx_FIFO/DATA_BITS \
sim:/UART_tb/DUT/rx_FIFO/data_in \
sim:/UART_tb/DUT/rx_FIFO/data_out \
sim:/UART_tb/DUT/rx_FIFO/DEPTH \
sim:/UART_tb/DUT/rx_FIFO/empty \
sim:/UART_tb/DUT/rx_FIFO/fifo_counter \
sim:/UART_tb/DUT/rx_FIFO/fifo_mem \
sim:/UART_tb/DUT/rx_FIFO/full \
sim:/UART_tb/DUT/rx_FIFO/rd_ptr \
sim:/UART_tb/DUT/rx_FIFO/read_en \
sim:/UART_tb/DUT/rx_FIFO/reset_n \
sim:/UART_tb/DUT/rx_FIFO/wr_ptr \
sim:/UART_tb/DUT/rx_FIFO/write_en
add wave -position insertpoint  \
sim:/UART_tb/DUT/tx_FIFO/BITS \
sim:/UART_tb/DUT/tx_FIFO/clk \
sim:/UART_tb/DUT/tx_FIFO/DATA_BITS \
sim:/UART_tb/DUT/tx_FIFO/data_in \
sim:/UART_tb/DUT/tx_FIFO/data_out \
sim:/UART_tb/DUT/tx_FIFO/DEPTH \
sim:/UART_tb/DUT/tx_FIFO/empty \
sim:/UART_tb/DUT/tx_FIFO/fifo_counter \
sim:/UART_tb/DUT/tx_FIFO/fifo_mem \
sim:/UART_tb/DUT/tx_FIFO/full \
sim:/UART_tb/DUT/tx_FIFO/rd_ptr \
sim:/UART_tb/DUT/tx_FIFO/read_en \
sim:/UART_tb/DUT/tx_FIFO/reset_n \
sim:/UART_tb/DUT/tx_FIFO/wr_ptr \
sim:/UART_tb/DUT/tx_FIFO/write_en




#run -all

