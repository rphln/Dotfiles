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
  _QWERTY,
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
#define KC_QWER (DF(_QWERTY))
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
             TAB  , Q    , W    , F    , P    , B    ,               J    , L    , U    , Y    , SCLN , BSPC ,
        // ├──────┼──────┼──────┼──────┼──────┼──────┤             ├──────┼──────┼──────┼──────┼──────┼──────┤
             ESC  , A    , R    , S    , T    , G    ,               M    , N    , E    , I    , O    , ENT  ,
        // ├──────┼──────┼──────┼──────┼──────┼──────┤             ├──────┼──────┼──────┼──────┼──────┼──────┤
             LCTL , Z    , X    , C    , D    , V    ,               K    , H    , COMM , DOT  , SLSH , RCTL ,
        // ╰──────┴──────┴──────┴────┬─┴────┬─┴────┬─┴────╮   ╭────┴─┬────┴─┬────┴─┬────┴──────┴──────┴──────╯
                                       LWIN , LOW  , SPC  ,     LSFT , RAI  , LALT
        //                           ╰──────┴──────┴──────╯   ╰──────┴──────┴──────╯
        ),
    [_QWERTY] = LAYOUT_kc(
        // ╭──────┬──────┬──────┬──────┬──────┬──────╮             ╭──────┬──────┬──────┬──────┬──────┬──────╮
             TAB  , Q    , W    , E    , R    , T    ,               Y    , U    , I    , O    , P    , BSPC ,
        // ├──────┼──────┼──────┼──────┼──────┼──────┤             ├──────┼──────┼──────┼──────┼──────┼──────┤
             ESC  , A    , S    , D    , F    , G    ,               H    , J    , K    , L    , SCLN , ENT  ,
        // ├──────┼──────┼──────┼──────┼──────┼──────┤             ├──────┼──────┼──────┼──────┼──────┼──────┤
             LCTL , Z    , X    , C    , V    , B    ,               N    , M    , COMM , DOT  , SLSH , RCTL ,
        // ╰──────┴──────┴──────┴────┬─┴────┬─┴────┬─┴────╮   ╭────┴─┬────┴─┬────┴─┬────┴──────┴──────┴──────╯
                                       LWIN , LOW  , SPC  ,     LSFT , RAI  , LALT
        //                           ╰──────┴──────┴──────╯   ╰──────┴──────┴──────╯
        ),
    [_LOWER] = LAYOUT_kc(
        // ╭──────┬──────┬──────┬──────┬──────┬──────╮             ╭──────┬──────┬──────┬──────┬──────┬──────╮
                  , PGUP , HOME , UP   , END  ,      ,                    , 7    , 8    , 9    ,      , DEL  ,
        // ├──────┼──────┼──────┼──────┼──────┼──────┤             ├──────┼──────┼──────┼──────┼──────┼──────┤
                  , PGDN , LEFT , DOWN , RGHT ,      ,                    , 4    , 5    , 6    , 0    , INS  ,
        // ├──────┼──────┼──────┼──────┼──────┼──────┤             ├──────┼──────┼──────┼──────┼──────┼──────┤
             _    ,      ,      , PSCR , MPLY ,      ,                    , 1    , 2    , 3    ,      , _    ,
        // ╰──────┴──────┴──────┴────┬─┴────┬─┴────┬─┴────╮   ╭────┴─┬────┴─┬────┴─┬────┴──────┴──────┴──────╯
                                       _    , _    , _    ,     _    , _    , _
        //                           ╰──────┴──────┴──────╯   ╰──────┴──────┴──────╯
        ),
    [_RAISE] = LAYOUT_kc(
        // ╭──────┬──────┬──────┬──────┬──────┬──────╮             ╭──────┬──────┬──────┬──────┬──────┬──────╮
             TILD , RCBR , LCBR , DQUO , MINS , PLUS ,               PIPE , AMPR , ASTR , LPRN ,      ,      ,
        // ├──────┼──────┼──────┼──────┼──────┼──────┤             ├──────┼──────┼──────┼──────┼──────┼──────┤
             GRV  , RBRC , LBRC , QUOT , UNDS , EQL  ,               BSLS , DLR  , PERC , CIRC , RPRN ,      ,
        // ├──────┼──────┼──────┼──────┼──────┼──────┤             ├──────┼──────┼──────┼──────┼──────┼──────┤
             _    ,      ,      ,      , INTO ,      ,                    , EXLM , AT   , HASH ,      , _    ,
        // ╰──────┴──────┴──────┴────┬─┴────┬─┴────┬─┴────╮   ╭────┴─┬────┴─┬────┴─┬────┴──────┴──────┴──────╯
                                       _    , _    , _    ,     _    , _    , _
        //                           ╰──────┴──────┴──────╯   ╰──────┴──────┴──────╯
        ),
    [_ADJUST] = LAYOUT_kc(
        // ╭──────┬──────┬──────┬──────┬──────┬──────╮             ╭──────┬──────┬──────┬──────┬──────┬──────╮
             KBD  , OOMK ,      , VOLU ,      ,      ,                    , F7   , F8   , F9   , F11  , RST  ,
        // ├──────┼──────┼──────┼──────┼──────┼──────┤             ├──────┼──────┼──────┼──────┼──────┼──────┤
             CAPS , QUIT , MPRV , VOLD , MNXT ,      ,                    , F4   , F5   , F6   , F10  ,      ,
        // ├──────┼──────┼──────┼──────┼──────┼──────┤             ├──────┼──────┼──────┼──────┼──────┼──────┤
             _    , QWER , ARRW , NMPD , QWFP ,      ,                    , F1   , F2   , F3   , F12  , _    ,
        // ╰──────┴──────┴──────┴────┬─┴────┬─┴────┬─┴────╮   ╭────┴─┬────┴─┬────┴─┬────┴──────┴──────┴──────╯
                                       _    , _    , _    ,     _    , _    , _
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
