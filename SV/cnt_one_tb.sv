`define HALF_PERIOD_SYS_CLK 5

module cnt_one_tb();
logic clk;
logic[31:0] data;
logic data_valid;
logic counter_reset;
logic[5:0] counter_result;

logic [3199:0] ram_data;
logic [99:0] ram_valid;
//assign seed=`SEED;

class index_rand;
	rand bit [3:0] index;
endclass : index_rand

index_rand index_v,index_d;

initial begin
	ram_valid=100'b0;
	repeat(25) begin
		index_v=new();
		index_v.randomize();
		ram_valid=ram_valid+index_v.index;
		ram_valid=ram_valid<<4;
	end
end
initial begin
	ram_data=3200'b0;
	repeat(800) begin
		index_d=new();
		index_d.randomize();
		ram_data=ram_data+index_d.index;
		ram_data=ram_data<<4;
	end
end


initial begin
	clk <= 1'b0;
	forever begin
		#`HALF_PERIOD_SYS_CLK clk <= 1'b1;
    	#`HALF_PERIOD_SYS_CLK clk <= 1'b0;
	end
end

initial begin
	for (int i = 0; i < 100; i++) begin
		/* code */
		data[31:0]=ram_data[32*i +: 32];
		data_valid=ram_valid[i];
		repeat(5) @(negedge clk);
	end
end

initial begin
	counter_reset=1'b1;
	repeat(5) @(negedge clk);
	counter_reset=1'b0;
	repeat(2) @(negedge clk);
	counter_reset=1'b1;
end

count_ones i_counter(
	.clk           (clk),
	.data          (data),
	.data_valid    (data_valid),
	.counter_reset (counter_reset),
	.counter_result(counter_result)
);

endmodule