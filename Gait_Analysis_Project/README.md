## 🚶‍♂️ Gait Analysis & Biomechanical Feature Extraction
This repository contains a specialized MATLAB toolset developed to process and analyze human locomotion data. The project transforms raw kinematic data from SimTK/OpenSim into clinical gait parameters.

## 🚀 Key Technical Features
**1. Automated Event Detection**
* **Heel-Strike (HS) Detection:**  The system employs an adaptive detection logic. It utilizes Hip Flexion peaks for sensor-based/static trials and Knee Extension minima (via negative transform -Knee_Angle) for high-fidelity IK data, ensuring robust cycle segmentation across different data qualities.

* **Toe-Off (TO) Estimation:** Instead of a fixed 60% threshold, the algorithm dynamically identifies TO by locating the Peak Knee Flexion point. This kinematic-based approach adapts to the subject’s unique movement economy in both static and dynamic conditions.

**2. Data Normalization & Statistics**
* **Temporal Normalization:** Each stride is resampled to a 100-point vector (0-100% of the gait cycle) using linear interpolation (interp1).
* **Ensemble Averaging:** Calculates the Mean and Standard Deviation (SD) across all identified strides to create a representative gait profile.

**3. Clinical Symmetry Analysis**
* Calculates the Symmetry Index (SI) between the right and Left knee peak flexion.
* Includes a built-in interpreter for clinical significance (based on a 10% asymmetry threshold).

**4. Advanced Visualization**
* Generates Mean ± SD shaded area plots (using fill) to visualize gait stability and variability. [Gait Analysis Output!](Gait_Analysis_Project/Figures/Knee_Angle_Mean_SD_left_leg.png)
* Automatic phase labeling (STANCE vs. SWING) on the kinematic plots.

## 🔍 Static vs. Dynamic Benchmarking
During development, the toolset was validated across two distinct data states: 
Static Calibration Trial: Initial testing on static files (GIL01_static.mot) demonstrated the algorithm's stability. While the Range of Motion (ROM) remained <1^, the event detection logic successfully identified minimal postural oscillations. 
Dynamic IK Trial: Final validation used Inverse Kinematics (IK) data from the GIL01_slow3_ik trial. The tool successfully captured a natural ROM of 65^ and segmented the gait cycles for a 10-year-old subject. 
Note on Signal Integrity: To evaluate the raw robustness of the detection logic, all analyses were performed on unfiltered signals. This approach confirmed that the peak-detection algorithms remain accurate even without pre-processing.

## 📊 Data Source & Attribution
The data used in this project is sourced from **SimTK**, a protected repository for biomedical simulation and biomechanics projects.

* **Reference Paper:** Liu, M.Q., Anderson, F.C., Schwartz, M.H. and Delp, S.L., Muscle contributions to support and progression over a range of walking speeds, Journal of Biomechanics, Nov 2008, 41(15):3243-3252. (2008)
* **Source Platform:** [SimTK Project Link](https://simtk.org/projects/mspeedwalksims)
* **Specific Data Used:** Analysis was performed on multiple trials including GIL01_static.mot (Static) and GIL01_slow3_ik.mot (Dynamic/IK).

### ⚖️ Terms of Use
The dataset is used in accordance with the license provided by the authors on SimTK for research and educational purposes. To respect the original creators' copyright, the raw data file is not redistributed here. 
To reproduce the results, please download the original data from the link above.

## 🛠 Future Roadmap

[ ] Spatio-temporal parameters: Add calculation for Cadence and Stride Length.
