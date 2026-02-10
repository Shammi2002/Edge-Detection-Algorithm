# Edge-Detection-Algorithm
EE587 Digital System and Design Synthesis-Sobel Edge Detection (Milestone 1)

This project implements an edge detection algorithm (Sobel filter) in Verilog for behavioral simulation.Milestone 1 focuses on verifying the Sobel algorithm functionality in simulation  

### What the Sobel Filter Does ?
#### The Sobel filter detects edges by computing image intensity gradients in:
        -  X direction (horizontal changes)
        -  Y direction (vertical changes)
        -  A gradient magnitude is then computed per pixel, and typically thresholded or clipped to 8-bit for display

### Inputs and Outputs
        Input: grayscale image (8-bit pixels)
        Output: output image (8-bit pixels)

#### How to Run 
        Convert Input image.png file to input01_image.hex verilog readable file using Python/Matlab(High Level Language) 
        Generate grayscale image using input01_image.hex file
        Save reference image in Edge Detection Algorithm/Edge Detection Algorithm.sim/sim_1/behav/x_sim
        Apply Sobel filter Edge Detection Algorithm on input01_image.hex
        Obtain output.hex file through verilog implementation
        Generate output image.png from obtained output.hex file

####  Run Verilog simulation:
        Testbench loads Reference image.hex
        Feeds pixels into conv_test.v
        Collects output pixels into output image.hex

#### Compare results:
        Convert output image.hex back into an image
        Compare with reference image 
  
 

Reference:
usmanwardag, “GitHub - usmanwardag/sobel: Implementation of Sobel Filter in Verilog,” GitHub, 2025. https://github.com/usmanwardag/sobel/tree/master (accessed Feb. 10, 2026).
‌
