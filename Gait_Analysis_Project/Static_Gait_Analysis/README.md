# Static Gait Data Analysis (Baseline Calibration)

## Project Overview
This folder contains the initial analysis performed on a static dataset ('GIL01_static.mot'). The primary goal was to test the logic of the gait event detection algorithms before moving to dynamic trials.

## Key Features & Methodology
- **Data Source:** 'GIL01_static.mot' file containing minimal joint movement.
- **Heel Strike Detection (Hip-Based):**
  - Used **Hip Flexion** peaks to identify gait events.
  - Methodology: Searching for local maxima ($pks$) as the hip reaches maximum flexion during a typical step.
- **Toe-Off Estimation:** The toe-off point was calculated dynamically by identifying the specific kinematic change (Max Flexion) in the knee profile, even within the minimal oscillations of the static data.
- **No Noise Filtering:** To preserve the original signal integrity and observe raw sensor behavior in a static state, no digital filtering (e.g., Butterworth) was applied.
- **Signal Processing:** Includes the **Alternative Smoother** method to handle noise in low-amplitude signals.

## Observations
- **Range of Motion (ROM):** The analysis correctly identified a near-zero ROM (<1 degree), confirming the static nature of the data.
- **Inference:** While the code executed perfectly, the lack of displacement confirmed that these sensors were recording a non-moving subject.
