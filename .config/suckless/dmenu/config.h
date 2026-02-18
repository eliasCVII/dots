/* See LICENSE file for copyright and license details. */
/* Default settings; can be overriden by command line. */

static int topbar = 1; /* -b  option; if 0, dmenu appears at bottom     */
static const unsigned int alpha = 0xc0; /* Amount of opacity. 0xff is opaque */
static int centered = 1;                /* -c option; centers dmenu on screen */
static int min_width = 700;             /* minimum width when centered */
static int max_width = 800;             // Adjust this value as needed

/* -fn option overrides fonts[0]; default X11 font or font set */
static const char *fonts[] = {
    "Hack Nerd Font Mono:style=Bold:size=14:antialias=true:autohint=true"
    // "JoyPixels:style=Bold:pixelsize=14:antialias=true:autohint=true"
};

static const char *prompt =
    NULL; /* -p  option; prompt to the left of input field */
static const char *colors[SchemeLast][2] = {
    /*                            fg         bg       */
    [SchemeNorm] = {"#dadada", "#070700"},
    [SchemeSel] = {"#f8f8f2", "#202020"},
    [SchemeOut] = {"#000000", "#00ffff"},
    [SchemeNormHighlight] = {"#ffffff", "#222222"},
    [SchemeSelHighlight] = {"#ffffff", "#005577"},
    [SchemeOutHighlight] = {"#ffffff", "#00ffff"},
    [SchemeHp] = {"#f38813", "#333333"}};

static const unsigned int alphas[SchemeLast][2] = {
    /*                          fg      bg    */
    [SchemeNorm] = {OPAQUE, alpha},
    [SchemeSel] = {OPAQUE, alpha},
    [SchemeOut] = {OPAQUE, alpha},
    [SchemeNormHighlight] = {OPAQUE, alpha},
    [SchemeSelHighlight] = {OPAQUE, alpha},
    [SchemeOutHighlight] = {OPAQUE, alpha},
    [SchemeHp] = {OPAQUE, alpha}};

/* -l option; if nonzero, dmenu uses vertical list with given number of lines */
static unsigned int lines = 6;

/*
 * Characters not considered part of a word while deleting words
 * for example: " /?\"&[]"
 */
static const char worddelimiters[] = " ";

/* Size of the window border */
static unsigned int border_width = 2;

/* Nav history and search it */
static unsigned int maxhist = 64;
