/* Copyright 2019 Raphael Nepomuceno
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

#include QMK_KEYBOARD_H

enum layer {
  _COLEMAK,
  _LOWER,
  _RAISE,
  _ADJUST,
};

enum custom_keycodes {
  KC_INTO = SAFE_RANGE,
  KC_OOMK,
};

#define KC_ (KC_NO)
#define KC__ (KC_TRNS)

#define KC_RST (RESET)

#define KC_LOW (MO(_LOWER))
#define KC_RAI (MO(_RAISE))

#define KC_ARRW (DF(_RAISE))
#define KC_NMPD (DF(_LOWER))
#define KC_QWFP (DF(_COLEMAK))

// Cycle keyboard layouts on Plasma.
#define KC_KBD (LCTL(LALT(KC_K)))

// `<M-F4>` is hard to reach.
#define KC_QUIT (LALT(KC_F4))

// `KC_SYSREQ` doesn't work.
#define KC_SYSRQ (LALT(KC_PSCR))

const uint16_t PROGMEM keymaps[][MATRIX_ROWS][MATRIX_COLS] = {
    // clang-format off
    [_COLEMAK] = LAYOUT_kc(
        // ╭──────┬──────┬──────┬──────┬──────┬──────╮             ╭──────┬──────┬──────┬──────┬──────┬──────╮
             TAB  , Q    , W    , F    , P    , B    ,               J    , L    , U    , Y    , QUOT , BSPC ,
        // ├──────┼──────┼──────┼──────┼──────┼──────┤             ├──────┼──────┼──────┼──────┼──────┼──────┤
             ESC  , A    , R    , S    , T    , G    ,               M    , N    , E    , I    , O    , ENT  ,
        // ├──────┼──────┼──────┼──────┼──────┼──────┤             ├──────┼──────┼──────┼──────┼──────┼──────┤
             LSPO , Z    , X    , C    , D    , V    ,               K    , H    , COMM , DOT  , SLSH , RSPC ,
        // ╰──────┴──────┴──────┴────┬─┴────┬─┴────┬─┴────╮   ╭────┴─┬────┴─┬────┴─┬────┴──────┴──────┴──────╯
                                       LWIN , LOW  , LCTL ,     SPC  , RAI  , LALT
        //                           ╰──────┴──────┴──────╯   ╰──────┴──────┴──────╯
        ),
    [_LOWER] = LAYOUT_kc(
        // ╭──────┬──────┬──────┬──────┬──────┬──────╮             ╭──────┬──────┬──────┬──────┬──────┬──────╮
             DEL  , PGUP , HOME , UP   , END  ,      ,               PLUS , MINS , LCBR , RCBR , COLN , TILD ,
        // ├──────┼──────┼──────┼──────┼──────┼──────┤             ├──────┼──────┼──────┼──────┼──────┼──────┤
             INS  , PGDN , LEFT , DOWN , RGHT ,      ,               EQL  , UNDS , LBRC , RBRC , SCLN , GRV  ,
        // ├──────┼──────┼──────┼──────┼──────┼──────┤             ├──────┼──────┼──────┼──────┼──────┼──────┤
             _    ,      ,      , PSCR , MPLY ,      ,                    , INTO , BSLS , PIPE ,      , _    ,
        // ╰──────┴──────┴──────┴────┬─┴────┬─┴────┬─┴────╮   ╭────┴─┬────┴─┬────┴─┬────┴──────┴──────┴──────╯
                                       _    , _    , LCTL ,     RCTL , _    , _
        //                           ╰──────┴──────┴──────╯   ╰──────┴──────┴──────╯
        ),
    [_RAISE] = LAYOUT_kc(
        // ╭──────┬──────┬──────┬──────┬──────┬──────╮             ╭──────┬──────┬──────┬──────┬──────┬──────╮
             F12  , F1   , F2   , F3   , F4   , F5   ,               F6   , F7   , F8   , F9   , F10  , F11  ,
        // ├──────┼──────┼──────┼──────┼──────┼──────┤             ├──────┼──────┼──────┼──────┼──────┼──────┤
                  , 1    , 2    , 3    , 4    , 5    ,               6    , 7    , 8    , 9    , 0    ,      ,
        // ├──────┼──────┼──────┼──────┼──────┼──────┤             ├──────┼──────┼──────┼──────┼──────┼──────┤
             _    , EXLM , AT   , HASH , DLR  , PERC ,               CIRC , AMPR , ASTR , LPRN , RPRN , _    ,
        // ╰──────┴──────┴──────┴────┬─┴────┬─┴────┬─┴────╮   ╭────┴─┬────┴─┬────┴─┬────┴──────┴──────┴──────╯
                                       _    , _    , LCTL ,     RCTL , _    , _
        //                           ╰──────┴──────┴──────╯   ╰──────┴──────┴──────╯
        ),
    [_ADJUST] = LAYOUT_kc(
        // ╭──────┬──────┬──────┬──────┬──────┬──────╮             ╭──────┬──────┬──────┬──────┬──────┬──────╮
             KBD  , OOMK ,      , VOLU ,      ,      ,                    ,      ,      ,      ,      , RST  ,
        // ├──────┼──────┼──────┼──────┼──────┼──────┤             ├──────┼──────┼──────┼──────┼──────┼──────┤
             CAPS , QUIT , MPRV , VOLD , MNXT ,      ,                    ,      ,      ,      ,      ,      ,
        // ├──────┼──────┼──────┼──────┼──────┼──────┤             ├──────┼──────┼──────┼──────┼──────┼──────┤
             _    ,      , ARRW , NMPD , QWFP ,      ,                    ,      ,      ,      ,      , _    ,
        // ╰──────┴──────┴──────┴────┬─┴────┬─┴────┬─┴────╮   ╭────┴─┬────┴─┬────┴─┬────┴──────┴──────┴──────╯
                                       _    , _    , LCTL ,     RCTL , _    , _
        //                           ╰──────┴──────┴──────╯   ╰──────┴──────┴──────╯
        ),
    // clang-format on
};

uint32_t layer_state_set_user(uint32_t state) {
  return update_tri_layer_state(state, _LOWER, _RAISE, _ADJUST);
};

bool process_record_user(uint16_t keycode, keyrecord_t *record) {
  switch (keycode) {
  case KC_INTO:
    if (record->event.pressed) {
      SEND_STRING("\n|> ");
    };

    break;

  case KC_OOMK:
    if (record->event.pressed) {
      register_code16(KC_SYSRQ);
      tap_code16(KC_F);
      unregister_code16(KC_SYSRQ);
    };

    break;
  };

  return true;
};
