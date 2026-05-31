# Peripheral Nerve Stimulation – Electrode Comparison (CUFF, TIME, AIR)

## Overview

This project investigates and compares three different peripheral nerve stimulation electrode architectures:

- **CUFF Electrode** (Extraneural)
- **TIME Electrode** (Transverse Intrafascicular Multichannel Electrode)
- **AIR Electrode** (Adaptable Intrafascicular Radial Electrode)

The study was conducted through computational modeling and finite element simulations to evaluate the trade-off between invasiveness, selectivity, stimulation efficiency, and sensing capabilities.

---

## Authors

- Filippo Aspi
- Andrea Goriani

---

## Background

Peripheral nerve stimulation is a key technology for:

### Therapeutic Neuromodulation
- Epilepsy treatment
- Heart rate regulation through vagus nerve stimulation
- Bladder contraction control
- Sexual function restoration

### Sensory Restoration
- Tactile feedback for amputees
- Proprioceptive feedback
- Advanced neuroprosthetics

Different electrode architectures offer different compromises between safety, selectivity, and implantation complexity.

---

## Project Objectives

The project aims to:

1. Model peripheral nerve and electrode geometries.
2. Develop finite element simulations using COMSOL and MATLAB.
3. Investigate the physical mechanisms underlying neural stimulation.
4. Compare electrode performance under identical simulation conditions.

---

## Simulation Workflow

```text
Geometry Generation (MATLAB)
          ↓
Material Assignment
          ↓
Boundary Conditions
          ↓
Mesh Generation
          ↓
FEM Solver
     ↙       ↘
Static      Time-Dependent
     ↓            ↓
Electric    Axonal Activation
Potential   (Hodgkin-Huxley)
```

---

## Nerve Model

### Tissue Conductivities

| Tissue | Conductivity (S/m) |
|----------|----------|
| Saline | 2.0 |
| Epineurium | 0.083 |
| Endoneurium | 0.083 / 0.571 |
| Perineurium | 0.0009 |

### Main Features

- Five fascicles with varying dimensions
- Parametric geometry generation
- MATLAB–COMSOL integration
- Perineurium modeled as contact impedance
- Grounded saline boundaries
- Adaptive mesh refinement near electrodes and fascicles

---

## Mathematical Models

### Volume Conductor Theory

At low frequencies biological tissues are assumed purely resistive.

The electrical potential distribution is obtained from:


which derives from:

- Charge conservation
- Ohm's law

This allows visualization of current flow and stimulation selectivity inside the nerve.

---

### Hodgkin-Huxley Axon Model

Neural activation is modeled through the classical Hodgkin-Huxley framework.

The model describes:

- Sodium channel activation (m)
- Sodium channel inactivation (h)
- Potassium channel activation (n)

Combined with the cable equation, it allows simulation of:

- Action potentials
- Membrane currents
- Extracellular potentials

---

# Electrode Architectures

## 1. CUFF Electrode

### Characteristics

- Extraneural
- Wrapped around the epineurium
- No tissue penetration

### Materials

| Component | Material |
|------------|------------|
| Support | Silicone |
| Contacts | Platinum |

### Configuration

- 8 platinum contacts
- Contact size: 0.05 × 0.5 mm

### Advantages

- Safe implantation
- Minimal tissue damage
- High long-term stability

### Limitations

- Low spatial selectivity
- Difficult stimulation of deep fascicles

---

## 2. TIME Electrode

### Characteristics

Transverse Intrafascicular Multichannel Electrode

### Materials

| Component | Material |
|------------|------------|
| Substrate | Polyimide |
| Contacts | Platinum |

### Configuration

- 10 active sites
- Contact diameter: 60 μm
- Shank thickness: 20 μm

### Advantages

- High local selectivity
- Direct fascicle access

### Limitations

- Invasive implantation
- Surgical complexity
- Interface modeling challenges

---

## 3. AIR Electrode

### Characteristics

Adaptable Intrafascicular Radial Electrode

### Materials

| Component | Material |
|------------|------------|
| Substrate | Polyimide |
| Contacts | Platinum |

### Configuration

- 8 primary contacts + 4 auxiliary contacts
- Spike height: 450 μm

### Advantages

- Radial architecture improves stability
- Multiple active sites
- Flexible stimulation patterns

### Limitations

- Greater fascicle penetration
- Potential electric field dispersion

---

# Simulation Studies

For each electrode the following analyses were performed:

## Static Studies

### Monopolar Stimulation

Current amplitudes:

- 1 mA
- 3 mA
- 5 mA
- 7 mA
- 10 mA
- 15 mA

### Multipolar Stimulation

Multiple active contacts with neighboring contacts used as grounds.

---

## Time-Dependent Studies

### Action Potentials

Biphasic stimulation waveforms were adopted to minimize tissue damage.

### Membrane Current Analysis

Evaluation of induced transmembrane currents and activation dynamics.

### Extracellular Sensing

Potential measurements performed:

- Inside the fascicle
- Outside the fascicle

Results highlight the shielding effect of the perineurium on extracellular recordings.

---

# Results Comparison

| Feature | CUFF | TIME | AIR |
|----------|----------|----------|----------|
| Invasiveness | Low | High | Medium |
| Contacts | 8 | 10 | 8 + 4 |
| Selectivity | Low | High | High |
| Surgical Complexity | Low | High | Medium |
| Fascicle Access | Peripheral | Direct | Direct |
| Clinical Risk | Low | High | Medium |

---

# Key Findings

## CUFF Electrode

✔ High peripheral selectivity

✔ Non-invasive

✔ Excellent safety profile

✖ Poor access to deeper fascicles

✖ Limited spatial resolution

---

## TIME Electrode

✔ Excellent local selectivity

✔ Direct fascicle targeting

✖ Highly invasive

✖ Sensitive to implantation positioning

✖ Interface-related simulation issues

---

## AIR Electrode

✔ Improved stability through radial design

✔ Multiple tunable stimulation sites

✔ High selectivity

✖ Greater tissue penetration

✖ Potential electric field dispersion

---

# Future Work

- Simulate additional electrode architectures.
- Refine AIR geometries.
- Increase the number of modeled axons.
- Reconstruct complete nerve anatomy from histological images.
- Investigate closed-loop sensing configurations.
- Use one electrode architecture as a sensing probe.

---

## Reference

Ciotti, F., Cimolato, A., Valle, G., & Raspopovic, S. (2023).

*Design of an Adaptable Intrafascicular Electrode (AIR) for Selective Nerve Stimulation by Model-Based Optimization.*

PLOS Computational Biology, 19(5), e1011184.

---

## Acknowledgments

This project combines computational neuroscience, finite element modeling, and neural engineering to explore next-generation peripheral nerve interfaces for neuroprosthetic and neuromodulation applications.
