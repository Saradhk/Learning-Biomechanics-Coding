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
5. **No Noise Filtering:** To preserve the original signal integrity and observe raw sensor behavior in a static state, no digital filtering (e.g., Butterworth) was applied.

## Results
- **Dynamic ROM:** Successfully captured a natural knee flexion-extension range of ~46 degrees for the right knee and ~64 degrees for the left knee.
- **Visualizations:** The plots clearly distinguish between the stance and swing phases, with shaded standard deviation areas (where multiple strides were available).
