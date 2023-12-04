#include QMK_KEYBOARD_H

// Layers definitions
enum layer_number {
  _DEFAULT = 0,
  _WINDOWS,
  _LOWER,
  _RAISE,
  _MASH,
};

// Aliases
#define KC_     KC_TRNS             // Blank keys will inherit from previous layer
#define KC_xx   KC_NO               // Completely disable key with `xx`
#define KC_DFLT DF(_DEFAULT)        // Switch to default layer
#define KC_WIN  DF(_WINDOWS)        // Switch to game layer
#define KC_OAPP KC_F13              // App launcher modal
#define KC_MACR KC_F14              // Misc macros modal
#define KC_TERM LCMD(KC_ESC)        // Summon terminal from anywhere
#define KC_LOWR MO(_LOWER)          // Lower layer
#define KC_RAIS MO(_RAISE)          // Raise layer
#define KC_RAI0 LT(_RAISE, KC_P0)   // Hold to raise, tap for numpad 0
#define KC_CESC LCTL_T(KC_ESC)      // Hold for ctrl, tap for esc
#define KC_OTAB LOPT_T(KC_TAB)      // Hold for option, tap for tab
#define KC_SPOT LCMD(KC_SPC)        // Spotlight search
#define KC_SPCL LCTL(KC_LEFT)       // Mission control space left
#define KC_SPCR LCTL(KC_RGHT)       // Mission control space right
#define KC_BROL LAG(KC_LEFT)        // Browser tab left
#define KC_BROR LAG(KC_RGHT)        // Browser tab right
#define KC_ZMIN LCMD(KC_EQL)        // Zoom in
#define KC_ZMOT LCMD(KC_MINS)       // Zoom out
#define KC_ZMRS LCMD(KC_0)          // Zoom reset
#define KC_LSPO SC_LSPO
#define KC_RSPC SC_RSPC

// Layer keymaps
const uint16_t PROGMEM keymaps[][MATRIX_ROWS][MATRIX_COLS] = {

  [_DEFAULT] = LAYOUT_KC(
    // +------+------+------+------+------+------+                      +------+------+------+------+------+------+
          xx  ,  xx  ,  xx  ,  xx  ,  xx  ,  xx  ,                         xx  ,  xx  ,  xx  ,  xx  ,  xx  ,  xx  ,
    // +------+------+------+------+------+------+                      +------+------+------+------+------+------+
         OTAB ,  Q   ,  W   ,  E   ,  R   ,  T   ,                         Y   ,  U   ,  I   ,  O   ,  P   , BSLS ,
    // +------+------+------+------+------+------+                      +------+------+------+------+------+------+
         CESC ,  A   ,  S   ,  D   ,  F   ,  G   ,                         H   ,  J   ,  K   ,  L   , SCLN , QUOT ,
    // +------+------+------+------+------+------+------+        +------+------+------+------+------+------+------+
         LSPO ,  Z   ,  X   ,  C   ,  V   ,  B   ,  xx  ,           xx  ,  N   ,  M   , COMM , DOT  , SLSH , RSPC ,
    // +------+------+------+------+------+------+------/        \------+------+------+------+------+------+------+
                            xx  , LCMD , LOWR ,  SPC  ,              ENT   , RAIS , BSPC ,  xx
    //                   +------+------+------+------/              \------+------+------+------+
  ),

  [_WINDOWS] = LAYOUT_KC(
    // +------+------+------+------+------+------+                      +------+------+------+------+------+------+
         ESC  ,  1   ,  2   ,  3   ,  4   ,  5   ,                         6   ,  7   ,  8   ,  9   ,  0   , DEL  ,
    // +------+------+------+------+------+------+                      +------+------+------+------+------+------+
         TAB  ,      ,      ,      ,      ,      ,                             ,      ,      ,      ,      ,      ,
    // +------+------+------+------+------+------+                      +------+------+------+------+------+------+
         LCTL ,      ,      ,      ,      ,      ,                             ,      ,      ,      ,      ,      ,
    // +------+------+------+------+------+------+------+        +------+------+------+------+------+------+------+
              ,      ,      ,      ,      ,      ,      ,               ,      ,      ,      ,      ,      ,      ,
    // +------+------+------+------+------+------+------+        +------+------+------+------+------+------+------+
                           LALT , LCTL ,      ,       ,                    ,      ,      , LWIN
    //                   +------+------+------+------/              \------+------+------+------+
  ),

  [_LOWER] = LAYOUT_KC(
    // +------+------+------+------+------+------+                      +------+------+------+------+------+------+
              ,  F1  ,  F2  ,  F3  ,  F4  ,  F5  ,                         F6  ,  F7  ,  F8  ,  F9  , F10  ,      ,
    // +------+------+------+------+------+------+                      +------+------+------+------+------+------+
         GRV  , EXLM ,  AT  , HASH , DLR  , PERC ,                        TILD ,  P7  ,  P8  ,  P9  , EQL  , PLUS ,
    // +------+------+------+------+------+------+                      +------+------+------+------+------+------+
         TERM , CIRC , AMPR , ASTR , OAPP , LABK ,                        RABK ,  P4  ,  P5  ,  P6  , MINS , UNDS ,
    // +------+------+------+------+------+------+------+        +------+------+------+------+------+------+------+
         LCBR , BSLS , DOT  , COMM , MACR , LBRC ,      ,               , RBRC ,  P1  ,  P2  ,  P3  , SLSH , RCBR ,
    // +------+------+------+------+------+------+------/        \------+------+------+------+------+------+------+
                                ,      ,      ,       ,                    , RAI0 ,      ,
    //                   +------+------+------+------/              \------+------+------+------+
  ),

  [_RAISE] = LAYOUT_KC(
    // +------+------+------+------+------+------+                      +------+------+------+------+------+------+
              ,  xx  ,  xx  ,  xx  ,  xx  ,  xx  ,                         xx  ,  xx  ,  xx  ,  xx  ,  xx  ,  xx  ,
    // +------+------+------+------+------+------+                      +------+------+------+------+------+------+
              ,  F1  ,  F2  ,  F3  ,  F4  ,  F5  ,                        HOME , PGDN , PGUP , END  ,  xx  ,  xx  ,
    // +------+------+------+------+------+------+                      +------+------+------+------+------+------+
              ,  F6  ,  F7  ,  F8  ,  F9  ,  F10 ,                        LEFT , DOWN ,  UP  , RGHT ,  xx  ,  xx  ,
    // +------+------+------+------+------+------+------+        +------+------+------+------+------+------+------+
              ,  F11 ,  F12 ,  xx  ,  xx  ,  xx  ,  xx  ,           xx  , MPRV , VOLD , VOLU , MNXT , MUTE , MPLY ,
    // +------+------+------+------+------+------+------+        +------+------+------+------+------+------+------+
                                ,      ,      ,  SPOT ,                    ,      ,      ,
    //                   +------+------+------+------/              \------+------+------+------+
  ),

  [_MASH] = LAYOUT_KC(
    // +------+------+------+------+------+------+                      +------+------+------+------+------+------+
         DFLT ,  xx  ,  xx  ,  xx  ,  xx  ,  xx  ,                         xx  ,  xx  ,  xx  ,  xx  ,  xx  , WIN  ,
    // +------+------+------+------+------+------+                      +------+------+------+------+------+------+
          xx  ,  xx  ,  xx  ,  xx  ,  xx  ,  xx  ,                        SPCL ,  xx  ,  xx  , SPCR ,  xx  ,  xx  ,
    // +------+------+------+------+------+------+                      +------+------+------+------+------+------+
          xx  ,  xx  ,  xx  ,  xx  ,  xx  ,  xx  ,                        BROL ,  xx  ,  xx  , BROR ,  xx  ,  xx  ,
    // +------+------+------+------+------+------+------+        +------+------+------+------+------+------+------+
          xx  ,  xx  ,  xx  ,  xx  ,  xx  ,  xx  ,  xx  ,           xx  , ZMRS , ZMOT , ZMIN ,  xx  ,  xx  ,  xx  ,
    // +------+------+------+------+------+------+------+        +------+------+------+------+------+------+------+
                                ,      ,      ,       ,                    ,      ,      ,
    //                   +------+------+------+------/              \------+------+------+------+
  ),

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
  }

  return true;
}
