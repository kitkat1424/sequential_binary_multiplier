# Sequential Binary Multiplier Simulation

This project implements a sequential binary multiplier in Verilog and includes a testbench to simulate its operation. The multiplier uses a simple algorithm to multiply two numbers by repeated addition and shifting.

## Project Structure

- `sequential_binary_multiplier.v`: Verilog module for the sequential binary multiplier.
- `t_sequential_binary_multiplier.v`: Testbench for the sequential binary multiplier.

## Sequential Binary Multiplier

The multiplier uses a state machine with the following states:

- `S_idle`: Idle state, waiting for the `start` signal.
- `S_add`: Adding the multiplicand to the partial product.
- `S_shift`: Shifting the partial product and the multiplier.

### Parameters

- `dp_width`: Width of the datapath (default is 5).

### Ports

- `multiplicand`: Input, the multiplicand for the multiplication.
- `multiplier`: Input, the multiplier for the multiplication.
- `start`: Input, starts the multiplication process.
- `clock`: Input, clock signal.
- `reset_b`: Input, active-low reset signal.
- `ready`: Output, indicates when the multiplier is ready for a new operation.
- `product`: Output, the result of the multiplication.

## Testbench

The `t_sequential_binary_multiplier` module tests the `sequential_binary_multiplier` by running a simulation where it multiplies a series of numbers.

### Testbench Structure

- The clock signal is generated with a period of 10 time units.
- The reset signal is toggled at the beginning of the simulation to initialize the multiplier.
- The `start` signal is asserted after the reset.
- The `multiplicand` and `multiplier` values are incremented in a loop to test various multiplication scenarios.
- The simulation runs for a specified time, which can be adjusted by changing the `initial #2060000 $finish;` statement.

