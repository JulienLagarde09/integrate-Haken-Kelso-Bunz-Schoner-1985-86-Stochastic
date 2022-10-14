# Integrate the model for a theory of coordination:
Stochastic- Haken-Kelso-Bunz-1985- Schoner et al. 1986. 
See: http://www.scholarpedia.org/article/Haken-Kelso-Bunz_model

This famous theory of human coordination predicted: Critical slowing down
and critical fluctuations, among other dynamical features.
Brought to the front concepts and methods in brain sciences akin to:
- "tipping point" and "early signals"- very fruitful currently
in sciences of complex systems.

A set of Matlab codes to integrate that model at reduced dimensional level (collective variable/ order parameter),
and at the level of the evolution of the components and movement itself using Euler scheme.
Contains 3 systems:
1) HKB relative phase dynamics: Changing parameters controlling stability at the half time. See what happens!
2) HKB coupled oscillators
3) one HKB single oscillator driven by a period force, the frequency (pulsation) of which increases in loops, shows the 1:1 Arnold's tongue


Higham, D. J. (2001). An algorithmic introduction to numerical simulation of stochastic differential equations. SIAM review, 43(3), 525-546.
Numerous textbooks (Riske, Platen, Gardiner, Kloeden, Haken)
Remember: When you integrate a white noise you obtain the Wiener process (Brownian motion)

This could be done (future?) in Julia: see https://diffeq.sciml.ai/stable/tutorials/sde_example/

Noise: HKB driven equation becomes a Langevin equation (stochastic differential eq; SDE)

The basic Euler algo logic:
starts with initial conditions of state (init; thus t = 1 thus y = init), pass it into the ODE to compute
the derivatives of the 1 dimensions ydot
compute the change in state for the next time step (time(i) with dt*ydot and add
it to the initial y(i,:) and add the noise, to get the new y(i+1,:), NOTE the time is
incrementing with the i loop
you get the first y(1,:) with init, the next y(2,:) with the sequence described above, and you do the loop again:
pass y(2,:) in the ODE to get ydot etc to get y(3,:)
