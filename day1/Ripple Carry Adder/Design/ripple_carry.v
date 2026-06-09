module bcd_adder(
    input  [3:0] A,
    input  [3:0] B,
    input  Cin,
    output [3:0] Sum,
    output Cout
);

wire [3:0] temp_sum;
wire c1;
wire correction;

wire [3:0] corrected_sum;
wire c2;

ripple_carry_adder_4bit RCA1(
    .A(A),
    .B(B),
    .Cin(Cin),
    .Sum(temp_sum),
    .Cout(c1)
);

assign correction = c1 | (temp_sum[3] & temp_sum[2]) |
                         (temp_sum[3] & temp_sum[1]);

ripple_carry_adder_4bit RCA2(
    .A(temp_sum),
    .B({1'b0, correction, correction, 1'b0}), // 0110 if correction=1
    .Cin(1'b0),
    .Sum(corrected_sum),
    .Cout(c2)
);

assign Sum  = corrected_sum;
assign Cout = correction;

endmodule
