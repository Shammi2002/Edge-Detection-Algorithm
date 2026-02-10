# Edge-Detection-Algorithm
EE587 Digital System and Design Synthesis-Sobel Edge Detection (Milestone 1)

This project implements an edge detection algorithm (Sobel filter) in Verilog for behavioral simulation.
Milestone 1 focuses on verifying the Sobel algorithm functionality in simulation (no FPGA/VGA hardware work required yet). 
### What the Sobel Filter Does

The Sobel filter detects edges by computing image intensity gradients in:
    X direction (horizontal changes)
    Y direction (vertical changes)
    A gradient magnitude is then computed per pixel, and typically thresholded or clipped to 8-bit for display/storage.

### Inputs and Outputs (Expected)
    Input: grayscale image (8-bit pixels recommended)
    Output: edge map image (8-bit pixels)

How to Run (Typical Workflow)
    Generate reference output using Python/Matlab:
    Read input image
    Convert to grayscale (if needed)
    Apply Sobel filter
    Save reference output image
    Export the grayscale input image into a .hex file for Verilog simulation

Run Verilog simulation:
    Testbench loads input_image.hex
    Feeds pixels into sobel.v
    Collects output pixels into output_image.hex

Compare results:
    Convert output_image.hex back into an image
    Compare with reference image (visual + numeric comparison)
  
  Report differences (MAE/MSE or pixel mismatch rate)

