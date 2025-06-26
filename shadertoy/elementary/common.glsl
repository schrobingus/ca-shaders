
// Resolution on the X axis for the automata.
float detail = 64.0;

/**
 * ECA rule for the automata.
 * See: https://en.wikipedia.org/wiki/Elementary_cellular_automaton
 */
int rule = 110;

/**
 * How many seconds it should take between updating 
 * a row of cells. This is expected to be a fraction
 * or decimal. Setting this to 0.0 will automatically
 * make this calculate per frame.
 */
float secondsPerUpdate = 1.0/30.0;

/**
 * 0 = Mirroring the A buffer, unscaled and including 
 *     all outer buffer variables. For functional
 *     examination only, an eyesore otherwise.
 * 1 = Basic visualization of the result, which flips
 *     the color palette to black on white and scales
 *     the output to a visible state.
 */
int visualizationLevel = 1;

/** 
 * `colorOff` is for a cell that is 0, whilst
 * `colorOn` is for a cell that is 1.
 */
vec3 colorOff = vec3(1.0, 1.0, 1.0);
vec3 colorOn = vec3(0.0, 0.0, 0.0);

