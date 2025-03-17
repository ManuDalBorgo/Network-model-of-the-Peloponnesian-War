# Network Model of the Peloponnesian War

## Overview
This repository contains a MATLAB simulation that models the dynamics of the Peloponnesian War using network theory, game theory, and historical data. The simulation allows users to explore how city-states might have interacted during this historical conflict, with a focus on resource allocation, strategic decision-making, and territorial conquest.

## Features
- Network-based representation of Greek city-states and their connections
- Resource-based combat system with probabilistic outcomes
- Multiple strategy options for AI decision-making
- Visualization tools for tracking simulation progress
- Customizable parameters to explore different historical scenarios
- GUI interface for interactive simulation exploration

## Requirements
- MATLAB (developed and tested with MATLAB R2017a or newer)
- MATLAB Graph and Network Algorithms toolbox

## Getting Started

### Installation
1. Clone this repository or download the source code
2. Open MATLAB and navigate to the repository folder

### Running the Simulation
There are several ways to run the simulation:

#### Interactive Mode (Recommended for First-Time Users)
```matlab
test_steps
```
This opens a GUI where you can step through the simulation one turn at a time.

#### Visual Demo Mode
```matlab
makegraphics
```
This runs through multiple iterations automatically and saves visualizations.

#### Batch Simulation Mode
```matlab
parameters = setparameters;
results = lotsofruns(parameters);
```
This runs multiple simulations with the current parameters.

## Configuration
Edit `setparameters.m` to modify simulation behavior. Key parameters include:

| Parameter | Description |
|-----------|-------------|
| `strategy` | Attack selection algorithm (0=random, 1=max payoff, 2=probability weighted) |
| `suddendeath` | If 1, conquering one node takes over an entire empire; if 0, conquers single node |
| `gamma` | Determines advantage of larger forces (0.9 default) |
| `delta` | Resource depletion from war (0.05 default) |

## Input Data Files
- `start_state.csv`: Initial configuration of city-states
- `network.csv`: Connections between city-states
- `intermediate_state.csv`: Target state for compatibility checking

## Key Components
- `mapstate.m`: Core class representing the simulation state
- `turnstep.m`: Executes a single simulation step
- `payoffstrategy.m`: Calculates attack payoffs
- `evaluateattack.m`: Determines combat outcomes

## Citation
If you use this model in your research, please cite:
Dal Borgo, Manu 2025. "The Economics of Conflict in the Ancient Greek Mediterranean" in 'The Economics of War in Ancient Greece' edited by M. Dal Borgo and R Konijnendijk, Bloomsbury Press: London.

## Contributing
Contributions are welcome! Please feel free to submit a Pull Request.

## License
[License information to be added]
