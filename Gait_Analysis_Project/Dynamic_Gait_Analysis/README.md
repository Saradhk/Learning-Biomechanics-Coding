# Dynamic Gait Kinematics (IK-Based Analysis)

## Project Overview
This folder represents the final refined analysis using **Inverse Kinematics (IK)** data from `GIL01_slow3_ik.mot` files. This analysis captures the real walking patterns of a 10-year-old subject.

## Refinements & Technical Changes
1. **Data Source:** Switched to OpenSim-generated `GIL01_slow3_ik.mot` files (IK results) for high-fidelity joint angles.
2. **Advanced Heel Strike Detection (Knee-Based):**
   - **Logic Change:** Unlike the static trial, we utilized **Knee Extension** to find Heel Strikes.
   - **Method:** Applied a negative transform (`-Knee_Angle`) to find the **minima** (valleys). Since the knee is at maximum extension (near 0°) during heel strike, this method is more robust for IK data than hip peaks.
3. **Toe-Off Calculation:** - Improved by using Knee Flexion dynamics. The transition from stance to swing is identified where the knee reaches peak flexion, providing a subject-specific timing rather than a fixed estimate.
4. **Manual Stride Correction (Left Leg):**
   - **Observation:** The recording for the left leg was truncated, showing only one valid "valley."
   - **Solution:** To maintain the matrix structure and proceed with the symmetry analysis, a manual frame (160) was assigned as the second event to facilitate the exercise.
5. **Spatio-Temporal Analysis (Right Leg Focus):**
   - Stride Length: 0.42 meters
   - Walking Speed: 0.61 m/s
-  **Why only the Right Leg?**
In this specific trial, spatio-temporal parameters were extracted exclusively from the Right Leg data. This decision was made because the Right Leg provided two clear, consecutive Heel Strike events, allowing for a 100% data-driven calculation. The Left Leg data in this specific recording was truncated, requiring a manual frame estimation (Frame 160) for symmetry cycles, which is less reliable for calculating precise physical displacement. By prioritizing the Right Leg, we ensure the integrity and clinical accuracy of the reported walking speed and stride length.

6. **No Noise Filtering:** To preserve the original signal integrity and observe raw sensor behavior in a static state, no digital filtering (e.g., Butterworth) was applied.

## Results
- **Dynamic ROM:** Successfully captured a natural knee flexion-extension range of ~46 degrees for the right knee and ~64 degrees for the left knee.
- **Visualizations:** The plots clearly distinguish between the stance and swing phases, with shaded standard deviation areas (where multiple strides were available).
