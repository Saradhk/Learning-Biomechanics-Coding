## 🚶‍♂️ Gait Analysis & Biomechanical Feature Extraction
This repository contains a specialized MATLAB toolset developed to process and analyze human locomotion data. The project transforms raw kinematic data from SimTK/OpenSim into clinical gait parameters.

## 🚀 Key Technical Features
**1. Automated Event Detection**
* **Heel-Strike (HS) Detection:**  Uses peak detection on Hip Flexion signals to segment individual gait cycles.

* **Toe-Off (TO) Estimation:** Implements a kinematic-based approach using Knee Angular Velocity. The algorithm identifies the TO point 5% prior to the peak flexion velocity during the swing initiation, proving more accurate than traditional hip-extension methods.

**2. Data Normalization & Statistics**
* **Temporal Normalization:** Each stride is resampled to a 100-point vector (0-100% of the gait cycle) using linear interpolation (interp1).
* **Ensemble Averaging:** Calculates the Mean and Standard Deviation (SD) across all identified strides to create a representative gait profile.

**3. Clinical Symmetry Analysis**
* Calculates the Symmetry Index (SI) between the right and Left knee peak flexion.
* Includes a built-in interpreter for clinical significance (based on a 10% asymmetry threshold).

**4. Advanced Visualization**
* Generates Mean ± SD shaded area plots (using fill) to visualize gait stability and variability. [Gait Analysis Output!](Gait_Analysis_Project/Figures/Knee_Angle_Mean_SD_left_leg.png)
* Automatic phase labeling (STANCE vs. SWING) on the kinematic plots.

## 📊 Data Source & Attribution
The data used in this project is sourced from **SimTK**, a protected repository for biomedical simulation and biomechanics projects.

* **Reference Paper:** Liu, M.Q., Anderson, F.C., Schwartz, M.H. and Delp, S.L., Muscle contributions to support and progression over a range of walking speeds, Journal of Biomechanics, Nov 2008, 41(15):3243-3252. (2008)
* **Source Platform:** [SimTK Project Link](https://simtk.org/projects/mspeedwalksims)
* **Specific Data Used:** Analysis was performed on a specific trial file (`GIL01_static.mot`) from the original dataset.

### ⚖️ Terms of Use
The dataset is used in accordance with the license provided by the authors on SimTK for research and educational purposes. To respect the original creators' copyright, the raw data file is not redistributed here. 
To reproduce the results, please download the original data from the link above.

## 🛠 Future Roadmap
[ ] Signal Filtering: Implement a 4th-order zero-phase Butterworth low-pass filter to handle skin-marker artifacts.

[ ] Spatio-temporal parameters: Add calculation for Cadence and Stride Length.
