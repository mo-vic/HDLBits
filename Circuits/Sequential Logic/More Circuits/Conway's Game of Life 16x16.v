module top_module (
    input clk,
    input load,
    input [255:0] data,
    output reg [255:0] q
);

  wire [255:0] upper_left;
  wire [255:0] up;
  wire [255:0] upper_right;
  wire [255:0] left;
  wire [255:0] right;
  wire [255:0] lower_left;
  wire [255:0] down;
  wire [255:0] lower_right;

  reg  [  3:0] count;

  assign up   = {q[239:0], q[255:240]};
  assign down = {q[15:0], q[255:16]};

  generate
    genvar i;
    for (i = 0; i < 16; i = i + 1) begin : split2d
      assign left[16*i+15:16*i] = {q[16*i], q[16*i+15:16*i+1]};
      assign right[16*i+15:16*i] = {q[16*i+14:16*i], q[16*i+15]};
      assign upper_left[16*i+15:16*i] = {up[16*i], up[16*i+15:16*i+1]};
      assign upper_right[16*i+15:16*i] = {up[16*i+14:16*i], up[16*i+15]};
      assign lower_left[16*i+15:16*i] = {down[16*i], down[16*i+15:16*i+1]};
      assign lower_right[16*i+15:16*i] = {down[16*i+14:16*i], down[16*i+15]};
    end
  endgenerate

  integer j;
  always @(posedge clk) begin
    if (load) q <= data;
    else begin
      for (j = 0; j <= 255; j = j + 1) begin
        count = upper_left[j] + up[j] + upper_right[j] + left[j] + right[j] + lower_left[j] + down[j] + lower_right[j];
        case (count)
          4'b0010: q[j] <= q[j];
          4'b0011: q[j] <= 1'b1;
          default: q[j] <= 1'b0;
        endcase
      end
    end
  end

endmodule
