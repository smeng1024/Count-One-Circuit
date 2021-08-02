module count_ones(
	input [31:0] data,
	input data_valid,
	input counter_reset,
	input clk,

	output reg[4:0] counter_result
	);

//logic data_temp[31:0];
//logic result[4:0];

function reg[4:0] count_one_func(input[31:0] data);
	//input data[31:0];
	reg [5:0] i=6'b0;
	reg [4:0] result=5'b0;
	reg [31:0] data_temp=31'b0;
	begin
		i=6'b0;
		result=5'b0;
		data_temp=31'b0;
		data_temp[31:0]=data[31:0];
		for(i=0;i<32;i++)begin
			result=result+data_temp[0];
			data_temp[31:0]={1'b0,data_temp[31:1]};
		end
		return result;
	end
endfunction : count_one_func

always_ff @(posedge clk or negedge counter_reset) begin : proc_
	if(~counter_reset) begin
		counter_result=5'b0;
		//result=5'b0;
		//data_temp=32'b0;
	end else begin
		counter_result=5'b0;
		if(data_valid)begin
			/*
			result=5'b0;
			data_temp=32'b0;
			data_temp[31:0]=data[31:0];
			for(i=0;i<32;i++)begin
				result=result+data_temp[0];
				data_temp[31:0]={1'b0,data_temp[31:1]};
			end
			counter_result[4:0]=result[4:0];
			*/
			counter_result=count_one_func(data[31:0]);
		end
	end
end
endmodule // count_ones