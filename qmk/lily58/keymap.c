#include QMK_KEYBOARD_H

// Layers definitions
enum layer_number {
  _DEFAULT = 0,
  _GAME,
  _LOWER,
  _RAISE,
  _MASH,
  _SNIPE,
};

// Aliases
#define KC_ KC_TRNS                 // Blank keys will inherit from previous layer
#define KC_xx KC_NO                 // Completely disable key with `xx`
#define KC_DFLT DF(_DEFAULT)        // Switch to default layer
#define KC_GAME DF(_GAME)           // Switch to game layer
#define KC_LAUN LCAG(KC_SPC)        // App launcher modal
#define KC_TERM LCMD(KC_ESC)        // Summon terminal from anywhere
#define KC_LOWR MO(_LOWER)          // Lower layer
#define KC_RAIS MO(_RAISE)          // Raise layer
#define KC_RAI0 LT(_RAISE, KC_P0)   // Hold to raise, tap for numpad 0
#define KC_CESC LCTL_T(KC_ESC)      // Hold for ctrl, tap for esc
#define KC_SRCH LCMD(KC_SPC)        // Spotlight search
#define KC_SPCL LCTL(KC_LEFT)       // Mission control space left
#define KC_SPCR LCTL(KC_RGHT)       // Mission control space right
#define KC_BROL LAG(KC_LEFT)        // Browser tab left
#define KC_BROR LAG(KC_RGHT)        // Browser tab right
#define KC_ZMIN LCMD(KC_EQL)        // Zoom in
#define KC_ZMOT LCMD(KC_MINS)       // Zoom out
#define KC_ZMRS LCMD(KC_0)          // Zoom reset
#define KC_NAPW LCMD(KC_GRV)        // Focus next application window
#define KC_EMOJ LCMD(LCTL(KC_SPC))  // Emoji picker
#define KC_SCRE LCMD(S(KC_4))       // Screen capture

// Define custom keycodes
enum my_keycodes {
  FOO = SAFE_RANGE,
  KC_SNPE                           // One shot layer to snipe them awkward hotkeys
};

// Layer keymaps
const uint16_t PROGMEM keymaps[][MATRIX_ROWS][MATRIX_COLS] = {

  [_DEFAULT] = LAYOUT_KC(
    // +------+------+------+------+------+------+                      +------+------+------+------+------+------+
          xx  ,  xx  ,  xx  ,  xx  ,  xx  ,  xx  ,                         xx  ,  xx  ,  xx  ,  xx  ,  xx  ,  xx  ,
    // +------+------+------+------+------+------+                      +------+------+------+------+------+------+
         TAB  ,  Q   ,  W   ,  E   ,  R   ,  T   ,                         Y   ,  U   ,  I   ,  O   ,  P   , BSLS ,
    // +------+------+------+------+------+------+                      +------+------+------+------+------+------+
         CESC ,  A   ,  S   ,  D   ,  F   ,  G   ,                         H   ,  J   ,  K   ,  L   , SCLN , QUOT ,
    // +------+------+------+------+------+------+------+        +------+------+------+------+------+------+------+
         LSPO ,  Z   ,  X   ,  C   ,  V   ,  B   , LBRC ,          RBRC ,  N   ,  M   , COMM , DOT  , SLSH , RSPC ,
    // +------+------+------+------+------+------+------/        \------+------+------+------+------+------+------+
                           LCTL , LCMD , LOWR ,  SPC  ,              ENT   , RAIS , BSPC , LOPT
    //                   +------+------+------+------/              \------+------+------+------+
  ),

  [_GAME] = LAYOUT_KC(
    // +------+------+------+------+------+------+                      +------+------+------+------+------+------+
         ESC  ,  1   ,  2   ,  3   ,  4   ,  5   ,                         6   ,  7   ,  8   ,  9   ,  0   , DEL  ,
    // +------+------+------+------+------+------+                      +------+------+------+------+------+------+
              ,      ,      ,      ,      ,      ,                             ,      ,      ,      ,      ,      ,
    // +------+------+------+------+------+------+                      +------+------+------+------+------+------+
         LCTL ,      ,      ,      ,      ,      ,                             ,      ,      ,      ,      ,      ,
    // +------+------+------+------+------+------+------+        +------+------+------+------+------+------+------+
              ,      ,      ,      ,      ,      ,      ,               ,      ,      ,      ,      ,      ,      ,
    // +------+------+------+------+------+------+------+        +------+------+------+------+------+------+------+
                           LWIN , LCTL ,      ,       ,                    ,      ,      ,
    //                   +------+------+------+------/              \------+------+------+------+
  ),

  [_LOWER] = LAYOUT_KC(
    // +------+------+------+------+------+------+                      +------+------+------+------+------+------+
              ,  xx  ,  xx  ,  xx  ,  xx  ,  xx  ,                         xx  ,  xx  ,  xx  ,  xx  ,  xx  ,  xx  ,
    // +------+------+------+------+------+------+                      +------+------+------+------+------+------+
         GRV  , EXLM ,  AT  , HASH , DLR  , PERC ,                        TILD ,  P7  ,  P8  ,  P9  , EQL  , PLUS ,
    // +------+------+------+------+------+------+                      +------+------+------+------+------+------+
         TERM , CIRC , AMPR , ASTR , LAUN , LABK ,                        RABK ,  P4  ,  P5  ,  P6  , MINS , UNDS ,
    // +------+------+------+------+------+------+------+        +------+------+------+------+------+------+------+
         LCBR , BSLS , DOT  , COMM , SNPE , LBRC ,  xx  ,           xx  , RBRC ,  P1  ,  P2  ,  P3  , SLSH , RCBR ,
    // +------+------+------+------+------+------+------/        \------+------+------+------+------+------+------+
                                ,      ,      ,       ,                    , RAI0 ,      ,
    //                   +------+------+------+------/              \------+------+------+------+
  ),

  [_RAISE] = LAYOUT_KC(
    // +------+------+------+------+------+------+                      +------+------+------+------+------+------+
          xx  ,  F1  ,  F2  ,  F3  ,  F4  ,  F5  ,                         F6  ,  F7  ,  F8  ,  F9  , F10  , F11  ,
    // +------+------+------+------+------+------+                      +------+------+------+------+------+------+
          xx  ,  xx  ,  xx  ,  xx  ,  xx  ,  xx  ,                        HOME , PGDN , PGUP , END  ,  xx  , F12  ,
    // +------+------+------+------+------+------+                      +------+------+------+------+------+------+
          xx  ,  xx  ,  xx  ,  xx  ,  xx  ,  xx  ,                        LEFT , DOWN ,  UP  , RGHT ,  xx  ,  xx  ,
    // +------+------+------+------+------+------+------+        +------+------+------+------+------+------+------+
          xx  ,  xx  ,  xx  ,  xx  ,  xx  ,  xx  ,  xx  ,           xx  , MPRV , VOLD , VOLU , MNXT , MUTE , MPLY ,
    // +------+------+------+------+------+------+------+        +------+------+------+------+------+------+------+
                                ,      ,      ,  SRCH ,                    ,      ,      ,
    //                   +------+------+------+------/              \------+------+------+------+
  ),

  [_MASH] = LAYOUT_KC(
    // +------+------+------+------+------+------+                      +------+------+------+------+------+------+
         GAME ,  xx  ,  xx  ,  xx  ,  xx  ,  xx  ,                         xx  ,  xx  ,  xx  ,  xx  ,  xx  ,  xx  ,
    // +------+------+------+------+------+------+                      +------+------+------+------+------+------+
          xx  ,  xx  ,  xx  ,  xx  ,  xx  ,  xx  ,                        SPCL ,  xx  ,  xx  , SPCR ,  xx  ,  xx  ,
    // +------+------+------+------+------+------+                      +------+------+------+------+------+------+
         DFLT ,  xx  ,  xx  ,  xx  ,  xx  ,  xx  ,                        BROL ,  xx  ,  xx  , BROR ,  xx  ,  xx  ,
    // +------+------+------+------+------+------+------+        +------+------+------+------+------+------+------+
          xx  ,  xx  ,  xx  ,  xx  ,  xx  ,  xx  ,  xx  ,           xx  , ZMRS , ZMOT , ZMIN ,  xx  ,  xx  ,  xx  ,
    // +------+------+------+------+------+------+------+        +------+------+------+------+------+------+------+
                                ,      ,      ,       ,                    ,      ,      ,
    //                   +------+------+------+------/              \------+------+------+------+
  ),

  [_SNIPE] = LAYOUT_KC(
    // +------+------+------+------+------+------+                      +------+------+------+------+------+------+
          xx  ,  xx  ,  xx  ,  xx  ,  xx  ,  xx  ,                         xx  ,  xx  ,  xx  ,  xx  ,  xx  ,  xx  ,
    // +------+------+------+------+------+------+                      +------+------+------+------+------+------+
          xx  ,  xx  ,  xx  , EMOJ ,  xx  ,  xx  ,                         xx  ,  xx  ,  xx  ,  xx  ,  xx  ,  xx  ,
    // +------+------+------+------+------+------+                      +------+------+------+------+------+------+
          xx  , NAPW , SCRE ,  xx  ,  xx  ,  xx  ,                         xx  ,  xx  ,  xx  ,  xx  ,  xx  ,  xx  ,
    // +------+------+------+------+------+------+------+        +------+------+------+------+------+------+------+
          xx  ,  xx  ,  xx  ,  xx  ,  xx  ,  xx  ,  xx  ,           xx  ,  xx  ,  xx  ,  xx  ,  xx  ,  xx  ,  xx  ,
    // +------+------+------+------+------+------+------/        \------+------+------+------+------+------+------+
                                ,      ,      ,       ,                    ,      ,      ,
    //                   +------+------+------+------/              \------+------+------+------+
  )

};

// Handle layer changes
layer_state_t layer_state_set_user(layer_state_t state) {
  return update_tri_layer_state(state, _LOWER, _RAISE, _MASH);
}

// Shift backspace to forward delete
const key_override_t delete_key_override = ko_make_basic(MOD_MASK_SHIFT, KC_BSPC, KC_DEL);

// Register global key overrides
const key_override_t **key_overrides = (const key_override_t *[]){
  &delete_key_override,
  NULL
};

// User keycode handling
bool process_record_user(uint16_t keycode, keyrecord_t *record) {
  switch (keycode) {

    // Fix rolling between space cadet shift parens when quickly typing `()`
    case KC_LSPO:
      if (! record->event.pressed && get_mods() & MOD_BIT(KC_RSFT)) {
        tap_code16(KC_LPRN);
        clear_mods();
        return false;
      }
      break;
    case KC_RSPC:
      if (record->event.pressed && get_mods() & MOD_BIT(KC_LSFT)) {
        clear_mods();
        return true;
      }
      break;

    // Fix rolling between MO layer key and OSL keys, when OSL is triggered on MO layer
    case KC_SNPE:
      if (! record->event.pressed) {
        set_oneshot_layer(_SNIPE, ONESHOT_START);
        clear_oneshot_layer_state(ONESHOT_PRESSED);
      }
      break;

    // Clear mods when holding lower layer curly brackets to stop me from shifting shiftable symbols
    case KC_LCBR:
      if (record->event.pressed) {
        clear_mods();
        tap_code16(KC_LCBR);
        return false;
      }
      break;
    case KC_RCBR:
      if (record->event.pressed) {
        clear_mods();
        tap_code16(KC_RCBR);
        return false;
      }
      break;
  }

  return true;
}
