
// Resolution on the X axis for the automata.
float detail = 128.0;

/**
 * ECA rule for the automata.
 * See: https://en.wikipedia.org/wiki/Elementary_cellular_automaton
 */
int rule = 30;

/**
 * How many seconds it should take between updating 
 * a row of cells. This is expected to be a fraction
 * or decimal. Setting this to 0.0 will automatically
 * make this calculate per frame.
 */
float secondsPerUpdate = 1.0/30.0;
// float secondsPerUpdate = 0.0;

/**
 * 0 = Mirroring the A buffer, unscaled and including 
 *     all outer buffer variables. For functional
 *     examination only, an eyesore otherwise.
 * 1 = Basic visualization of the result, which flips
 *     the color palette to black on white and scales
 *     the output to a visible state.
 * 2 = Colorize the 0 cells to their respective "digit,"
 *     or sum of the cells equating to 0 in a row.
 */
int visualizationLevel = 2;

/** 
 * `colorOff` is for a cell that is 0, whilst
 * `colorOn` is for a cell that is 1.
 */
vec3 colorOff = vec3(1.0, 1.0, 1.0);
vec3 colorOn  = vec3(0.0, 0.0, 0.0);

/**
 * The following defines two variables: the amount of 
 * colors to display in visualization, and the array
 * of colors itself, which contains the color values.
 * Each color is defined in RGB format, of which can
 * be set themselves by dividing the whole number by
 * 255. The count must be the same number as the count
 * of values in the array.
 */
const int colorDigitCount = 11;
vec3 colorDigits[11] = vec3[colorDigitCount](
    vec3(1.000, 0.000, 0.000),
    vec3(1.000, 0.545, 0.000),
    vec3(0.918, 1.000, 0.008),
    vec3(0.361, 1.000, 0.000),
    vec3(0.000, 1.000, 0.184),
    vec3(0.012, 1.000, 0.737),
    vec3(0.000, 0.733, 1.000),
    vec3(0.000, 0.180, 1.000),
    vec3(0.361, 0.000, 1.000),
    vec3(0.918, 0.008, 1.000),
    vec3(1.000, 0.000, 0.541)
);

