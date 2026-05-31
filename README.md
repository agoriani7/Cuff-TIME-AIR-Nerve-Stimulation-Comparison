# Peripheral Nerve Stimulation (PNS): Computational Modelling & Electrode Comparison (CUFF · TIME · AIR)

## 👥 Authors & Affiliation
* **Filippo Aspi** – Biomedical Engineering
* **Andrea Goriani** – Biomedical Engineering

---

## 📝 Project Overview
This project introduces a comprehensive computational framework for **Peripheral Nerve Stimulation (PNS)**, developed to systematically evaluate, simulate, and compare three state-of-the-art neural electrode architectures:
1. **Extraneural (Cuff Electrode):** Non-invasive, wrapping around the outer nerve sheath.
2. **Intraneural TIME (Transverse Intrafascicular Multichannel Electrode):** Transversely penetrating the nerve.
3. **Intraneural AIR (Adaptable Intrafascicular Radial Electrode):** Optimally shaped radial architecture designed via model-based optimization.

By combining **Finite Element Method (FEM)** macroscopic volume conductor simulations with microscopic **Biophysical Axonal Dynamics (Hodgkin-Huxley & Cable Equation)**, this framework maps the intrinsic trade-offs between surgical invasiveness, structural stability, and spatial stimulation selectivity.

---

## 🎯 Project Objectives
* **Parametric 3D Modelling:** Recreate anatomical representations of peripheral nerves (including distinct fascicles, perineurium, and epineurium) alongside detailed electrode meshes.
* **Volume Conductor Physics:** Map the electric potential fields generated inside the anisotropic tissue under various stimulation paradigms (Monopolar vs. Multipolar/Biphasic).
* **Neural Activation Mapping:** Solve the time-dependent non-linear membrane equations to predict action potential generation and propagate axonal responses.
* **Objective Benchmarking:** Quantitative comparison of CUFF, TIME, and AIR architectures within an identical, highly controlled virtual testing environment.

---

## 🔬 Physics & Theoretical Framework

### 1. Macroscopic Domain: Volume Conductor Theory
At low operational frequencies, peripheral biological tissues can be modeled as purely passive, resistive mediums ($\partial u / \partial t = 0$). Combining the charge conservation law with Ohm's law yields the generalized **Laplace Equation** used to map current propagation in the 3D volume:

$$\nabla \cdot (\sigma \nabla \phi) = 0$$

Where $\sigma$ represents the specific electrical conductivity tensor of the targeted tissue domain, and $\phi$ is the extracellular electric potential.

### 2. Microscopic Domain: Cable Equation & Hodgkin-Huxley Model
To analyze the transmembrane potential ($V_m$) dynamics across unmyelinated axons over time under external electric fields, the framework solves the **Cable Equation**:

$$\frac{\partial V_m(x,t)}{\partial t} = \frac{1}{C_m} \left( \frac{\sigma I_a}{2} \frac{\partial^2 V_m(x,t)}{\partial x^2} + \frac{\sigma I_a}{2} \frac{\partial^2 \phi_O(x,t)}{\partial x^2} - I_{ion}(x,t) \right)$$

The non-linear ionic current ($I_{ion}$) is calculated using the voltage-dependent gating kinetics ($m$, $h$, $n$) from the **Hodgkin-Huxley model**:

$$I_{ion} = \bar{G}_{Na} m^3 h (V_m - V_{Na}) + \bar{G}_K n^4 (V_m - V_K) + \bar{G}_L (V_m - V_L)$$

The gating variables transition kinetics are governed by:
$$\frac{dm}{dt} = \alpha_m(V_m)(1-m) - \beta_m(V_m)m$$
$$\frac{dh}{dt} = \alpha_h(V_m)(1-h) - \beta_h(V_m)h$$
$$\frac{dn}{dt} = \alpha_n(V_m)(1-n) - \beta_n(V_m)n$$

---

## 💻 Simulation Workflow & Pipeline

The execution architecture links **MATLAB** (for parametric scripting, optimization, and post-processing) with **COMSOL Multiphysics** (for FEM heavy-lifting) through an automated pipeline:
