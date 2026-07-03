module counter_props (
    input logic clk,
    input logic rst_n,
    input logic en,
    input logic [3:0] count
);

    // Property 1: Reset behavior
    a_reset: assert property (@(posedge clk) !rst_n |-> count == 0);

    // Property 2: Count behavior
    // When not in reset, if enabled, the count should increment by 1.
    property p_count;
        @(posedge clk) disable iff (!rst_n)
        (en) |=> (count == $past(count) + 1'b1);
    endproperty
    a_count: assert property(p_count);

    // Property 3: Hold behavior
    // When not in reset, if not enabled, the count should remain the same.
    property p_hold;
        @(posedge clk) disable iff (!rst_n)
        (!en) |=> (count == $past(count));
    endproperty
    a_hold: assert property(p_hold);

endmodule

// Bind the properties module to the counter module
bind counter counter_props bind_inst (.*);
