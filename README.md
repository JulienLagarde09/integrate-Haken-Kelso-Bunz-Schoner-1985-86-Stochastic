The aim of this github is to provide examples of models of coordination dynamics for training purposes.
I made the codes for a french summer school organized by Dr Ghiles MOSTAFAOUI: Le GT8 (Apprentissage et Neurosciences pour la Robotique) du GDR Robotique, 17-20th of October 2022, in the beautiful village net to the ocean of Moliets et Maa, and for a PhD scratch course on coordination dynamics at the EuromovDHM lab in the University of Montpellier, 6-7th of April 2023.

Coordination dynamics is a theory founded by Scott Kelso and Hermann Haken in the 80's, to study the brain- behavior relations from the perspective of complex systems.
It is a theory of self-organized brain functions, using constant exchanges between theory, implemented in explicit models, and experiments.
Here some of the models, notably the HKB model, the excitator model, and a version of the HKB with adaptive frequency, are implemented.
The tools used for the theory and modelling come to a large extent from the field of synergetics, driven by the research of Hermann Haken,
and to sum-up it include low dimensional dynamical systems, and physical statistics to deal with Langevin equations/ stochastic differential equations, and Fokker Planck equations.

Includes:
- The HKB coupled oscillators system
- Solution of the Fokker Planck equation of the order parameter equation of the HKB
- Single HKB oscillator forced by a sine function (representing a "metronome"), which illustrate the theory of Anold's tongues
- Single excitator forced by a discrete beat, in the fixed point (discret) regime
- Two coupled excitators
- Frequency adaptive version of the HKB

1) Simulation of the coupled oscillators of the HKB MODEL implementing a theory of coordination.
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
3) one HKB single oscillator driven by a periodic forcing function (a metronome beat?), the frequency (pulsation) of which increases in loops, shows the 1:1 Arnold's tongue

2) Simulation of discrete and continuous dynamics: The EXCITATOR MODEL 
This Github contains also the stochastic version of the excitator model by Jirsa & Kelso (2005).
In the file: Excit_Euler. Both a single excitator perturbed, and two coupled excitators.

% Jirsa, V. K., & Scott Kelso, J. A. (2005). The excitator 
% as a minimal model for the coordination dynamics of discrete
% and rhythmic movement generation. Journal of motor behavior, 37(1), 35-51.
% Very nice test of the model's prediction: Philip Fink et al.
% Fink, P. W., Kelso, J. S., & Jirsa, V. K. (2009). 
% Perturbation-induced false starts as a test of 
% the Jirsa-Kelso Excitator model. 
% Journal of motor behavior, 41(2), 147-157


3) Simulation of a recent development of the HKB model: The inclusion of frequency adaptation, by Armin Fuchs.
Frequency adaptation is a developement of the theory of coupled, or forced, non linear oscillators.
Several authors have pushed into that direction, Bard Ermentrout in 1991, Loeher Large and Palmer in 2011, Auke Ijpeert and collaborators.

% Nordham, C. A., Tognoli, E., Fuchs, A., & Kelso, J. S. (2018).
% How interpersonal coordination affects individual behavior 
% (and vice versa): experimental analysis and adaptive HKB model of
% social memory. Ecological Psychology, 30(3), 224-249.



Reference about the integration scheme: Higham, D. J. (2001). An algorithmic introduction to numerical simulation of stochastic differential equations. SIAM review, 43(3), 525-546.
Or numerous textbooks (Risken, Platen, Gardiner, Kloeden, Haken). See Ito vs Stratonovitch calculi too.
*Remember: When you integrate a white noise you obtain the Wiener process (Brownian motion)

This could be done (future?) in Julia: see https://diffeq.sciml.ai/stable/tutorials/sde_example/

Noise: HKB driven equation becomes a Langevin equation (stochastic differential eq; SDE)

The basic Euler algo logic:
starts with initial conditions of state (init; thus t = 1 thus y = init), pass it into the ODE to compute
the derivative noted ydot
compute the change in state for the next time step (time(i) with dt*ydot and add
it to the initial y(i,:) and add the noise, to get the new y(i+1,:), NOTE the time is
incrementing with the i loop
you get the first y(1,:) with init, the next y(2,:) with the sequence described above, and you do the loop again:
pass y(2,:) in the ODE to get ydot etc to get y(3,:)
