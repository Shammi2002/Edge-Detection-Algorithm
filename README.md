# Sobel Edge Detection Hardware Accelerator 🖼️
## EE587 Digital System and Design Synthesis | Milestone 1

[![Verilog](https://img.shields.io/badge/Language-Verilog-green?style=flat-square)](https://en.wikipedia.org/wiki/Verilog)
[![Tool](https://img.shields.io/badge/Tools-Vivado_/_ModelSim-orange?style=flat-square)](https://www.xilinx.com/products/design-tools/vivado.html)
[![Status](https://img.shields.io/badge/Project--Phase-Milestone--1_Simulation-blue?style=flat-square)]()

### 📌 Project Overview
This project implements a **Sobel Edge Detection Accelerator** in Verilog. Milestone 1 focuses on the **behavioral simulation and functional verification** of the Sobel operator, ensuring accurate gradient computation before moving toward RTL synthesis and hardware implementation.

### 🧠 How the Sobel Filter Works
The Sobel operator detects edges by calculating the image intensity gradient at each pixel. It uses two 3x3 kernels to convolve with the original image:



1.  **Horizontal Gradient ($G_x$):** Detects vertical edges.
2.  **Vertical Gradient ($G_y$):** Detects horizontal edges.
3.  **Gradient Magnitude:** Calculated as $|G| = \sqrt{G_x^2 + G_y^2}$ (often approximated as $|G_x| + |G_y|$ in FPGA hardware to save resources).
4.  **Thresholding:** The result is clipped to an 8-bit value for final display.

---

### 🔌 Inputs and Outputs
* **Input:** Grayscale Image (8-bit pixels, `.hex` format).
* **Output:** Edge-detected Image (8-bit pixels, `.hex` format).

---

### 🚀 Simulation Workflow
The verification process involves a hybrid approach using Python/MATLAB for pre-processing and Verilog for core computation:

1.  **Pre-processing:** Convert `input.png` to `input01_image.hex` (Verilog readable format) using a high-level script.
2.  **Verilog Simulation:**
    * The **Testbench** loads the `.hex` file into memory.
    * Pixels are fed into the `conv_test.v` module.
    * Processed pixels are written back to `output.hex`.
3.  **Post-processing:** Convert the resulting `output.hex` back into a `.png` file to visualize the edges.



---

### 🛠 How to Run
1.  **Prepare Data:** Generate the grayscale `.hex` file from your source image.
2.  **Setup Simulation:** Save the reference image in the simulation directory:  
    `Edge Detection Algorithm/Edge Detection Algorithm.sim/sim_1/behav/x_sim`
3.  **Execute:** Run the behavioral simulation in Vivado or ModelSim.
4.  **Verify:** Convert the generated `output.hex` back into an image and compare it with your high-level reference model.

---

### 📂 Repository Structure
* `/rtl`: Verilog source files (Sobel core, convolution logic).
* `/tb`: Testbench for behavioral simulation.
* `/scripts`: Python/MATLAB scripts for image-to-hex conversion.
* `/sim`: Simulation results and waveforms.

---

### 📚 References
* Implementation based on the hardware architectures discussed in:  
    *usmanwardag, “Implementation of Sobel Filter in Verilog,” GitHub, 2025.*

---
*Developed for EE587: Digital System and Design Synthesis.*
