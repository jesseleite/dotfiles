#include QMK_KEYBOARD_H

// Layers definitions
enum layer_number {
  _DEFAULT = 0,
  _GAME,
  _LOWER,
  _RAISE,
  _ADJUST,
};

// Aliases
#define KC_ KC_TRNS                // Blank keys will inherit from previous layer
#define KC_xx KC_NO                // Completely disable key with `xx`
#define KC_DFLT DF(_DEFAULT)       // Switch to default layer
#define KC_GAME DF(_GAME)          // Switch to game layer
#define KC_LOWR MO(_LOWER)         // Lower layer
#define KC_RAIS MO(_RAISE)         // Raise layer
#define KC_CESC LCTL_T(KC_ESC)     // Hold for ctrl, tap for esc
#define KC_TERM LCMD(KC_ESC)       // Summon terminal from anywhere
#define KC_LAUN LCAG(KC_SPC)       // App launcher modal
#define KC_EMOJ LCMD(LCTL(KC_SPC)) // Emoji picker
#define KC_RAI0 LT(_RAISE, KC_P0)  // Hold to raise, tap for 0
#define KC_SRCH LCMD(KC_SPC)       // Spotlight search
#define KC_BROL LAG(KC_LEFT)       // Browser tab left
#define KC_BROR LAG(KC_RGHT)       // Browser tab right
#define KC_SPCL LCTL(KC_LEFT)      // Mission control space left
#define KC_SPCR LCTL(KC_RGHT)      // Mission control space right

// Layer keymaps
const uint16_t PROGMEM keymaps[][MATRIX_ROWS][MATRIX_COLS] = {

  [_DEFAULT] = LAYOUT_KC(
    // +------+------+------+------+------+------+                      +------+------+------+------+------+------+
         GRV  ,  1   ,  2   ,  3   ,  4   ,  5   ,                         6   ,  7   ,  8   ,  9   ,  0   , DEL  ,
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
         ESC  ,      ,      ,      ,      ,      ,                             ,      ,      ,      ,      ,      ,
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
              ,  xx  ,  xx  ,  xx  ,  xx  ,  xx  ,                        GRV  ,  7   ,  8   ,  P9  , EQL  , BSLS ,
    // +------+------+------+------+------+------+                      +------+------+------+------+------+------+
         TERM ,  xx  ,  xx  ,  xx  , LAUN , LABK ,                        RABK ,  4   ,  5   ,  6   , MINS , QUOT ,
    // +------+------+------+------+------+------+------+        +------+------+------+------+------+------+------+
              ,  xx  ,  xx  ,  xx  ,  xx  , LPRN , LCBR ,          RCBR , RPRN ,  1   ,  2   ,  3   , SLSH , EMOJ ,
    // +------+------+------+------+------+------+------/        \------+------+------+------+------+------+------+
                                ,      ,      ,       ,                    , RAI0 ,      ,
    //                   +------+------+------+------/              \------+------+------+------+
  ),

  [_RAISE] = LAYOUT_KC(
    // +------+------+------+------+------+------+                      +------+------+------+------+------+------+
              ,  F1  ,  F2  ,  F3  ,  F4  ,  F5  ,                         F6  ,  F7  ,  F8  ,  F9  , F10  , F11  ,
    // +------+------+------+------+------+------+                      +------+------+------+------+------+------+
              ,  xx  ,  xx  ,  xx  ,  xx  ,  xx  ,                        HOME , PGDN , PGUP , END  ,  xx  , F12  ,
    // +------+------+------+------+------+------+                      +------+------+------+------+------+------+
              ,  xx  ,  xx  ,  xx  ,  xx  ,  xx  ,                        LEFT , DOWN ,  UP  , RGHT ,  xx  ,  xx  ,
    // +------+------+------+------+------+------+------+        +------+------+------+------+------+------+------+
              ,  xx  ,  xx  ,  xx  ,  xx  ,  xx  , BROL ,          BROR , MPRV , VOLD , VOLU , MNXT , MUTE , MPLY ,
    // +------+------+------+------+------+------+------+        +------+------+------+------+------+------+------+
                                ,      ,      ,  SRCH ,                    ,      ,      ,
    //                   +------+------+------+------/              \------+------+------+------+
  ),

  [_ADJUST] = LAYOUT_KC(
    // +------+------+------+------+------+------+                      +------+------+------+------+------+------+
         GAME ,  xx  ,  xx  ,  xx  ,  xx  ,  xx  ,                         xx  ,  xx  ,  xx  ,  xx  ,  xx  ,  xx  ,
    // +------+------+------+------+------+------+                      +------+------+------+------+------+------+
          xx  ,  xx  ,  xx  ,  xx  ,  xx  ,  xx  ,                         xx  ,  xx  ,  xx  ,  xx  ,  xx  ,  xx  ,
    // +------+------+------+------+------+------+                      +------+------+------+------+------+------+
         DFLT ,  xx  ,  xx  ,  xx  ,  xx  ,  xx  ,                         xx  ,  xx  ,  xx  ,  xx  ,  xx  ,  xx  ,
    // +------+------+------+------+------+------+------+        +------+------+------+------+------+------+------+
          xx  ,  xx  ,  xx  ,  xx  ,  xx  ,  xx  , SPCL ,          SPCR ,  xx  ,  xx  ,  xx  ,  xx  ,  xx  ,  xx  ,
    // +------+------+------+------+------+------+------+        +------+------+------+------+------+------+------+
                                ,      ,      ,       ,                    ,      ,      ,
    //                   +------+------+------+------/              \------+------+------+------+
  )

};

// Handle layer changes
layer_state_t layer_state_set_user(layer_state_t state) {
  return update_tri_layer_state(state, _LOWER, _RAISE, _ADJUST);
}

// Shift backspace to forward delete
const key_override_t delete_key_override = ko_make_basic(MOD_MASK_SHIFT, KC_BSPC, KC_DEL);

// Register global key overrides
const key_override_t **key_overrides = (const key_override_t *[]){
  &delete_key_override,
  NULL
};

// Define custom keycodes
// enum my_keycodes {
//   FOO = SAFE_RANGE,
//   BAR,
// };

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

  }
  return true;
}
